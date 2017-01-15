trigger CertificationAttemptTrigger2 on Certification_Attempt__c (after insert, after update) {
    
       
    /**
      *  When a new certification attempt object is assigned an 
      *  instructor, or if an instructor changes on an existing 
      *  object, give the new instructor access to the record by 
      *  creating a share object, and remove access for the 
      *  previous instructor (if it is an update of that field)
      */ 
        
    System.debug('Starting the Grant Instructor Sharing Access logic');
    
    // List of share records to insert in bulk
    List<Certification_Attempt__Share> sharesToCreate = new List<Certification_Attempt__Share>();
    
    // List of share records to delete in bulk
    List<Certification_Attempt__Share> sharesToDelete = new List<Certification_Attempt__Share>();
        
    // Map of the CertAttemptID to the Instructor User ID
    Map<Id, Id> certAttemptToInstructorMap = new Map<Id, Id>();

    // Loop through all the records in the trigger
    for ( Certification_Attempt__c certAttempt : Trigger.new ) {
               
        // Check to see if this is an insert or the Instructor has changed
        if (Trigger.isInsert || certAttempt.Certifying_Instructor__c != Trigger.oldMap.get(certAttempt.Id).Certifying_Instructor__c) {
            // Create new Share record for the Instructor and add to list
            if (certAttempt.Certifying_Instructor__c != null) {
                Certification_Attempt__Share certAttemptShare = new Certification_Attempt__Share(
                                    parentId = certAttempt.Id,
                                    userOrGroupId = certAttempt.Certifying_Instructor__c,
                                    rowCause = Schema.Certification_Attempt__Share.RowCause.Certifying_Instructor__c,
                                    accessLevel = 'Edit');
                sharesToCreate.add(certAttemptShare);
            } 
        }
        
        if (Trigger.isUpdate) {
            // See the Instructor has changed
            if ( certAttempt.Certifying_Instructor__c != Trigger.oldMap.get(certAttempt.Id).Certifying_Instructor__c ) {
                // Add to map of Instructor changes
                System.debug('certAttempt.Certifying_Instructor__c is: ' + certAttempt.Certifying_Instructor__c);
                certAttemptToInstructorMap.put(certAttempt.Id, certAttempt.Certifying_Instructor__c);
             }  
        }   
     }
            
     if ( certAttemptToInstructorMap.size() > 0 ) {
         
        System.debug('certAttemptToInstructorMap is: ' + certAttemptToInstructorMap);
         
        for (Certification_Attempt__Share certAttemptShare : 
                                        [SELECT UserOrGroupId, RowCause, ParentId, Id, AccessLevel 
                                           FROM Certification_Attempt__Share 
                                           WHERE ParentId IN :certAttemptToInstructorMap.keySet()
                                             AND RowCause = 'Certifying_Instructor__c']){
            if (certAttemptToInstructorMap.get(certAttemptShare.ParentId) != certAttemptShare.UserOrGroupId){
                sharesToDelete.add(certAttemptShare);
            }
        }
         
     }
            
     try {
        if ( sharesToCreate.size() > 0 ) {
            insert sharesToCreate;
        }
        if ( sharesToDelete.size() > 0) {
                delete sharesToDelete;
        } 
     } catch (System.DmlException ex) {
            System.debug(ex);
     } 
    
}
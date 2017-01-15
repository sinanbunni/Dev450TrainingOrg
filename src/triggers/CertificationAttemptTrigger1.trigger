trigger CertificationAttemptTrigger1 on Certification_Attempt__c (before insert) {
    
    /**
      *  If a Contact is trying to create a Certification Attempt
      *  for an element that was already marked as "Complete/Pass"
      *  or "In Progress", then do not allow the attempt to be
      *  created and pass back an error
      */ 
            
    System.debug('Starting the Validate Certification Attempt Logic');
    
    // All Certification_Attempt__c records which are 'In Progress' OR 'Complete/Pass' will be stored here for comparison purposes
    Set<String> concatStudentElement = new Set<String>();
      
    for(Certification_Attempt__c dbca : [Select Certification_Candidate__c, Certification_Element__c, Status__c 
                                         From Certification_Attempt__c Where Status__c IN ('In Progress', 'Complete/Pass')]){
        // We need to know 1. Which student 2. Which element they have attempted (lab or multiple choice) 3. The status
        concatStudentElement.add((String)dbca.Certification_Candidate__c + (String)dbca.Certification_Element__c + (String)dbca.Status__c);
    }  
        
    for(Certification_Attempt__c ca : trigger.new){
        // If any element is In Progress or Complete/Pass, new attempts should not be allowed for those elements
        if(concatStudentElement.contains((String)ca.Certification_Candidate__c + (String)ca.Certification_Element__c + 'In Progress') || 
           concatStudentElement.contains((String)ca.Certification_Candidate__c + (String)ca.Certification_Element__c + 'Complete/Pass')){
               System.debug('Validation error passed back to user');
               ca.addError('Cannot attempt cert for element already in progress or completed');
           } 
    }
    
}
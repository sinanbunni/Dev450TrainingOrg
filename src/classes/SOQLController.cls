public class SOQLController {
    // The User's input
    public String name {get; set;}
    
    public List<Certification_Held__c> queryResult {get; set;}
    
    public PageReference query() {
    	/** TODO #1:  To sanitize the code below to prevent a SOQL injection do the following:
		 *               -- Copy to the clipboard the entire SOQL statement without the single quotes
		 *               -- Replace the Database.query(qryString) portion of the queryResult property assignment
		 *                  with []
		 *               -- Paste the entire contents of the SOQL statement from the clipboard  
		 *                  between the two square brackets you just created.
		 *               -- Change the WHERE clause of the SOQL Statement to look like the following:
		 *                    WHERE Name = :name LIMIT 1
		 *               -- Comment out or remove the line of code that declares and assigns the qryString variable
		 */                  
        
        queryResult = [SELECT Name, Certified_Professional__r.Name, Certification__r.Name, Certification__r.Number_of_Certified_Professionals__c FROM Certification_Held__c WHERE Name = :name LIMIT 1];
           
        return null;
    }
}
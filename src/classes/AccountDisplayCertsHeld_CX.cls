public with sharing class AccountDisplayCertsHeld_CX {
    /**
     *  This Extension Controller is used to populate
     *  a table of Certifications Held that are
     *  related to a specific Account and displayed
     *  in-line on the detail page for that Account
     */ 
     
	private final Account account;
    
    // Constructor used to get the Account record
    public AccountDisplayCertsHeld_CX(ApexPages.StandardController stdController) {
        this.account = (Account)stdController.getRecord();
    }
       
    public List<Certification_Held__c> results {
        get {
            return [SELECT Id, Name, Date_Achieved__c, Certified_Professional__r.Name
                  FROM Certification_Held__c 
                  WHERE Certified_Professional__r.Account.Id = : account.Id];
        }  
        set;
    }
    
    /**
    public Component.Apex.OutputPanel getList() {
        
        Component.Apex.OutputPanel pan = new Component.Apex.OutputPanel();
        
        for (Certification_Held__c cer : results) {
            Component.Apex.RelatedList rel = new Component.Apex.RelatedList();
            rel.list = (String) cer;
            pan.childComponents.add(rel);
        }
        
        return NULL;
    }  
	 **/
}
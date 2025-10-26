public with sharing class CaseController {
	
    @AuraEnabled(cacheable=true)
    public static list<case> getOpenCase(string accId){
        string query = 'Select Id, CaseNumber,' +
            'AccountId, Account.Name, ContactId, Contact.Name,' +
            'Status, IsClosed, CreatedDate From Case Where IsClosed = false';
        if(accId != null){
            query += ' And AccountId =: accId';
        }
        query += ' Order By CreatedDate Desc Limit 50';
		
        list<Case> caselist = Database.query(query);
        return caselist;
    }

    @AuraEnabled
    public static void updateCaseRecord(list<Id> caseId){
        try {
            list<Case> caseToBeUpdate = new list<Case>();
            for(Id ci : caseId){
                Case cs = new Case();
                cs.Id = ci;
                cs.Status = 'Closed';
                caseToBeUpdate.add(cs);
            }

            if(!caseToBeUpdate.isEmpty()){
                update caseToBeUpdate;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static list<Case> getAllCases(string userId){
        try {
            string query = 'Select Id, CaseNumber, Status, Priority, OwnerId From Case';
            if(userId != null){
                query += ' Where OwnerId =: userId';
            }
            list<Case> caselist = Database.query(query);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
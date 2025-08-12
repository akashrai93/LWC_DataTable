public with sharing class ContactController {
    public ContactController() {

    }

    @AuraEnabled(cacheable=true)
    public static list<OpportunityContactRole> fetchOppConRole(string oppId){
        try {
            return [Select ID, Contact.Name, Role, IsPrimary From OpportunityContactRole Where OpportunityId =: oppId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static list<Contact> fetchContact(){
        try {
            return [Select Id, Name, Email, Phone, AccountId, Account.Name, Title From Contact
                Where title != null];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static list<Contact> fetchRelatedContactAccount(string accountId){
        try {
            return [Select Id, FirstName, LastName, Email, Phone, AccountId From Contact Where AccountId =: accountId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
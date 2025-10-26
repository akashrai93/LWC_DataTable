public with sharing class accountController {
    @AuraEnabled
    public static list<AccountWrapper> getRelatedCount(){
        list<AccountWrapper> accwraplist = new list<AccountWrapper>();
        list<Account> acclist = [Select Id, Name, Industry, Rating,
                                (Select Id From Contacts),
                                (Select Id From Cases),
                                (Select Id From Opportunity)
                                From Account
                                Order By Name];
        for(Account acc : acclist){
            AccountWrapper accwrap = new AccountWrapper();
            accwrap.accountId = acc.Id;
            accwrap.accountName = acc.Name;
            accwrap.accountIndustry = acc.Industry;
            accwrap.accountRating = acc.Rating;
            accwrap.contactCount=acc.Contacts.Size();
            accwrap.caseCount = acc.Cases.Size();
            accwrap.oppCount = acc.Opportunities.size();
            accwraplist.add(accwrap);
        }

        return accwraplist;
    }
    //wrapper class
    public class AccountWrapper{
        @AuraEnabled public Id accountId;
        @AuraEnabled public string accountName;
        @AuraEnabled public string accountIndustry;
        @AuraEnabled public string accountRating;
        @AuraEnabled public Integer contactCount;
        @AuraEnabled public Integer caseCount;
        @AuraEnabled public Integer oppCount;
    }

    
}
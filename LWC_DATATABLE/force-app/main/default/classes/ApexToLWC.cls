public with sharing class ApexToLWC {
    public ApexToLWC() {

    }
    @AuraEnabled(cacheable=true)
    public static list<Account> fetchTopAccount(){
        list<Account> acclist = [Select Id, Name, Industry, Phone,Rating,
            (Select Id, Name, StageName, Amount, LeadSource From Opportunities Where isClosed = false Order by Amount Desc Limit 5 )
        From Account Where AnnualRevenue != null Order By AnnualRevenue Desc Limit 5];

        return acclist;
        
    }
}
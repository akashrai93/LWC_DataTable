public with sharing class OpportunityTriggerHelper {
    
    public static void updateAccountRating(list<Opportunity> opplist, map<Id, Opportunity> oldOppMap){
        if(!opplist.isEmpty()){
            map<Id, Account> accmap = new map<Id, Account>();
            for(Opportunity opp : opplist){
                if(opp.AccountId != null && oldOppMap.get(opp.Id).StageName != opp.StageName && opp.StageName == 'Closed Won'){
                    Account acc = new Account();
                    acc.Id = opp.AccountId;
                    acc.Rating = 'Hot';
                    accmap.put(opp.Id, acc);
                }
            }
           
            if(!accmap.isEmpty()){
                update accmap.values();
                for(Account acc : accmap.values()){
                    system.debug(acc.Name + acc.Rating);
                }
            }
        }
    }

    public static void updateOppCountOnAccount(List<Opportunity> opplist, map<Id, Opportunity> oldOppMap){
        if(!oppList.isEmpty()){
            set<Id> accIds = new set<Id>();
            for(Opportunity opp : opplist){
                if(oldOppMap != null){
                    if(string.isNotBlank(opp.AccountId) && opp.AccountId != oldOppMap.get(opp.Id).AccountId ){
                        if(!opp.IsClosed){
                            accIds.add(opp.AccountId);
                            accIds.add(oldOppMap.get(opp.Id).AccountId);
                            updateAccountOppOpen(accIds);
                        }else if(opp.IsClosed){
                            accIds.add(opp.AccountId);
                            accIds.add(oldOppMap.get(opp.Id).AccountId);
                            updateAccountOppClosed(accIds);
                        }
                    }
                }else if(oldOppMap == null){
                    if(string.isNotBlank(opp.AccountId)){
                        if(!opp.IsClosed){
                            accIds.add(opp.AccountId);
                            updateAccountOppOpen(accIds);
                        }else if(opp.IsClosed){
                            accIds.add(opp.AccountId);
                            updateAccountOppClosed(accIds);
                        }
                    }
                }
            }
        }
    }

    public static void updateAccountOppOpen(set<Id> accIDs){
        system.debug(('open method called'));
        list<AggregateResult> aggr = [Select AccountId, count(Id) totalOpps From Opportunity 
                                        Where AccountId IN: accIDs AND isClosed = false
                                        Group By AccountId];
        list<Account> accountToBeUpdated = new list<Account>();
        for(AggregateResult agg : aggr){
            Id ids = (Id) agg.get('AccountId');
            if(accIDs.contains(ids)){
                Account acc = new Account();
                acc.Id = (Id) agg.get('AccountId');
                acc.Open_Opportunity__c = (Decimal) agg.get('totalOpps');
                accountToBeUpdated.add(acc);
            }
        }
        if(!accountToBeUpdated.isEmpty()){
            update accountToBeUpdated;
        }
    
    }

    public static void updateAccountOppClosed(set<Id> accIDs){
        system.debug(('closed method called'));
        list<AggregateResult> aggr = [Select AccountId, count(Id) totalOpps From Opportunity 
                                        Where AccountId IN: accIDs AND isClosed = true
                                        Group By AccountId];
        list<Account> accountToBeUpdated = new list<Account>();
        for(AggregateResult agg : aggr){
            Id ids = (Id) agg.get('AccountId');
            if(accIDs.contains(ids)){
                Account acc = new Account();
                acc.Id = (Id) agg.get('AccountId');
                acc.Open_Opportunity__c = (Decimal) agg.get('totalOpps');
                accountToBeUpdated.add(acc);
            }
        }
        if(!accountToBeUpdated.isEmpty()){
            update accountToBeUpdated;
        }
    }
}
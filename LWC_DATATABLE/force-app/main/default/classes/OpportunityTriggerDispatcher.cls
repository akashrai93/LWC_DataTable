public with sharing class OpportunityTriggerDispatcher {
    
    public static void run(system.triggerOperation operationType){
        switch on operationType{
            when after_Update{
                OpportunityTriggerHelper.updateAccountRating(trigger.New, (map<Id, Opportunity>)trigger.oldmap);
                OpportunityTriggerHelper.updateOppCountOnAccount(trigger.New, (map<Id, Opportunity>) trigger.oldmap);
            }
            when after_Insert{
                OpportunityTriggerHelper.updateOppCountOnAccount(trigger.New, null);
            }
            when after_Delete{
                OpportunityTriggerHelper.updateOppCountOnAccount(null, (map<Id, Opportunity>) trigger.oldmap);
            }
            when after_Undelete{
                OpportunityTriggerHelper.updateOppCountOnAccount(trigger.New, null);
            }
        }
    }
}
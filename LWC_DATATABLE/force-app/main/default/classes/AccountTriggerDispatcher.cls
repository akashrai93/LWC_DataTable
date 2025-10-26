public class AccountTriggerDispatcher {
	
    public static void run(system.triggerOperation operationType){
        switch on operationType{
            when before_insert{
                //AccountTriggerHelper.updateOfficeAddress(trigger.New,null);
            }
            when after_insert{
                AccountTriggerHelper.updateContactDescriptionWithAccountDescription(trigger.new,null);
                AccounttriggerHelper.createRelatedContact(trigger.new, null);
            }
            when before_update{
                //AccountTriggerHelper.updateOfficeAddress(trigger.New, (Map<Id,Account>)trigger.oldmap);
            }
            when after_update{
                AccountTriggerHelper.updateContactDescriptionWithAccountDescription(trigger.new, (map<Id, Account>)trigger.oldmap);
                AccounttriggerHelper.createRelatedContact(trigger.new, (map<Id, Account>)trigger.oldmap);
               //AccountTriggerHelper.createRecordCustomLocation(trigger.new, (map<Id, Account>)trigger.oldmap);
            }
            when before_delete{
                //AccountTriggerHelper.deleteErrorIfConditionMet(Trigger.old);
                AccountTriggerHelper.deleteAccountAndCase(trigger.old);
            }
            when after_undelete{
                AccountTriggerHelper.updateContactDescriptionWithAccountDescription(trigger.new,null);
            }
        }
    }
}
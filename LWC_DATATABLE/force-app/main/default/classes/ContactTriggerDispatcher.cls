public class ContactTriggerDispatcher {
    
    public static void run(system.triggerOperation operationType){
        switch on operationType{
            when before_insert{
                ContactTriggerHelper.updateContactPhoneOnAccountPhone(trigger.new, null);
            }
            when after_insert{
                ContactTriggerHelper.createAccount(trigger.new);
            }
            when before_update{
                
            }
            when after_update{
                ContactTriggerHelper.updateContactPhoneOnAccountPhone(trigger.new, (map<Id, Contact>)trigger.oldmap);
            }
            when before_delete{
                
            }
            when after_delete{
                //ContactTriggerHelper.updateContactPhoneOnAccountPhone(null, (map<Id, Contact>)trigger.oldmap);
            }
            when after_undelete{
                ContactTriggerHelper.updateContactPhoneOnAccountPhone(trigger.new, null);
            }
        }
    }
}
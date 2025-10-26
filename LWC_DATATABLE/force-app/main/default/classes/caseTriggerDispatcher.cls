public with sharing class caseTriggerDispatcher {
    
    public static void run(system.triggerOperation operationType){
        switch on operationType{
            when before_insert{
                caseTriggerHelper.findContactOnEmail(trigger.New);
            }
        }
    }
}
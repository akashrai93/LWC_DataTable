trigger subscribePlatformEventTrigger on Order_Detail__e (after insert) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            platformEventTriggerHelper.createAccountPlatformTriggerEvent(trigger.New);
        }
    }
}
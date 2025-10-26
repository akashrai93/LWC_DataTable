trigger caseTrigger on Case (before insert) {
    caseTriggerDispatcher.run(Trigger.operationType);
}
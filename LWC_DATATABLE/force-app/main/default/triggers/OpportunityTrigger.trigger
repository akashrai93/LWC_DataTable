trigger OpportunityTrigger on Opportunity (before insert, after update, before delete) {
    OpportunityTriggerDispatcher.run(Trigger.OperationType);
}
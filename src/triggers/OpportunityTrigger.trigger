trigger OpportunityTrigger on Opportunity (after insert, after update) {
    if(OpportunityTriggerHandler.isFirstTime){
        if(!Test.isRunningTest())
        OpportunityTriggerHandler.isFirstTime = false;
        if(trigger.isAfter && trigger.isUpdate) {
            OpportunityTriggerHandler.handleOpportunityAfterUpdate(Trigger.oldMap, Trigger.new);
        }
        if(trigger.isAfter && trigger.isInsert) {
            OpportunityTriggerHandler.handleOpportunityAfterInsert(Trigger.new);
        }
    }
}
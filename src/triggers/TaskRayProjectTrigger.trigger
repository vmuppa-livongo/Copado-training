trigger TaskRayProjectTrigger on TASKRAY__Project__c (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        TaskRayProjectTriggerHandler.handleProjectUpdate(Trigger.oldMap, Trigger.new);
    }
}
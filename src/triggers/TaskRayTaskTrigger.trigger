/**
* A Trigger for the TASKRAY__Project_Task__c (TaskRay Task) object.
* Created : 06/11/2019
* @author Connor Gallaher - Slalom
*/

trigger TaskRayTaskTrigger on TASKRAY__Project_Task__c(after delete) {
    if (Trigger.isDelete && Trigger.isAfter) {
        TaskRayTaskTriggerHandler.handleTaskRayTaskDelete(Trigger.old);
    }
}
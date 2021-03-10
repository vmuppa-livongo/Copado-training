/**
* This class serves as a handler for the TaskRayTask trigger.
* Created : 06/11/2019
* @author Connor Gallaher - Slalom
*/

public class TaskRayTaskTriggerHandler {
    /*
    * Handler for delete trigger.
    */
    public static void handleTaskRayTaskDelete(List<TASKRAY__Project_Task__c> tasks) {
        TaskRayTaskService.postToParentProject(tasks);
    }
}
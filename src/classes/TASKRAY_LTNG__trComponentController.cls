/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trComponentController {
    global trComponentController() {

    }
    @AuraEnabled
    global static List<TASKRAY_LTNG.trLightningComponentDataProvider.projectWrapper> getItemsForRecordId(Id recordId) {
        return null;
    }
    @AuraEnabled
    global static TASKRAY_LTNG.trComponentController.kanbanBoardWrapper getKanbanBoardInfo(Id recordId) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY_LTNG.trComponentController.projectCountWrapper> getStatCounts(Id recordId) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY_LTNG.trComponentController.projectOutsideWrapper> getTaskByStatCountAndList(Id recordId) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY_LTNG.trComponentController.projectViewsWrapper> getTaskCountsByList(Id recordId) {
        return null;
    }
    @AuraEnabled
    global static TASKRAY_LTNG.trComponentController.kanbanBoardWrapper handleTaskMove(String itemsToUpdate, Id recordId) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY_LTNG.trComponentController.projectOutsideWrapper> markTaskComplete(Id taskId, Id recordId) {
        return null;
    }
    @AuraEnabled
    global static Integer updateTasksAfterChange(List<Map<String,String>> allRecords) {
        return null;
    }
global class kanbanBoardWrapper {
    global List<String> listOptions {
        get;
        set;
    }
    global List<TASKRAY_LTNG.trLightningComponentDataProvider.projectWrapper> projects {
        get;
        set;
    }
    global kanbanBoardWrapper(List<TASKRAY_LTNG.trLightningComponentDataProvider.projectWrapper> projects) {

    }
}
global class listCountWrapper {
    global Boolean complete {
        get;
        set;
    }
    global Decimal percentage {
        get;
        set;
    }
    global Id projectId {
        get;
        set;
    }
    global String projectName {
        get;
        set;
    }
    global Integer taskCount {
        get;
        set;
    }
    global listCountWrapper(String projectName, Id projectId, Boolean complete, Decimal percentage, Integer taskCount) {

    }
}
global class listSortWrapper {
    global String listName {
        get;
        set;
    }
    global String projectName {
        get;
        set;
    }
    global Integer taskCount {
        get;
        set;
    }
    global listSortWrapper(String projectName, String listName, Integer taskCount) {

    }
}
global class projectCountWrapper {
    global String projectId {
        get;
        set;
    }
    global String projectName {
        get;
        set;
    }
    global List<TASKRAY_LTNG.trComponentController.statCountWrapper> statList {
        get;
        set;
    }
    global projectCountWrapper(String projectName, String projectId, List<TASKRAY_LTNG.trComponentController.statCountWrapper> statList) {

    }
}
global class projectOutsideWrapper {
    global List<TASKRAY_LTNG.trComponentController.listSortWrapper> columnList {
        get;
        set;
    }
    global List<String> listOptions {
        get;
        set;
    }
    global Id projectId {
        get;
        set;
    }
    global String projectName {
        get;
        set;
    }
    global List<TASKRAY_LTNG.trComponentController.projectTasksWrapper> projectTasks {
        get;
        set;
    }
    global List<TASKRAY_LTNG.trComponentController.statSortWrapper> statList {
        get;
        set;
    }
    global projectOutsideWrapper(String projectName, Id projectId, List<TASKRAY_LTNG.trComponentController.listSortWrapper> columnList, List<TASKRAY_LTNG.trComponentController.statSortWrapper> statList, List<TASKRAY_LTNG.trComponentController.projectTasksWrapper> projectTasks) {

    }
}
global class projectTasksWrapper {
    global Date deadline {
        get;
        set;
    }
    global String deadlineFormatted {
        get;
        set;
    }
    global Boolean isComplete {
        get;
        set;
    }
    global String listName {
        get;
        set;
    }
    global String ownerFirstName {
        get;
        set;
    }
    global Id ownerId {
        get;
        set;
    }
    global Id taskId {
        get;
        set;
    }
    global String taskName {
        get;
        set;
    }
    global String timeGroup {
        get;
        set;
    }
    global projectTasksWrapper(String taskName, Id taskId, Id ownerId, String ownerFirstName, String timeGroup, String listName, Date deadline, Boolean isComplete) {

    }
}
global class projectViewsWrapper {
    global Date projectEnd {
        get;
        set;
    }
    global String projectEndFormatted {
        get;
        set;
    }
    global String projectId {
        get;
        set;
    }
    global List<TASKRAY_LTNG.trComponentController.listCountWrapper> projectList {
        get;
        set;
    }
    global String projectName {
        get;
        set;
    }
    global Date projectStart {
        get;
        set;
    }
    global String projectStartFormatted {
        get;
        set;
    }
    global String projectStatus {
        get;
        set;
    }
    global Integer totalTasks {
        get;
        set;
    }
    global projectViewsWrapper(String projectName, Integer totalTasks, Integer completedTasks, String projectId, Date projectStart, Date projectEnd, List<TASKRAY_LTNG.trComponentController.listCountWrapper> projectList) {

    }
}
global class statCountWrapper {
    global String statName {
        get;
        set;
    }
    global Integer taskCount {
        get;
        set;
    }
    global statCountWrapper(String statName, Integer taskCount) {

    }
}
global class statSortWrapper {
    global String statName {
        get;
        set;
    }
    global Integer taskCount {
        get;
        set;
    }
    global statSortWrapper(String statName, Integer taskCount) {

    }
}
}

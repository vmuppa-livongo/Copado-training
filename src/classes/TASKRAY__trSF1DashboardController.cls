/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trSF1DashboardController {
    global List<TASKRAY.trSF1DashboardController.projectWithParsedDate> contributorProjects {
        get;
        set;
    }
    global String currentList {
        get;
        set;
    }
    global List<Map<String,String>> listColors {
        get;
        set;
    }
    global List<Map<String,String>> listInfo {
        get;
        set;
    }
    global String listInfoJSON {
        get;
        set;
    }
    global Integer overdueCount {
        get;
        set;
    }
    global String projectContributorToCount {
        get;
        set;
    }
    global Map<Id,User> projectOwnerPhotoUrls {
        get;
        set;
    }
    global Map<String,List<TASKRAY__Project_Task__c>> tasksByList {
        get;
        set;
    }
    global List<TASKRAY__Project_Task__c> tasksToDisplay {
        get;
        set;
    }
    global String userFirstName {
        get;
        set;
    }
    global String userSmallPhotoURL {
        get;
        set;
    }
    global trSF1DashboardController() {

    }
    @RemoteAction
    global static void completeTasks(List<Id> taskIds) {

    }
    @RemoteAction
    global static List<TASKRAY.trSF1DashboardController.projectWithParsedDate> getProjectList() {
        return null;
    }
    @RemoteAction
    global static List<TASKRAY.trSF1DashboardController.taskWrapped> getTasksForList(String listName, Id userId) {
        return null;
    }
    @RemoteAction
    global static List<TASKRAY.trSF1DashboardController.taskWrapped> getTasksForProject(Id projectId) {
        return null;
    }
    global void setProjectCounts() {

    }
    global void setSmallPhotoURL() {

    }
    global void setTaskCounts() {

    }
global class projectWithParsedDate {
    global String ownerSmallPhotoURL {
        get;
        set;
    }
    global String parsedProjectDateStr {
        get;
        set;
    }
    global TASKRAY__Project__c project {
        get;
        set;
    }
    global projectWithParsedDate(TASKRAY__Project__c project, Map<Id,User> smallPhotoMap) {

    }
}
global class sharedMethods {
    global sharedMethods() {

    }
    global String colorLuminance(String hex, Decimal lum) {
        return null;
    }
}
global class taskWrapped {
    global Boolean isComplete {
        get;
        set;
    }
    global Boolean isOverdue {
        get;
        set;
    }
    global String listName {
        get;
        set;
    }
    global String ownerSmallPhotoURL {
        get;
        set;
    }
    global String parsedDeadline {
        get;
        set;
    }
    global String projectName {
        get;
        set;
    }
    global TASKRAY__Project_Task__c task {
        get;
        set;
    }
    global String taskGroupNameWithSeparator {
        get;
        set;
    }
    global taskWrapped(TASKRAY__Project_Task__c task, Map<Id,User> smallPhotoMap) {

    }
}
}

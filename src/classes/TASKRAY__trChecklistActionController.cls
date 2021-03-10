/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trChecklistActionController {
    global String currentUserInfo {
        get;
        set;
    }
    global String customLabelJSON {
        get;
        set;
    }
    global Boolean global_timeTrackingEnabled {
        get;
        set;
    }
    global String userLocale {
        get;
        set;
    }
    global trChecklistActionController(ApexPages.StandardController stdController) {

    }
    @RemoteAction
    global static Object addChecklistItem(Id taskId, String text, Id checklistGroupId, Double sortOrder) {
        return null;
    }
    @RemoteAction
    global static void addContributorsToProject(List<Map<String,Id>> contributors) {

    }
    @RemoteAction
    global static Map<Id,TASKRAY.trTaskBoardController.DetailedProjectWrapper> changeContributorAccessLevelReturnInfo(String projectId, List<Map<String,Object>> contribShareInfo) {
        return null;
    }
    @RemoteAction
    global static Object changeItemField(List<Map<String,String>> itemsToUpdate) {
        return null;
    }
    @RemoteAction
    global static void changeOwnerAndRemoveContributor(Id newUserOrGroupId, Id oldUserOrGroupId, Id oldContributorId, Id projectId, List<Map<String,Id>> contributorsToAdd) {

    }
    @RemoteAction
    global static void changeProjectOwnerFromTeamTab(Id projectId, Id newOwnerId) {

    }
    @Deprecated
    @RemoteAction
    global static Map<Id,Boolean> checkForShareContribSyncOnProjectIds(List<Id> projectIdList) {
        return null;
    }
    @RemoteAction
    global static TASKRAY.trTaskBoardController.boardInfoWrapper cloneChecklistGroupsToExistingTasks(Map<Id,List<TASKRAY.trCloneUtils.ChecklistGroupCloneConfigWrapper>> cloneConfigs) {
        return null;
    }
    @RemoteAction
    global static Object deleteChecklistGroup(Id checklistGroupId) {
        return null;
    }
    @RemoteAction
    global static Object deleteChecklistItem(Id checklistId) {
        return null;
    }
    @RemoteAction
    global static void deleteContributorsFromProject(List<Id> contributorIdsToDelete) {

    }
    @RemoteAction
    global static Map<Id,TASKRAY.trTaskBoardController.DetailedProjectWrapper> getDetailedInformationForProjects(List<Id> projectIds) {
        return null;
    }
    @RemoteAction
    global static List<Object> getDetailedInformationForTasks(List<Id> taskIds) {
        return null;
    }
    @RemoteAction
    global static TASKRAY.trTaskBoardController.initialInfoWrapper getInitialInfo() {
        return null;
    }
    @RemoteAction
    global static Object quickAddChecklistGroup(Id taskId, String checklistGroupName) {
        return null;
    }
    @RemoteAction
    global static TASKRAY.trTaskBoardController.boardInfoWrapper quickAddTimeEntryToTask_v2(Id taskId, Decimal timeNumberText, String notesBoxText, Id ownerId, Date dateForTime, Boolean billable, String type) {
        return null;
    }
    @Deprecated
    @RemoteAction
    global static Map<Id,TASKRAY.trTaskBoardController.DetailedProjectWrapper> resyncContributorsOnProjectsAndReturnInfo(List<Id> projectIdsList) {
        return null;
    }
    @RemoteAction
    global static List<SObject> searchObjectsFromTypeahead(String currentSearchInputValue, String scope, String template, String archived, Boolean onlyCurrentProjectRT, Map<String,Map<String,String>> searchParameters) {
        return null;
    }
    @RemoteAction
    global static List<TASKRAY.trTaskBoardController.UserAndQueueSearchResult> searchUsersAndQueues(String searchString) {
        return null;
    }
    @RemoteAction
    global static List<TASKRAY.trTaskBoardController.UserAndQueueSearchResult> searchUsersQueuesAndGroups(String searchString) {
        return null;
    }
    @RemoteAction
    global static List<User> searchUsers(String searchString) {
        return null;
    }
    @RemoteAction
    global static void syncFromSharesToContributors(List<Id> projectIdList) {

    }
    @RemoteAction
    global static void toggleProjectAutoFollow(Id projectId) {

    }
    @RemoteAction
    global static void updateSObjectRecords(List<SObject> sobjs) {

    }
    @RemoteAction
    global static TASKRAY.trTaskBoardController.boardInfoWrapper upsertTimeEntry(List<TASKRAY__trTaskTime__c> timeEntries) {
        return null;
    }
}

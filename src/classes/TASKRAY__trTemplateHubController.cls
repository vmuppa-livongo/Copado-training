/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trTemplateHubController {
    global trTemplateHubController() {

    }
    @RemoteAction
    global static void activateTemplate(Id projectId) {

    }
    @RemoteAction
    global static void addContributorsToProject(String projectId, String userOrGroupId) {

    }
    @RemoteAction
    global static void addProductsToTaskGroup(List<SObject> products, String taskGroupId) {

    }
    @RemoteAction
    global static void archiveProjects(List<Id> projectIds) {

    }
    @RemoteAction
    global static void associateContentVersionWithRecord(Id versionId, Id relatedToObject) {

    }
    @RemoteAction
    global static void changeTasksOwner(String ownerId, List<String> taskIds) {

    }
    @RemoteAction
    global static String cloneProject(Id baseProjectId, String name) {
        return null;
    }
    @RemoteAction
    global static String createQueue(String name) {
        return null;
    }
    @RemoteAction
    global static void deleteContributor(String projectId, String userOrGroupId) {

    }
    @RemoteAction
    global static void deleteDependency(Id depId) {

    }
    @RemoteAction
    global static void deleteFile_v2(List<Map<String,Id>> fileDeleteInfo) {

    }
    @RemoteAction
    global static void deleteLink(List<Id> linkIds) {

    }
    @RemoteAction
    global static void deleteProject(String projectId, Boolean deleteSubs) {

    }
    @RemoteAction
    global static void deleteTask(String taskId) {

    }
    @RemoteAction
    global static void deleteTaskGroup(String groupId) {

    }
    @ReadOnly
    @RemoteAction
    global static List<SObject> generateAndExecuteDataQuery(TASKRAY.trTemplateHubController.trQueryParams request) {
        return null;
    }
    @RemoteAction
    global static Map<Id,Id> getContentDocumentIdsForVersionIds(List<Id> contentVersionIds) {
        return null;
    }
    @RemoteAction
    global static Map<Id,List<TASKRAY.trContributorController.ContributorWrapper>> getContributorsForProjects(List<Id> projectIds) {
        return null;
    }
    @RemoteAction
    global static Map<Id,List<TASKRAY.trTaskBoardController.modalFileResult>> getFilesForId(List<Id> ids) {
        return null;
    }
    @RemoteAction
    global static Map<Integer,List<Integer>> getNonWorkingDaysForYears_multipleBusinessHours(List<Id> businessHoursIds, List<Integer> years) {
        return null;
    }
    @RemoteAction
    global static List<SObject> getProductsByTaskGroupId(String taskGroupId) {
        return null;
    }
    @RemoteAction
    global static List<String> insertProjectRecords(String objectType, List<SObject> records) {
        return null;
    }
    @RemoteAction
    global static void lockTasks(List<Id> taskIds) {

    }
    @RemoteAction
    global static Boolean productHasTaskgroupLookup() {
        return null;
    }
    @RemoteAction
    global static void removeProductsFromTaskGroup(List<SObject> products) {

    }
    @RemoteAction
    global static void saveTemplateAsDraft(Id projectId) {

    }
    @RemoteAction
    global static List<SObject> searchForProducts(String searchString) {
        return null;
    }
    @RemoteAction
    global static List<SObject> searchObjectsFromTypeahead(String currentSearchInputValue, String scope, String template, String archived, Boolean onlyCurrentProjectRT, Map<String,Map<String,String>> searchParameters) {
        return null;
    }
    @RemoteAction
    global static void sortProjectTree(Map<String,Integer> taskGroups, Map<String,Integer> tasks, Map<String,String> tasksNewParent) {

    }
    @RemoteAction
    global static void unarchiveProjects(List<Id> projectIds) {

    }
    global static void updateSObjectRecords(List<SObject> sobjectRecords) {

    }
    @RemoteAction
    global static void updateTaskDatesAndRecalcDeps(List<TASKRAY__Project_Task__c> tasksToUpdate) {

    }
    @RemoteAction
    global static void uploadLink(String linkUrl, String title, String taskOrProject, Id targetId) {

    }
    @RemoteAction
    global static void upsertDependency(List<TASKRAY__trDependency__c> depObjs) {

    }
global class trQueryParams {
    global trQueryParams() {

    }
}
}

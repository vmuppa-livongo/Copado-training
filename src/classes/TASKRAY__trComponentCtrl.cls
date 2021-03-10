/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trComponentCtrl {
    global static Map<String,String> listColorMap {
        get;
        set;
    }
    global trComponentCtrl() {

    }
    @AuraEnabled
    global static Map<Id,List<TASKRAY__trTaskTime__c>> addDetailedTimeEntriesToTaskFromTimesheet(Integer objectYear, Integer objectMonth, Integer objectDate, String objectTaskId, Boolean objectBillable, String objectHours, Integer startDateYear, Integer startDateMonth, Integer startDateDay, String timeType) {
        return null;
    }
    @AuraEnabled
    global static Id cloneProjectFromLightning(String newName, Id baseProjectId, String useStartEndOrMilestoneDate, String dateForClone, Boolean createLookupToRecordId, Id recordIdForLookup, Id milestoneId, Boolean fromFlow) {
        return null;
    }
    @AuraEnabled
    global static void cloneProjectsIntoExistingProjects(String cloneConfigsJSON) {

    }
    @AuraEnabled
    global static void cloneTaskGroupsToExistingProjects(String cloneConfigsJSON) {

    }
    @AuraEnabled
    global static List<TASKRAY__trPendingInterview__c> completePendingInterviewForRecordId(Id recordId, Id interviewId) {
        return null;
    }
    @AuraEnabled
    global static List<SObject> completeTodoItem(String todoItemId) {
        return null;
    }
    @AuraEnabled
    global static Boolean componentAvailableInCommunity() {
        return null;
    }
    @AuraEnabled
    global static Map<Id,String> findAccountMapForUserEmail(String emailToSearch) {
        return null;
    }
    @AuraEnabled
    global static List<SObject> findLookupResult(String searchString, String objectName, String customWhereClause, String nameFieldOverride, Boolean findRecentResults) {
        return null;
    }
    @AuraEnabled
    global static Double flowLocalActionCalculateOnboardingScore(Id projectId) {
        return null;
    }
    @AuraEnabled
    global static String getAccessLevel() {
        return null;
    }
    @AuraEnabled
    global static String getBaseURL() {
        return null;
    }
    @AuraEnabled
    global static String getCurrentValue(String type, String value) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY.trComponentCtrl.projectCountWrapper> getFilteredStatCounts(Id recordId, Boolean showAllTaskGroups, Id taskGroup) {
        return null;
    }
    @AuraEnabled
    global static TASKRAY__trGlobalSettings__c getGlobalSetting() {
        return null;
    }
    @AuraEnabled
    global static TASKRAY__trGlobalSettings__c getGlobalSetting_orgDefaults() {
        return null;
    }
    @AuraEnabled
    global static Boolean getIsTimeEnabled() {
        return null;
    }
    @AuraEnabled
    global static Boolean getIsTimeTrackingFeatureEnabled() {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY.trLightningComponentDataProvider.projectWrapper> getItemsForRecordId(Id recordId) {
        return null;
    }
    @AuraEnabled
    global static TASKRAY.trComponentCtrl.kanbanBoardWrapper getKanbanBoardInfo(Id recordId) {
        return null;
    }
    global static Map<String,String> getLabels() {
        return null;
    }
    @AuraEnabled
    global static void getListColors() {

    }
    @AuraEnabled
    global static Map<String,String> getListNamesAndColors() {
        return null;
    }
    @AuraEnabled
    global static String getLocalizedDateString(String dateStr) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY__Project_Task__c> getMilestonesForProject(Id projectId) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY__Project_Task__c> getMilestonesForTaskGroupId(Id taskGroupId) {
        return null;
    }
    @AuraEnabled
    global static List<Map<String,Object>> getMyProjectFilterOptions() {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY.trComponentCtrl.myProjectWrapper> getMyProjectsComponentInfo_contextual(Id recordId) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY.trComponentCtrl.myProjectWrapper> getMyProjectsComponentInfo() {
        return null;
    }
    @AuraEnabled
    global static String getMyProjectsSelectedFilterId() {
        return null;
    }
    @AuraEnabled
    global static String getOppLinesForStitch(Id opportunityId) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY__trPendingInterview__c> getPendingInterviewsForRecordId(Id recordId) {
        return null;
    }
    @AuraEnabled
    global static String getProjectTeam_json(Id projectId) {
        return null;
    }
    @AuraEnabled
    global static SObject getRecordOwnerInfo(Id recordId) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY.trComponentCtrl.projectCountWrapper> getStatCounts(Id recordId) {
        return null;
    }
    @AuraEnabled
    global static String getTaskBoardURLForUser() {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY.trComponentCtrl.projectOutsideWrapper> getTaskByStatCountAndList(Id recordId) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY.trComponentCtrl.projectViewsWrapper> getTaskCountsByList(Id recordId) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY__Project__c> getTemplateProjects() {
        return null;
    }
    @AuraEnabled
    global static Boolean getTimeComponentBillableDefault() {
        return null;
    }
    @AuraEnabled
    global static Map<Id,List<TASKRAY__trTaskTime__c>> getTimeDataForUserAndDates(Integer startDateYear, Integer startDateMonth, Integer startDateDay) {
        return null;
    }
    @AuraEnabled
    global static String getTimeTypeFieldOptions() {
        return null;
    }
    @AuraEnabled
    global static Boolean getTimeTypeVisibleOverride() {
        return null;
    }
    @AuraEnabled
    global static Boolean globalSettingShowFullFeedChatter() {
        return null;
    }
    @AuraEnabled
    global static TASKRAY.trComponentCtrl.kanbanBoardWrapper handleTaskMove(String itemsToUpdate, Id recordId) {
        return null;
    }
    @AuraEnabled
    global static void insertContributor(Id projectId, Id userOrGroupId, Boolean suppressAssignmentEmails) {

    }
    @AuraEnabled
    global static List<TASKRAY.trComponentCtrl.projectOutsideWrapper> markTaskComplete(Id taskId, Id recordId) {
        return null;
    }
    @AuraEnabled
    global static Id oppLineStitchComponentClone(Id opportunityId, String newProjectName, Id newProjectRecordTypeId, List<Map<String,Object>> taskGroupConfigRows, Boolean fromFlow) {
        return null;
    }
    @AuraEnabled
    global static List<String> overdueDatesForUser(Integer limitInt) {
        return null;
    }
    @AuraEnabled
    global static void reassignOpenItems(Id projectId, Id oldOwnerId, Id newOwnerId) {

    }
    @AuraEnabled
    global static List<SObject> searchObjectsFromTypeahead(String currentSearchInputValue, String scope, String template, String archived, String projectRecordTypeToSearch, Map<String,Map<String,String>> searchParameters, List<String> templateRestrictions) {
        return null;
    }
    @AuraEnabled
    global static List<SObject> searchSObjects(String currentSearchInputValue, String scope, String template, String archived, Boolean onlyCurrentProjectRT, Map<String,Map<String,String>> searchParameters) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY.trComponentCtrl.myProjectWrapper> setMyProjectsSelectedFilterId(String newFilterId) {
        return null;
    }
    global static void setStaticListColorMap() {

    }
    global static List<SObject> stripFLSFields(String operation, List<SObject> newRecords) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY__Project_Task__c> tasksWithRecentChatter(Id userId, Integer numTasksToShow) {
        return null;
    }
    @AuraEnabled
    global static List<SObject> todoItemsForDate(String dateStr) {
        return null;
    }
    @AuraEnabled
    global static List<TASKRAY.trComponentCtrl.myProjectWrapper> toggleAutoFollowReturnMyProjectsComponentInfo(Id projectId) {
        return null;
    }
    @AuraEnabled
    global static void updateRecordOwner(Id recordId, Id recordOwnerId) {

    }
    @AuraEnabled
    global static Integer updateTasksAfterChange(List<Map<String,String>> allRecords) {
        return null;
    }
global class SearchResult {
    global String id {
        get;
        set;
    }
    global String value {
        get;
        set;
    }
    global SearchResult() {

    }
}
global class kanbanBoardWrapper {
    global Map<String,String> listColors {
        get;
        set;
    }
    global List<String> listOptions {
        get;
        set;
    }
    global List<TASKRAY.trLightningComponentDataProvider.projectWrapper> projects {
        get;
        set;
    }
    global kanbanBoardWrapper(List<TASKRAY.trLightningComponentDataProvider.projectWrapper> projects, Map<String,String> listColorMap) {

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
global class myProjectTaskWrapper {
    global String formattedEndDate {
        get;
        set;
    }
    global Boolean isOverdue {
        get;
        set;
    }
    global String listColor {
        get;
        set;
    }
    global TASKRAY__Project_Task__c task {
        get;
        set;
    }
    global myProjectTaskWrapper(TASKRAY__Project_Task__c task) {

    }
}
global class myProjectWrapper implements System.Comparable {
    global Double actualTimeHrs {
        get;
        set;
    }
    global Integer blockedCount {
        get;
        set;
    }
    global Integer completionPercentage {
        get;
        set;
    }
    global Double estTimeHrs {
        get;
        set;
    }
    global String formattedEndDate {
        get;
        set;
    }
    global String formattedStartDate {
        get;
        set;
    }
    global Boolean isAutoFollowing {
        get;
        set;
    }
    global List<String> listOptions {
        get;
        set;
    }
    global Map<Id,List<TASKRAY.trComponentCtrl.myProjectTaskWrapper>> milestoneTasksByTaskGroup {
        get;
        set;
    }
    global Integer overdueCount {
        get;
        set;
    }
    global SObject owner {
        get;
        set;
    }
    global List<Map<String,Object>> progressArray {
        get;
        set;
    }
    global TASKRAY__Project__c project {
        get;
        set;
    }
    global Integer scheduleConflictCount {
        get;
        set;
    }
    global List<Map<String,Object>> taskGroupsArray {
        get;
        set;
    }
    global List<Map<String,Object>> taskStatusCountsWithColor {
        get;
        set;
    }
    global Boolean timeEnabled {
        get;
        set;
    }
    global myProjectWrapper(TASKRAY__Project__c project, List<TASKRAY__Project_Task__c> tasks, SObject owner, Boolean isAutoFollowing) {

    }
    global Integer compareTo(Object obj) {
        return null;
    }
}
global class projectCountWrapper {
    global Decimal actualTimeHrs {
        get;
        set;
    }
    global Integer blockedCount {
        get;
        set;
    }
    global Integer completionPercentage {
        get;
        set;
    }
    global Decimal estimatedTimeHrs {
        get;
        set;
    }
    global List<String> listOptions {
        get;
        set;
    }
    global Integer overdueCount {
        get;
        set;
    }
    global List<Map<String,Object>> progressArray {
        get;
        set;
    }
    global String projectId {
        get;
        set;
    }
    global String projectName {
        get;
        set;
    }
    global Integer scheduleConflictCount {
        get;
        set;
    }
    global List<TASKRAY.trComponentCtrl.statCountWrapper> statList {
        get;
        set;
    }
    global List<Map<String,String>> taskGroupInfoArray {
        get;
        set;
    }
    global Boolean timeEnabled {
        get;
        set;
    }
    global projectCountWrapper(String projectName, String projectId, List<Map<String,String>> taskGroupInfoArray, List<TASKRAY.trComponentCtrl.statCountWrapper> statList, Decimal estimatedTimeHrs, Decimal actualTimeHrs) {

    }
}
global class projectOutsideWrapper {
    global List<TASKRAY.trComponentCtrl.listSortWrapper> columnList {
        get;
        set;
    }
    global Map<String,String> listColors {
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
    global List<TASKRAY.trComponentCtrl.projectTasksWrapper> projectTasks {
        get;
        set;
    }
    global List<TASKRAY.trComponentCtrl.statSortWrapper> statList {
        get;
        set;
    }
    global projectOutsideWrapper(String projectName, Id projectId, List<TASKRAY.trComponentCtrl.listSortWrapper> columnList, List<TASKRAY.trComponentCtrl.statSortWrapper> statList, List<TASKRAY.trComponentCtrl.projectTasksWrapper> projectTasks, Map<String,String> listColors) {

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
    global String taskGroupId {
        get;
        set;
    }
    global String taskGroupName {
        get;
        set;
    }
    global Decimal taskGroupSortOrder {
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
    global projectTasksWrapper(String taskName, Id taskId, Id ownerId, String ownerFirstName, String timeGroup, String listName, Date deadline, Boolean isComplete, String taskGroupId, String taskGroupName, Decimal taskGroupSortOrder) {

    }
}
global class projectViewsWrapper {
    global Map<Id,List<TASKRAY.trComponentCtrl.myProjectTaskWrapper>> milestoneTasksByTaskGroup {
        get;
        set;
    }
    global Decimal percentComplete {
        get;
        set;
    }
    global TASKRAY__Project__c project {
        get;
        set;
    }
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
    global List<Map<String,Object>> taskGroupsArray {
        get;
        set;
    }
    global Integer totalTasks {
        get;
        set;
    }
    global projectViewsWrapper(TASKRAY__Project__c project, Integer totalTasks, Integer completedTasks, List<TASKRAY.trComponentCtrl.myProjectTaskWrapper> milestoneTasks, Decimal percentComplete) {

    }
}
global class statCountWrapper {
    global String color {
        get;
        set;
    }
    global String colorBoxStyle {
        get;
        set;
    }
    global String count {
        get;
        set;
    }
    global String label {
        get;
        set;
    }
    global Decimal percentage {
        get;
        set;
    }
    global String statColor {
        get;
        set;
    }
    global String statName {
        get;
        set;
    }
    global Integer taskCount {
        get;
        set;
    }
    global statCountWrapper(String statName, Integer taskCount, String statColor) {

    }
    global Integer getCategoryCount() {
        return null;
    }
    global String getCategoryName() {
        return null;
    }
    global void setPercentage(Decimal newPercentage) {

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

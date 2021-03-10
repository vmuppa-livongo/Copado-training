/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trFilterHelper {
    global Id contextUserId {
        get;
        set;
    }
    global Boolean hideInternalOnlyTasks {
        get;
        set;
    }
    global Boolean ignoreListVisibilitySelection {
        get;
        set;
    }
    global Boolean onlyQueryOpenChecklistItems {
        get;
        set;
    }
    global Id projectContextualFilterId {
        get;
        set;
    }
    global String projectFilterOverrideId {
        get;
        set;
    }
    global Boolean projectIncrementalQueryHasMore {
        get;
        set;
    }
    global Id projectIncrementalQueryLastId {
        get;
        set;
    }
    global Id projectIncrementalQueryNewLastId {
        get;
        set;
    }
    global Integer projectIncrementalQuerySize {
        get;
        set;
    }
    global String projectScope {
        get;
        set;
    }
    global Boolean queryAdditionalChecklistInfo {
        get;
        set;
    }
    global Boolean showUnassignedOverride {
        get;
        set;
    }
    global Boolean showUnassignedTasksForInbox {
        get;
        set;
    }
    global Boolean singleProjectShowSubs {
        get;
        set;
    }
    global Id singleProjectViewId {
        get;
        set;
    }
    global Boolean taskIncrementalQueryHasMore {
        get;
        set;
    }
    global Id taskIncrementalQueryLastId {
        get;
        set;
    }
    global Id taskIncrementalQueryNewLastId {
        get;
        set;
    }
    global Integer taskIncrementalQuerySize {
        get;
        set;
    }
    global String taskScope {
        get;
        set;
    }
    global Boolean useIncrementalQuery {
        get;
        set;
    }
    global trFilterHelper(String powerFilterId) {

    }
    global String getProjectLimitClause() {
        return null;
    }
    global String getProjectOrderByClause() {
        return null;
    }
    global String getProjectQuery() {
        return null;
    }
    global String getProjectSelectClause() {
        return null;
    }
    global static Map<Id,Set<Id>> getProjectsUsersAutoFollow(Set<Id> userIds) {
        return null;
    }
    global List<TASKRAY__Project__c> getProjects() {
        return null;
    }
    global String getTaskQuery(List<Id> projectIdsForTasks, Boolean showUnassigned) {
        return null;
    }
    global String getTaskSelectClause() {
        return null;
    }
    global List<TASKRAY__Project_Task__c> getTasks(List<Id> projectIdsForTasks, Boolean showUnassigned) {
        return null;
    }
    global static TASKRAY.trFilterHelper insertNewFilter(String newPowerFilterName, Map<String,Object> projectFilterInfo, Map<String,Object> taskFilterInfo) {
        return null;
    }
    global Boolean isFilterMyInbox() {
        return null;
    }
    global void overrideProjectAndTaskFilterId(String projectFilterId, String taskFilterId) {

    }
    global void overrideProjectFilterId(String projectFilterId) {

    }
    global static void removeBoardFilterShares(Set<Id> filterIds) {

    }
    global static void shareBoardFilterWithPublicGroup(List<TASKRAY__trBoardFilterShareJunction__c> boardFilterSharesToAdd) {

    }
    global static void updatePersonalSortOnSharedPowerFilters(Map<Id,Integer> filterIdToSortOrderMap) {

    }
global class BoardFilterWrapper {
    global TASKRAY__trBoardFilter__c boardFilter {
        get;
        set;
    }
    global String filterId {
        get;
        set;
    }
}
}

/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trContextualViewController {
    global static String boardFilterOnLoadJSON {
        get;
        set;
    }
    global Id networkId {
        get;
        set;
    }
    global trContextualViewController() {

    }
    @RemoteAction
    global static Object addChecklistItem(Id taskId, String text, Id checklistGroupId, Double sortOrder, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static void addContributorsToProject(List<Map<String,Id>> contributors, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {

    }
    @RemoteAction
    global static Object addDetailedTaskTimeItemsFromModal(List<Map<String,Object>> newEntries, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object addDetailedTimeEntriesToTaskFromTimesheet(List<Map<String,Object>> newEntries, Integer startDateYear, Integer startDateMonth, Integer startDateDay, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object archiveProjectsReturnBoardInfo(List<Id> projectIds, Boolean archiveSubProjects, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object archiveTaskGroupsReturnBoardInfo(List<Id> taskGroupIds, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object associateContentVersionWithRecord(Id versionId, Id relatedToObject, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object changeContributorAccessLevelReturnInfo(String projectId, List<Map<String,Object>> contribShareInfo, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object changeItemField(List<Map<String,String>> itemsToUpdate, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static void changeOwnerAndRemoveContributor(Id newUserOrGroupId, Id oldUserOrGroupId, Id oldContributorId, Id projectId, List<Map<String,Id>> contributorsToAdd, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {

    }
    @RemoteAction
    global static void changeProjectOwnerFromTeamTab(Id projectId, Id newOwnerId, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {

    }
    @RemoteAction
    global static Object cloneChecklistGroupsToExistingTasks(Map<Id,List<TASKRAY.trCloneUtils.ChecklistGroupCloneConfigWrapper>> cloneConfigs, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object cloneProjectReturnId_v3(Id baseProjectId, Map<String,Map<String,String>> projectInfo, Map<String,String> options, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object cloneProjectsIntoExistingProjects(Map<Id,List<TASKRAY.trCloneUtils.ProjectStitchConfigWrapper>> cloneConfigs, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object cloneTaskGroupsToExistingProjects(Map<Id,List<TASKRAY.trCloneUtils.TaskGroupCloneConfigWrapper>> cloneConfigs, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static void createBaselineForProjectIds(Map<Id,String> projectIdToNotesMap, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {

    }
    @RemoteAction
    global static Object createSObjects(List<SObject> sobjectsToInsert, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static void deleteBaselines(List<Id> baselineIds, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {

    }
    @RemoteAction
    global static Object deleteBoardFilters(List<Id> boardFilterIds, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object deleteChecklistItem(Id checklistId, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static void deleteContributorsFromProject(List<Id> contributorIdsToDelete, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {

    }
    @RemoteAction
    global static Object deleteDependencyReturnBoardInfo(List<TASKRAY__trDependency__c> sObjs, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static void deleteFile_v2(List<Map<String,Id>> fileDeleteInfo, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {

    }
    @RemoteAction
    global static void deleteLink(List<Id> linkIds, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {

    }
    @RemoteAction
    global static Object deletePowerFilters(List<Id> powerFilterIds, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object deleteTaskGroupsReturnBoardInfo(List<Id> taskGroupIds, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object deleteTaskTimeEntryFromModal(Id taskTimeId, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object deleteTaskTimeEntryFromTimesheet(Id timeId, Id userId, Integer startDateYear, Integer startDateMonth, Integer startDateDay, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object deleteTasks(List<Id> tasksToDel, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object fetchBaselinesForProjectIds(List<Id> projectIds, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object generateAndExecuteAggregatesQuery(TASKRAY.trTaskBoardController.trQueryParams request, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getAreActiveTimersRunningForUser(Id userId, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getBoardInfo(TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @ReadOnly
    @RemoteAction
    global static Object getBoardInfoFromClientFilter(TASKRAY.trTaskBoardController.trBoardInfoRequest reqInfo, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @ReadOnly
    @RemoteAction
    global static Object getChatterForRecordIds(List<Id> recordIds, Integer returnLimit, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getContentDocumentIdsForVersionIds(List<Id> contentVersionIds, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getDetailedInformationForProjects(List<Id> projectIds, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getDetailedInformationForTasks(List<Id> taskIds, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getFilesForId(List<Id> ids, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getFilterableFields(TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @ReadOnly
    @RemoteAction
    global static Object getInfoTabInfo(List<Id> selectedParentRecordIds, Boolean inProjectView, Map<String,String> chartTabConfig, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getInitialInfo(TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getMilestonesForProject(Id projectId, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getNonWorkingDaysForYears_multipleBusinessHours(List<Id> businessHoursIds, List<Integer> years, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getRecentTemplateProjects(TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getRecordTypeIdForProjectId(Id projectId, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getTRUnassignedQueueId(TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getTemplateLibraryHistoryProjects(TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object getTimeDataForUserAndDates(Id userId, Integer startDateYear, Integer startDateMonth, Integer startDateDay, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object insertTaskGroupReturnBoardInfo_v2(Id projectId, String taskGroupName, String destination, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object markProjectDeleted_v3(String projectId, Boolean deleteSubs, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object projectContributorSearch(String searchString, List<String> existingContributorIds, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object quickAddChecklistGroup(Id taskId, String checklistGroupName, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object quickAddTask_v4(String taskName, Id projectId, Id recordTypeId, String listName, List<Map<String,Object>> presetFieldValues, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object saveProjectChatterGroups(List<Id> groupIds, Id projectId, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object searchChatterGroups(String searchString, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object searchGroups(String searchString, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object searchGroupsAndRoles(String searchString, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @ReadOnly
    @RemoteAction
    global static Object searchObjectsFromTypeahead(String currentSearchInputValue, String scope, String template, String archived, Boolean onlyCurrentProjectRT, Map<String,Map<String,String>> searchParameters, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object searchProjects_v2(String searchString, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object searchTasks(String searchString, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object searchTasksScope(String searchString, String scope, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object searchTemplateProjects(String searchString, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object searchTopics(String searchString, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object searchUsers(String searchString, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object searchUsersAndQueues(String searchString, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object searchUsersQueuesAndGroups(String searchString, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object searchUsersQueuesAndGroupsWithInactiveUsers(String searchString, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object toggleFollowTask_v2(String taskId, Boolean newfollowValue, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static void toggleProjectAutoFollow(Id projectId, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {

    }
    @RemoteAction
    global static void updateSObjectRecords(List<SObject> sobjs, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {

    }
    @RemoteAction
    global static Object updateTaskTimeEntryFromTimesheet_v2(Id timeId, Id taskId, Id userId, String notesInput, Boolean billableInput, String typeInput, Integer dateYear, Integer dateMonth, Integer dateDay, String hoursInput, Integer startDateYear, Integer startDateMonth, Integer startDateDay, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object updateUserSettingsViaMapReturnBoardData(Map<String,Object> fieldMap, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static void uploadLink(String linkUrl, String title, String taskOrProject, Id targetId, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {

    }
    @RemoteAction
    global static Object upsertDependencyReturnBoardInfo(List<TASKRAY__trDependency__c> depObjs, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object upsertMetadataCache(Map<String,String> updateInfo, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object upsertPowerFilterWithShares(Map<String,String> powerFilterSettings, List<TASKRAY.trTaskBoardController.viewFilterItemWrapper> filtersToAdd, List<TASKRAY.trTaskBoardController.viewFilterItemWrapper> filtersToUpdate, List<Group> groupsToShareTo, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object upsertPowerFilter(Map<String,String> powerFilterSettings, List<TASKRAY.trTaskBoardController.viewFilterItemWrapper> filtersToAdd, List<TASKRAY.trTaskBoardController.viewFilterItemWrapper> filtersToUpdate, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
    @RemoteAction
    global static Object upsertTimeEntry(List<TASKRAY__trTaskTime__c> timeEntries, TASKRAY.trContextualViewController.trRemoteActionContext remoteActionContext) {
        return null;
    }
global class trRemoteActionContext {
    global trRemoteActionContext() {

    }
}
}

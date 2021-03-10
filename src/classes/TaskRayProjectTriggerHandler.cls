public with sharing class TaskRayProjectTriggerHandler {
    public static void handleProjectUpdate(Map<Id, TASKRAY__Project__c> oldProjects, List<TASKRAY__Project__c> newProjects) {
        List<TASKRAY__Project__c> projectListToCreateCHS = new List<TASKRAY__Project__c>();
        for (TASKRAY__Project__c project: newProjects) {
            if (project.Client_Overview__c != null && (project.Client_Overview__c != oldProjects.get(project.Id).Client_Overview__c)
                && project.Project_Type__c == 'New Client / Contract Path' || project.Project_Type__c == 'Carrier/Contract Path Change' ||
                project.Project_Type__c == 'Cross-Sell (New Program)') {
                projectListToCreateCHS.add(project);
            }
        }
        if (projectListToCreateCHS.size() > 0) {
            TaskRayProjectService.createClientHandoff(projectListToCreateCHS);
        }
    }
}
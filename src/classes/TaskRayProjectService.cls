public with sharing class TaskRayProjectService {
    public static void createClientHandoff(List<TASKRAY__Project__c> projectList) {
        List<TASKRAY__Project__c> finalProjectList = [SELECT Id, Client_Overview__c, Client_Overview__r.AccountId, TASKRAY__Project__c.Project_Type__c FROM TASKRAY__Project__c WHERE Id IN :projectList];
        List<Client_Handoff_Summary__c> chsListtoInsert = new List<Client_Handoff_Summary__c>();
        for (TASKRAY__Project__c project: finalProjectList) {
            Client_Handoff_Summary__c chs = new Client_Handoff_Summary__c();
            chs.TaskRay_Project__c = project.Id;
            chs.Client_Overview__c = project.Client_Overview__c;
            chs.Account__c = project.Client_Overview__r.AccountId;
            chsListtoInsert.add(chs);
        }
        if (chsListtoInsert.size() > 0) {
            insert chsListtoInsert;
        }
    }
}
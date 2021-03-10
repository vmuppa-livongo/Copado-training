@isTest
public with sharing class TaskRayProjectTriggerTest {
    @TestSetup
    static void testData(){
        Account clientAccount = TestFactory.createClientAccount();
        Contract clientOverview = TestFactory.createClientOverview();
        insert clientAccount;

        clientOverview.AccountId = clientAccount.Id;
        insert clientOverview;
    }
    private static Contract getClientOverview() {
        return [SELECT Id, AccountId FROM Contract LIMIT 1];
    }
    @isTest
    static void createTaskRayProjectTest() {
        Contract co = getClientOverview();
        TASKRAY__Project__c  project = TestFactory.createTaskRayProject();
        insert project;

        project.Client_Overview__c = co.Id;

        Test.startTest();
        update project;
        Test.stopTest();
        
        List<Client_Handoff_Summary__c> chsList = [SELECT Id FROM Client_Handoff_Summary__c WHERE TaskRay_Project__c =: project.Id];
        System.assertEquals(1, chsList.size());
    }
}
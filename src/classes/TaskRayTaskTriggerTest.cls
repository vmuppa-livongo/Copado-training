@isTest
public class TaskRayTaskTriggerTest {
    @testSetup
    static void setupData() {

        TASKRAY__Project__c project = new TASKRAY__Project__c();
        project.Name = 'Test TaskRay Project';
        project.TaskRayStatus__c = 'Not Started';
        insert project;

        Account testAccount = TestFactory.createClientAccount();
        insert testAccount;

        TASKRAY__Project_Task__c task1 = new TASKRAY__Project_Task__c();
        task1.Name = 'Test TaskRay Task 1';
        task1.TASKRAY__trAccount__c = testAccount.Id;
        task1.TASKRAY__List__c = 'Not Started';
        task1.TASKRAY__Project__c = project.Id;

        TASKRAY__Project_Task__c task2 = new TASKRAY__Project_Task__c();
        task2.Name = 'Test TaskRay Task 2';
        task2.TASKRAY__trAccount__c = testAccount.Id;
        task2.TASKRAY__List__c = 'Not Started';
        task2.TASKRAY__Project__c = project.Id;

        TASKRAY__Project_Task__c task3 = new TASKRAY__Project_Task__c();
        task3.Name = 'Test TaskRay Task 3';
        task3.TASKRAY__trAccount__c = testAccount.Id;
        task3.TASKRAY__List__c = 'Not Started';
        task3.TASKRAY__Project__c = project.Id;

        List<TASKRAY__Project_Task__c> tasks = new List<TASKRAY__Project_Task__c>();
        tasks.add(task1);
        tasks.add(task2);
        tasks.add(task3);
        insert tasks;
        
    }
    
    @isTest
    static void taskRayTaskDeleteTest() {
        
        TASKRAY__Project__c project = [SELECT Id FROM TASKRAY__Project__c LIMIT 1];
        
        List<TASKRAY__Project_Task__c> tasks = [SELECT Name, TASKRAY__trAccount__c, TASKRAY__List__c, TASKRAY__Project__c FROM TASKRAY__Project_Task__c];
                
        Test.startTest();

        delete tasks;

        Test.stopTest();

        List<FeedItem> feedItems = [SELECT Id, Body, ParentId, CreatedById FROM FeedItem];
        System.assertEquals(3, feedItems.size());
        for (FeedItem item : feedItems) {
            System.assertEquals(System.Label.System_Admin_Id, item.CreatedById);
            System.assertEquals(project.Id, item.ParentId);
        }
    }
}
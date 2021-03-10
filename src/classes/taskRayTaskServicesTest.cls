@isTest
public class taskRayTaskServicesTest {

    
    @isTest
    public static void testSingleClone(){
        
        TASKRAY__Project__c newProject = new TASKRAY__Project__c(Name = 'Test Project');
        insert newProject;
        
        TASKRAY__Project_Task__c newTask = new TASKRAY__Project_Task__c(Name = 'Test Task', TASKRAY__trBusinessDuration__c = 10);
        insert newTask;
        
        Id projectId = [SELECT Id FROM TASKRAY__Project__c WHERE Id = :newProject.Id].Id;
        TASKRAY__Project_Task__c taskRecord = [SELECT Id, TASKRAY__Project__c FROM TASKRAY__Project_Task__c WHERE Id = :newTask.Id];
        
        System.debug('Project ID: ' + projectId);
        System.debug('Task ID: ' + newTask.Id);
        
        System.assertNotEquals(projectId, taskRecord.TASKRAY__Project__c);
        
        
        List<List<String>> singleSourceInformation = new List<List<String>>();
        List<String> sourceInfo = new List<String>{'2019-01-01', String.valueOf(projectId), String.valueOf(taskRecord.Id)};
        
        singleSourceInformation.add(sourceInfo);
        
        List<List<String>> results = taskRayTaskServices.BulkCloneTasks(singleSourceInformation);
        
        System.assertNotEquals(Null, results);
        
        System.assertEquals(2, results[0].size());        
        System.assertEquals(TRUE, results[0][1].contains(String.valueOf(taskRecord.Id)));
        System.assertEquals(FALSE, results[0][1].contains(String.valueOf(projectId)));
        
        
        TASKRAY__Project_Task__c clonedTask = [SELECT Id, Name FROM TASKRAY__Project_Task__c WHERE Id = :Id.valueOf(results[0][1].right(18))];

        System.assertNotEquals(Null, clonedTask);
        System.assertEquals(clonedTask.Name, newTask.Name);
    }
    
    @isTest
    public static void testBulkClone(){
                
        TASKRAY__Project__c newProject = new TASKRAY__Project__c(Name = 'Test Project');
        insert newProject;
        
        Id projectId = [SELECT Id FROM TASKRAY__Project__c WHERE Id = :newProject.Id].Id;
        

        List<TASKRAY__Project_Task__c> allTasks = new List<TASKRAY__Project_Task__c>();
        TASKRAY__Project_Task__c newTask1 = new TASKRAY__Project_Task__c(Name = 'Test Task 1', TASKRAY__trBusinessDuration__c = 5);
        TASKRAY__Project_Task__c newTask2 = new TASKRAY__Project_Task__c(Name = 'Test Task 2', TASKRAY__trBusinessDuration__c = 10);
        TASKRAY__Project_Task__c newTask3 = new TASKRAY__Project_Task__c(Name = 'Test Task 3', TASKRAY__trBusinessDuration__c = 15);
        allTasks.add(newTask1);
        allTasks.add(newTask2);
        allTasks.add(newTask3);
        
        System.debug(allTasks);
        insert allTasks;
        
        List<TASKRAY__Project_Task__c> taskRecords = [SELECT Id, Name, TASKRAY__Project__c FROM TASKRAY__Project_Task__c WHERE Id IN :allTasks];
        
        System.debug('Project ID: ' + projectId);
        
        System.debug('Task Name: ' + taskRecords[0].Name + ' - Task ID: ' + taskRecords[0].Id);
        System.debug('Task Name: ' + taskRecords[1].Name + ' - Task ID: ' + taskRecords[1].Id);
        System.debug('Task Name: ' + taskRecords[2].Name + ' - Task ID: ' + taskRecords[2].Id);
        
        System.assertNotEquals(projectId, taskRecords[0].TASKRAY__Project__c);
        System.assertNotEquals(projectId, taskRecords[1].TASKRAY__Project__c);
        System.assertNotEquals(projectId, taskRecords[2].TASKRAY__Project__c); 
        
        List<List<String>> singleSourceInformation = new List<List<String>>();
        List<String> sourceInfo = new List<String>{
            '2019-01-01', 
            String.valueOf(projectId), 
            String.valueOf(taskRecords[0].Id), 
            String.valueOf(taskRecords[1].Id), 
            String.valueOf(taskRecords[2].Id)
            };
         
        singleSourceInformation.add(sourceInfo);
        
        List<List<String>> results = taskRayTaskServices.BulkCloneTasks(singleSourceInformation);
        
        System.assertNotEquals(Null, results);
        System.debug(results); 
        System.assertEquals(4, results[0].size());        
        System.assertEquals(TRUE, results[0][1].contains(String.valueOf(taskRecords[0].Id)));
        System.assertEquals(TRUE, results[0][2].contains(String.valueOf(taskRecords[1].Id)));
        System.assertEquals(TRUE, results[0][3].contains(String.valueOf(taskRecords[2].Id)));
        
        System.assertEquals(FALSE, results[0][1].contains(String.valueOf(projectId)));
        
        
        TASKRAY__Project_Task__c clonedTask1 = [SELECT Id, Name FROM TASKRAY__Project_Task__c WHERE Id = :Id.valueOf(results[0][1].right(18))];
		TASKRAY__Project_Task__c clonedTask2 = [SELECT Id, Name FROM TASKRAY__Project_Task__c WHERE Id = :Id.valueOf(results[0][2].right(18))];
        TASKRAY__Project_Task__c clonedTask3 = [SELECT Id, Name FROM TASKRAY__Project_Task__c WHERE Id = :Id.valueOf(results[0][3].right(18))];
        
        System.assertNotEquals(Null, clonedTask1);
        System.assertNotEquals(Null, clonedTask2);
        System.assertNotEquals(Null, clonedTask3);
        System.assertEquals(clonedTask1.Name, taskRecords[0].Name);
        System.assertEquals(clonedTask2.Name, taskRecords[1].Name);
        System.assertEquals(clonedTask3.Name, taskRecords[2].Name);
    }
}
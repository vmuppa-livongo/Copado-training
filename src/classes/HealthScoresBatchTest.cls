@isTest
private class HealthScoresBatchTest {
    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<10; i++) {
            Account testAccount = new Account();
            testAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Client_Account').getRecordTypeId();
            testAccount.Name = 'Test Batch Account' + i;
            testAccount.Type = 'Self Funded Employer';
            testAccount.Account_Type__c = 'Client';
            accounts.add(testAccount);
        }
        insert accounts;
    }
    
    static testmethod void test() {  
        List<Account> accList = [SELECT Id FROM Account WHERE Name LIKE 'Test Batch Account%'];
        Test.startTest();
        HealthScoresBatch caub = new HealthScoresBatch();
        Id batchId = Database.executeBatch(caub);
        Test.stopTest();
        System.assertEquals(640, [SELECT count() FROM Health_Score__c WHERE Account__c IN: accList]);
    }
     
}
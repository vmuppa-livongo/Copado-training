@isTest
public class AccountHealthScoreControllerTest {
    @TestSetup
    static void setupData() {
        Account clientAccount = TestFactory.createClientAccount();
        insert clientAccount;
    }
    
    private static Account getClientAccount() {
        return [SELECT Id FROM Account LIMIT 1];
    }
    
    private static List<Health_Score__c> getHealthScores(Id accId) {
        return [SELECT Id FROM Health_Score__c WHERE Account__c = :accId];
    }
	
    @isTest
    static void hsControllerTest() {
        Account acc = getClientAccount();
        Test.startTest();
        AccountHealthScoreController.getHealthScores(acc.Id);
        Test.stopTest();
        List<Health_Score__c> hsList = getHealthScores(acc.Id);
        system.assertEquals(32, hsList.size());
    }
}
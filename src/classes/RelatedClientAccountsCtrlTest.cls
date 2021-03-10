@isTest
public class RelatedClientAccountsCtrlTest {

    public static final Id PARTNER_ACCOUNT_RT_ID = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Partner_Account').getRecordTypeId();
    public static final Id CLIENT_ACCOUNT_RT_ID = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Client_Account').getRecordTypeId();
    public static final Id CONTRACT_PARTNERSHIP_RT_ID = Schema.SObjectType.Relationship__c.getRecordTypeInfosByDeveloperName().get('Contract_Partnership').getRecordTypeId();


    public static Account getPartnerAccount() {
        Id partnerAccountRTId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Partner_Account').getRecordTypeId();
        return [SELECT Id, RecordTypeId, Name FROM Account WHERE RecordTypeId = :PARTNER_ACCOUNT_RT_ID LIMIT 1];
    }

    @TestSetup
    static void setupData() {
        Account partnerAccount = TestFactory.createPartnerAccount();
        insert partnerAccount;
        
        Contract co = TestFactory.createClientOverview();
        co.AccountId = partnerAccount.Id;
        insert co;
    }

    @isTest
    static void getRelatedClientAccountsRelationshipsLinkedToPartnerAccountTest() {
        Account partnerAccount = getPartnerAccount();
        
        List<Relationship__c> relationships = [SELECT Id, Name, RecordTypeId, Master_Account__c, Master_Client_Account__c FROM Relationship__c WHERE RecordTypeId = :CONTRACT_PARTNERSHIP_RT_ID];
        for (Relationship__c rel : relationships) {
            rel.Master_Account__c = partnerAccount.Id;
        }
        
        update relationships;

        Test.startTest();

        List<Relationship__c> rels  = RelatedClientAccountsCtrl.getRelatedClientAccounts(partnerAccount.Id);

        Test.stopTest();
		
        //Should be multiple Relationships created
        System.assertNotEquals(0, rels.size());
        for (Relationship__c rel : rels) {
            //Each Relationship should be associated with the Partner Account
            System.assertEquals(partnerAccount.Id, rel.Master_Account__c);
            //Each Relationship should have the Contract Partnership Record Type
            System.assertEquals(CONTRACT_PARTNERSHIP_RT_ID, rel.RecordTypeId);
        }
    }

    @isTest
    static void getRelatedClientAccountsRelationshipsNotLinkedToPartnerAccountTest() {
        Account partnerAccount = getPartnerAccount();

        Test.startTest();
        
        List<Relationship__c> rels = RelatedClientAccountsCtrl.getRelatedClientAccounts(partnerAccount.Id);

        Test.stopTest();

        //No Relationships should be returned as they were never associated with a Partner Account
        System.assertEquals(0, rels.size());
    }
}
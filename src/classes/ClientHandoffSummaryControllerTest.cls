@isTest
public with sharing class ClientHandoffSummaryControllerTest {
    public static final Id PROGRAM_OVERVIEW_RT = Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Program_Overview').getRecordTypeId();
    public static final Id ACCOUNT_PARTNERSHIP_RT = Schema.SObjectType.Relationship__c.getRecordTypeInfosByDeveloperName().get('Account_Partnership').getRecordTypeId();
    public static final Id CONTRACT_PARTNERSHIP_RT = Schema.SObjectType.Relationship__c.getRecordTypeInfosByDeveloperName().get('Contract_Partnership').getRecordTypeId();
    public static List<String> relationshipTypes = ClientHandoffSummaryPdfController.relationshipTypes;
    
    @TestSetup
    static void testData(){
        Account clientAccount = TestFactory.createClientAccount();
        insert clientAccount;
        
        Account partnerAccount = TestFactory.createPartnerAccount();
        insert partnerAccount;
                
        List<Contract> clist = new List<Contract>();
        Contract clientOverview = TestFactory.createClientOverview();
        clientOverview.AccountId = clientAccount.Id;
        clist.add(clientOverview);

        if(clist.size() > 0) {
            insert cList;
        }

        List<Contact> conList = new List<Contact>();
        for(integer i=0; i<3; i++) {
            Contact con = TestFactory.createSalesContact();
            con.AccountId = clientAccount.Id;
            conList.add(con);
        }
        insert conList;
        
        List<Opportunity> oppList = new List<Opportunity>();
        for(integer i=0; i<3; i++) {
            Opportunity opp = TestFactory.createTypeBasedOpportunity('New Business');
            opp.AccountId = clientAccount.Id;
            oppList.add(opp);
        }
        insert oppList;
        
        List<Relationship__c> relList = new List<Relationship__c>();
        for(integer i=0; i<3; i++) {
            Relationship__c rel = TestFactory.createRelationship('Benefits Consultant');
            rel.Client_Partnership__c = clientAccount.Id;
            rel.Partner_Partnership__c = partnerAccount.Id;
            rel.RecordTypeId = ACCOUNT_PARTNERSHIP_RT;
            relList.add(rel);
        }
        for(integer i=0; i<3; i++) {
            Relationship__c rel = TestFactory.createRelationship('Billing Partner');
            rel.Contract_Partnership__c = clientOverview.Id;
            rel.Partner_Contract_Partnership__c  = partnerAccount.Id;
            rel.RecordTypeId = CONTRACT_PARTNERSHIP_RT;
            relList.add(rel);
        }
        insert relList;

        Contract programOverview = TestFactory.createProgramOverview();
        Contract programOverview2 = TestFactory.createProgramOverview();
        Contract programOverview3 = TestFactory.createProgramOverview();

        programOverview.Client_Overview__c = clientOverview.Id;
        programOverview.AccountId = clientAccount.Id;
        programOverview.Program_Name__c = 'Diabetes';

        programOverview2.Client_Overview__c = clientOverview.Id;
        programOverview2.AccountId = clientAccount.Id;
        programOverview2.Program_Name__c = 'Hypertension';

        programOverview3.Client_Overview__c = clientOverview.Id;
        programOverview3.AccountId = clientAccount.Id;
        programOverview3.Program_Name__c = 'Prediabetes';

        cList.add(programOverview);
        cList.add(programOverview2);
        cList.add(programOverview3);

        if(clist.size() > 0) {
            upsert cList;
        }

        TASKRAY__Project__c  project = TestFactory.createTaskRayProject();
        project.Client_Overview__c = clientOverview.Id;
        insert project;

        Client_Handoff_Summary__c chs = TestFactory.createClientHandoffSummary();
        chs.Client_Overview__c = clientOverview.Id;
        chs.Account__c = clientAccount.Id;
        insert chs;
    }

    private static Client_Handoff_Summary__c getCHS() {
        return [SELECT Id, Client_Overview__c, Account__c FROM Client_Handoff_Summary__c LIMIT 1];
    }
    
    private static List<AccountContactRelation> getAccConRelList() {
        return [SELECT Id, AccountId, ContactId, Roles FROM AccountContactRelation];
    }
    
    private static List<Opportunity> getOpportunities() {
        return [SELECT Id FROM Opportunity];
    }
    
    private static List<Contract> getProgramOverviews() {
        return [SELECT Id FROM Contract WHERE RecordTypeId = :PROGRAM_OVERVIEW_RT];
    }
    
    private static List<Relationship__c> getAccountRelationships() {
       return [SELECT Id FROM Relationship__c WHERE RecordTypeId = :ACCOUNT_PARTNERSHIP_RT];
    }
    
    private static List<Relationship__c> getContractRelationships() {
       return [SELECT Id, RecordType.Name, RelationshipType__c FROM Relationship__c WHERE RecordTypeId = :CONTRACT_PARTNERSHIP_RT 
               AND RelationshipType__c IN :relationshipTypes];
    }
    	
    @isTest
    static void getProgramsTest() {
        Client_Handoff_Summary__c chs = getCHS();
        List<Contract> expectedprogramsList = getProgramOverviews();
        Test.startTest();
        List<Contract> programList = ClientHandoffSummaryController.getPrograms(chs.Id);
        Test.stopTest();
        System.assertEquals(expectedprogramsList.size(), programList.size());
    }

    @isTest
    static void getAccountContactRelationshipsTest() {
        Client_Handoff_Summary__c chs = getCHS();
        List<AccountContactRelation> accConRelList = getAccConRelList();
        for (AccountContactRelation accConRel: accConRelList) {
            accConRel.Roles = 'Billing POC;Executive Sponsor';
        }
        update accConRelList;
        Test.startTest();
        List<AccountContactRelation> accConRelListResult = ClientHandoffSummaryController.getAccountContactRelationships(chs.Id);
        Test.stopTest();
        System.assertEquals(getAccConRelList().size(), accConRelListResult.size());
    }
    
      
    @isTest
    static void clientHandoffSummaryPDFControllerTest() {
        Client_Handoff_Summary__c chs = getCHS();
        List<Opportunity> oppList = getOpportunities();
        List<Contract> programList = getProgramOverviews();
        List<AccountContactRelation> accConRelList = getAccConRelList();
        for (AccountContactRelation accConRel: accConRelList) {
            accConRel.Roles = 'Billing POC;Executive Sponsor';
        }
        update accConRelList;
        List<Relationship__c> accRelationships = getAccountRelationships();
        List<Relationship__c> contractRelationships = getContractRelationships();
        Test.startTest();
        ApexPages.currentPage().getParameters().put('id',String.valueOf(chs.Id));
        ClientHandoffSummaryPdfController.ClientHandoffSummaryWrapper  chsWrapper = new ClientHandoffSummaryPdfController.ClientHandoffSummaryWrapper();
        ClientHandoffSummaryPdfController chsPDFController = new ClientHandoffSummaryPdfController();
        chsWrapper=chsPDFController.theCHS;
        Test.stopTest();
        System.assertEquals(chs.Client_Overview__c, chsWrapper.clientHandoffSummary.Client_Overview__c);
        System.assertEquals(chs.Account__c, chsWrapper.clientHandoffSummary.Account__c);
        System.assertEquals(oppList.size(), chsWrapper.opportunitiesForParentAccount.size());
        System.assertEquals(programList.size(), chsWrapper.programOverviews.size());
        System.assertEquals(accConRelList.size(), chsWrapper.accountContactRelationships.size());
        System.assertEquals(accRelationships.size(), chsWrapper.partnerRelationshipForParentAccount.size());
        System.assertEquals(contractRelationships.size(), chsWrapper.contractPartnerRelationshipForParentAccount.size());
    }
}
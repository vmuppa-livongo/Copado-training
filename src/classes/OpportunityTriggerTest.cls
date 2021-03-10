@isTest
public class OpportunityTriggerTest {
    public static final String NEW_BUSINESS = 'New Business';
    public static final String RENEWAL = 'Renewal';
    public static final String EXPANSION = 'Expansion';
    public static final String CROSSSELL = 'Cross-sell (New product)';
    public static final String CONTRACTPATHCHANGE = 'Contract Path Change';
    @TestSetup
    static void setupData() {
        Account clientAccount = TestFactory.createClientAccount();
        insert clientAccount;
        
        Account partnerAccount = TestFactory.createPartnerAccount();
        insert partnerAccount;
        
        Contract clientOverview = TestFactory.createClientOverview();
        clientOverview.AccountId = clientAccount.Id;
        clientOverview.Contract_Path__c = partnerAccount.Id;
        clientOverview.CSM__c = System.UserInfo.getUserId();
        insert clientOverview;
        
        List<Opportunity> oppList = new List<Opportunity>();
        oppList.add(TestFactory.createTypeBasedOpportunity(NEW_BUSINESS));
        oppList.add(TestFactory.createTypeBasedOpportunity(RENEWAL));
        oppList.add(TestFactory.createTypeBasedOpportunity(EXPANSION));
        oppList.add(TestFactory.createTypeBasedOpportunity(CROSSSELL));
        oppList.add(TestFactory.createTypeBasedOpportunity(CONTRACTPATHCHANGE));
        
        for(Opportunity opp: oppList) {
            opp.AccountId = clientAccount.Id;
            opp.Contract_Path__c = partnerAccount.Id;
            if(opp.Type == CONTRACTPATHCHANGE) {
                opp.Original_Contract__c = clientOverview.Id;
            }
        }
        
        if(oppList.size() > 0) {
            insert oppList;
        }
        
        Pricebook2 livongoPricebook = TestFactory.createPricebook();
        insert livongoPricebook;
        
        List<Product2> programsList = new List<Product2>();
        programsList.add(TestFactory.createProgram('Livongo for Diabetes'));
        programsList.add(TestFactory.createProgram('Livongo for Hypertension'));
        programsList.add(TestFactory.createProgram('Livongo Diabetes Prevention Program'));
        
        insert programsList;
        
        Id standardPBId = Test.getStandardPricebookId();
        
        List<PricebookEntry> entriesList = new List<PricebookEntry>();
        List<PricebookEntry> livongoPBEntriesList = new List<PricebookEntry>();
        List<Pricing_Structure__c> pricingStructureList = new List<Pricing_Structure__c>();
        
        for(Product2 program: programsList) {
            entriesList.add(TestFactory.createPricebookEntry(standardPBId, program.Id));
            livongoPBEntriesList.add(TestFactory.createPricebookEntry(livongoPricebook.Id, program.Id));
            pricingStructureList.add(TestFactory.createPricingStructure(livongoPricebook.Id, program.Id));
        }
        
        insert entriesList;
        insert livongoPBEntriesList;
        insert pricingStructureList;
        
        Map<Id,Id> standardPricingStructureMap = new Map<Id,Id>();
        for(Pricing_Structure__c ps: pricingStructureList) {
            standardPricingStructureMap.put(ps.Program__c, ps.Id);
        }
        
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        
        for (Opportunity oppty: oppList) {
            for(PricebookEntry pbe: livongoPBEntriesList) {
                oliList.add(TestFactory.createOpportunityLineItem(oppty.Id, pbe.Id));
            }
        }
        
        insert oliList;
        
        for(OpportunityLineItem oli: oliList) {
            oli.Product_Participants__c = 100;
            oli.UnitPrice = 62.00;
            oli.OpportunityProductName__c = 'Livongo for Diabetes';
        }
        
        update oliList;
    }
    
    private static Account getAccountById(Id accId) {
        return [SELECT Id, Name, Client_ARR__c FROM Account WHERE Id = :accId LIMIT 1];
    }
    
    private static Set<Id> getAccountIdSet() {
        Map<Id, Account> accIdMap = new Map<Id, Account>([SELECT Id FROM Account LIMIT 200]);
        Set<Id> accIdSet = new Set<Id>(accIdMap.keySet());
        return accIdSet;
    }
    
    private static Opportunity getOpportunityByType(String Type) {
        return [SELECT Id, Name, AccountId, Type, Gross_ARR__c, Adjusted_Annual_Renewal_Value_Enrolled__c,
                Livongo_for_Diabetes_PPPM__c, Livongo_for_Diabetes_PwDs__c, Account.Client_Arr__c, CloseDate, 
                (SELECT Id, Product_Participants__c, UnitPrice, Pricing_Structure__r.Name, Quantity, Program_Family__c, 
                 Gross_Program_ARR__c, Gross_Program_ARR_Copy__c FROM OpportunityLineItems)
                FROM Opportunity WHERE Type = :Type LIMIT 1];
    }
    
    private static PricebookEntry getPBE() {
        return [SELECT Id FROM PricebookEntry WHERE Product2.Name = 'Livongo for Diabetes' AND Pricebook2.Name = 'Livongo' LIMIT 1];
    }
    
    private static List<OpportunityLineItem> getOLI() {
        return [SELECT Id, Name, Product_Participants__c,OpportunityProductName__c, UnitPrice, Pricing_Structure__r.Name, Quantity, Program_Family__c, Gross_Program_ARR__c, 
                Gross_Program_ARR_Copy__c FROM OpportunityLineItem]; 
    }
    
    @isTest
    static void singleNBOpportunityTest() {
        Opportunity opp = getOpportunityByType(NEW_BUSINESS);
        opp.StageName = 'Closed Won';
        
        Test.startTest();
        update opp;
        Test.stopTest();
        
        Account acc = getAccountById(opp.AccountId);
        
        System.assertEquals(opp.Gross_ARR__c , acc.Client_Arr__c);
    }
    
    @isTest
    static void singleRenewalOpportunityTest() {
        Opportunity opp = getOpportunityByType(RENEWAL);
        opp.StageName = 'Closed Won';
        
        Test.startTest();
        update opp;
        Test.stopTest();
        
        Account acc = getAccountById(opp.AccountId);
        
        System.assertEquals(opp.Adjusted_Annual_Renewal_Value_Enrolled__c , acc.Client_Arr__c);
    }
    
    @isTest
    static void newBusinessAndRenewalOpportunityTest() {
        Opportunity nbOpp = getOpportunityByType(NEW_BUSINESS);
        nbOpp.StageName = 'Closed Won';
        Opportunity renewalOpp = getOpportunityByType(RENEWAL);
        renewalOpp.StageName = 'Closed Won';
        
        Test.startTest();
        update nbOpp;
        update renewalOpp; 
        Test.stopTest();
        
        Account acc = getAccountById(renewalOpp.AccountId);
        
        System.assertEquals(renewalOpp.Adjusted_Annual_Renewal_Value_Enrolled__c , acc.Client_Arr__c);
    }
    
    @isTest
    static void renewalAndContractPathChangeOpportunityTest() {
        Opportunity renewalOpp = getOpportunityByType(RENEWAL);
        renewalOpp.StageName = 'Closed Won';

        Opportunity contractPathChangeOpp = getOpportunityByType(CONTRACTPATHCHANGE);
        contractPathChangeOpp.StageName = 'Closed Won';
        contractPathChangeOpp.CloseDate = Date.today().addDays(-1);
        
        Test.startTest();
        update renewalOpp; 
        update contractPathChangeOpp;
        Test.stopTest();
        
        Account acc = getAccountById(renewalOpp.AccountId);
        
        System.assertEquals(renewalOpp.Adjusted_Annual_Renewal_Value_Enrolled__c , acc.Client_Arr__c);
    }
    
    @isTest
    static void renewalAndContractPathChangeOpportunityTest2() {
        Opportunity renewalOpp = getOpportunityByType(RENEWAL);
        renewalOpp.StageName = 'Closed Won';
        renewalOpp.CloseDate = Date.today().addDays(-1);

        Opportunity contractPathChangeOpp = getOpportunityByType(CONTRACTPATHCHANGE);
        contractPathChangeOpp.StageName = 'Closed Won';
        
        Test.startTest();
        update renewalOpp; 
        update contractPathChangeOpp;
        Test.stopTest();
        
        Account acc = getAccountById(contractPathChangeOpp.AccountId);
        
        System.assertEquals(contractPathChangeOpp.Gross_ARR__c , acc.Client_Arr__c);
    }
    
    @isTest
    static void renewalAndExpansionOpportunityTest() {
        Opportunity renewalOpp = getOpportunityByType(RENEWAL);
        renewalOpp.StageName = 'Closed Won';
        renewalOpp.CloseDate = Date.today().addDays(-1);

        Opportunity expansionOpp = getOpportunityByType(EXPANSION);
        expansionOpp.StageName = 'Closed Won';
        
        Test.startTest();
        update renewalOpp; 
        update expansionOpp;
        Test.stopTest();
        
        Account acc = getAccountById(expansionOpp.AccountId);
        
        System.assertEquals(expansionOpp.Gross_ARR__c + renewalOpp.Adjusted_Annual_Renewal_Value_Enrolled__c, acc.Client_Arr__c);
    }
    
    @isTest
    static void renewalAndExpansionOpportunityTest2() {
        Opportunity renewalOpp = getOpportunityByType(RENEWAL);
        renewalOpp.StageName = 'Closed Won';

        Opportunity expansionOpp = getOpportunityByType(EXPANSION);
        expansionOpp.StageName = 'Closed Won';
        expansionOpp.CloseDate = Date.today().addDays(-1);
        
        PricebookEntry pbe = getPBE();
        OpportunityLineItem oli = TestFactory.createOpportunityLineItem(expansionOpp.Id, pbe.Id);
        insert oli;
        
        Test.startTest();
        update renewalOpp; 
        update expansionOpp;
        Boolean isProdutsMatched = OpportunityService.findIfOppProductsMatch(renewalOpp, expansionOpp);
        Test.stopTest();
        
        Account acc = getAccountById(expansionOpp.AccountId);
        
        System.assertEquals(isProdutsMatched, false);
        //System.assertEquals(expansionOpp.Gross_ARR__c + renewalOpp.Adjusted_Annual_Renewal_Value_Enrolled__c, acc.Client_Arr__c);
    }
    
    @isTest
    static void newBusinessAndContractPathChangeOpportunityTest() {
        Opportunity nbOpp = getOpportunityByType(NEW_BUSINESS);
        nbOpp.StageName = 'Closed Won';
        nbOpp.CloseDate = Date.today().addDays(-1);
        
        Opportunity contractPathChangeOpp = getOpportunityByType(CONTRACTPATHCHANGE);
        contractPathChangeOpp.StageName = 'Closed Won';
        
        Test.startTest();
        update nbOpp;
        update contractPathChangeOpp; 
        Test.stopTest();
        
        Account acc = getAccountById(contractPathChangeOpp.AccountId);
        
        System.assertEquals(contractPathChangeOpp.Gross_ARR__c , acc.Client_Arr__c);
    }
    
    @isTest
    static void newBusinessAndExpansionOpportunityTest() {
        Opportunity nbOpp = getOpportunityByType(NEW_BUSINESS);
        nbOpp.StageName = 'Closed Won';
        
        Opportunity expansionOpp = getOpportunityByType(EXPANSION);
        expansionOpp.StageName = 'Closed Won';
        
        Test.startTest();
        update nbOpp;
        update expansionOpp; 
        Test.stopTest();
        
        Account acc = getAccountById(expansionOpp.AccountId);
        
        System.assertEquals(nbOpp.Gross_ARR__c + expansionOpp.Gross_ARR__c, acc.Client_Arr__c);
    }
    
    @isTest
    static void clientARRUpdateFromAccountTest(){
        Set<Id> accIdSet = getAccountIdSet();
        
        Opportunity nbOpp = getOpportunityByType(NEW_BUSINESS);
        nbOpp.StageName = 'Closed Won';
        
        Opportunity expansionOpp = getOpportunityByType(EXPANSION);
        expansionOpp.StageName = 'Closed Won';

        Test.startTest();
        update nbOpp;
        update expansionOpp; 
        OpportunityService.handleClientARRUpdateFromAccount(accIdSet);
        Test.stopTest();
        
        Account acc = getAccountById(expansionOpp.AccountId);
        
        System.assertEquals(nbOpp.Gross_ARR__c + expansionOpp.Gross_ARR__c, acc.Client_Arr__c);
    }
    
    @isTest
    static void healthScoresTest() {
        Opportunity opp = getOpportunityByType(RENEWAL);
        opp.CloseDate = Date.today().addMonths(24);
        
        Test.startTest();
        update opp;
        Test.stopTest();
        
        List<Health_Score__c> hsList = [SELECT Id, Account__c, Actual_Result__c FROM Health_Score__c 
                                            WHERE Account__c = :opp.AccountId AND RecordType.Name = 'Account Health Score' 
                                            AND Health_Segment__c = 'Renewal Timing'];
        Health_Score__c hsScore = hsList[0];
        
        System.assertEquals('>1 year', hsScore.Actual_Result__c);
    }
}
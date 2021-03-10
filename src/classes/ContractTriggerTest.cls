@isTest
public class ContractTriggerTest {

    public static final Id PROGRAM_OVERVIEW_RT = Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Program_Overview').getRecordTypeId();
    public static final Id OPPORTUNITY_PARTNERSHIP_RT = Schema.SObjectType.Relationship__c.getRecordTypeInfosByDeveloperName().get('Opportunity_Partnership').getRecordTypeId();
    public static final Integer DEFAULT_FALLBACK_VALUE = Integer.valueOf(System.Label.Default_Renewal_Opp_Fallback_Value);
	public static final String DM_SOLUTION = System.Label.DM_Solution;
    public static final String CV_SOLUTION = System.Label.CV_Solution;
    public static final String DP_SOLUTION = System.Label.DP_Solution;
    
    @TestSetup
    static void setupData() {
        Account clientAccount = TestFactory.createClientAccount();
        Account partnerAccount = TestFactory.createPartnerAccount();

        Contract clientOverview = TestFactory.createClientOverview();
        Contract programOverview = TestFactory.createProgramOverview();
        Contract programOverview2 = TestFactory.createProgramOverview();
        Contract programOverview3 = TestFactory.createProgramOverview();

        Pricebook2 livongoPricebook = TestFactory.createPricebook();
        insert livongoPricebook;

        List<Product2> programs = new List<Product2>();
        Product2 program = TestFactory.createProgram('Diabetes');
        Product2 program2 = TestFactory.createProgram('Hypertension');
        Product2 program3 = TestFactory.createProgram('Prediabetes');
        programs.add(program);
        programs.add(program2);
        programs.add(program3);
        insert programs;

        Id standardPBId = Test.getStandardPricebookId();
        PricebookEntry standardPBE1 = TestFactory.createPricebookEntry(standardPBId, program.Id);
        PricebookEntry standardPBE2 = TestFactory.createPricebookEntry(standardPBId, program2.Id);
        PricebookEntry standardPBE3 = TestFactory.createPricebookEntry(standardPBId, program3.Id);
        PricebookEntry pbe1 = TestFactory.createPricebookEntry(livongoPricebook.Id, program.Id);
        PricebookEntry pbe2 = TestFactory.createPricebookEntry(livongoPricebook.Id, program2.Id);
        PricebookEntry pbe3 = TestFactory.createPricebookEntry(livongoPricebook.Id, program3.Id);

        List<PricebookEntry> entries = new List<PricebookEntry>();
        entries.add(standardPBE1);
        entries.add(standardPBE2);
        entries.add(standardPBE3);
        entries.add(pbe1);
        entries.add(pbe2);
        entries.add(pbe3);
        insert entries;
        
        List<Pricing_Structure__c> pricingStructureList = new List<Pricing_Structure__c>();
        for (Product2 p :programs) {
            pricingStructureList.add(TestFactory.createPricingStructure(livongoPricebook.Id, p.Id));
        }
        insert pricingStructureList;

        List<Account> accounts = new List<Account>();
        accounts.add(clientAccount);
        accounts.add(partnerAccount);
        insert accounts;

        clientOverview.AccountId = clientAccount.Id;
        clientOverview.Contract_Path__c = partnerAccount.Id;
        clientOverview.CSM__c = System.UserInfo.getUserId();

        List<Contract> cList = new List<Contract>();
        cList.add(clientOverview);
        insert cList;

        Opportunity opp = TestFactory.createOpportunity();
        opp.AccountId = clientAccount.Id;
        opp.ContractId = clientOverview.Id;
        insert opp;

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
        upsert cList;
    }

    private static Pricebook2 getPricebook() {
        return [SELECT Id, Name FROM Pricebook2 WHERE Name = 'Livongo'];
    }

    private static List<Contract> getProgramOverviews() {
        return [SELECT Id, Program_End_Date__c, Complete_Per_Legal__c, Client_Overview__c, RecordTypeId, AccountId, Program_Name__c, 
                Actual_Launch_Date__c, Last_Date_of_Data_Refresh__c, Outreach_Stratification__c FROM Contract WHERE RecordTypeId = :PROGRAM_OVERVIEW_RT];
    }

    private static List<Contract> getClientOverview() {
        return [SELECT Id, CSM__c, CIM__c, Contract_Path__c, AccountId FROM Contract];
    }

    private static Contract getClientOverviewFromProgramOverview(Id clientOverviewId) {
        return [SELECT Id, CSM__c, CIM__c, Contract_Path__c, AccountId, Account.Name, Account.OwnerId FROM Contract WHERE Id = :clientOverviewId];
    }

    private static List<Opportunity> getOpportunities() {
        return [SELECT Id, Name, AccountId, Type, StageName, OwnerId, Contract_Path__c, ContractId, CloseDate FROM Opportunity];
    }

    private static List<Opportunity> getOpportunitiesWithIds(Set<Id> idSet) {
            return [SELECT Id, Name, AccountId, Type, StageName, OwnerId, Contract_Path__c, ContractId, CloseDate FROM Opportunity WHERE Id IN :idset];
    }

    private static List<OpportunityLineItem> getOpportunityPrograms() {
        return [SELECT Id, OpportunityId, Program_Family__c, UnitPrice, Product2Id, Product_Participants__c FROM OpportunityLineItem];
    }
    
    private static List<PricebookEntry> getlivongoPBEntriesList() {
        return [SELECT Id, Pricebook2Id, Product2Id, UnitPrice, IsActive, Product2.Name FROM PricebookEntry WHERE Pricebook2.Name = 'Livongo'];
    }
    
    private static List<Pricing_Structure__c> getLivongoPBPricingStructures() {
        return [SELECT Id, Program__c, Program__r.Id, Program__r.Name FROM Pricing_Structure__c WHERE Price_Book__r.Name = 'Livongo'];
    }
    
    @isTest
    static void getProgramAbbreviationsTest() {
        Program_Abbreviation__mdt[] programMdts = [SELECT Program_Name__c, Abbreviation__c FROM Program_Abbreviation__mdt];
        Map<String, String> programsToAbbreviations = new Map<String, String>();
        for (Program_Abbreviation__mdt programMdt : programMdts) {
            programsToAbbreviations.put(programMdt.Program_Name__c, programMdt.Abbreviation__c);
        }
        
        Test.startTest();
        
        Map<String, String> abbreviations = ContractService.abbreviations;
        
        Test.stopTest();
        
        System.assertNotEquals(null, abbreviations);
        System.assertEquals(true, abbreviations.containsKey('Diabetes'));
        System.assertEquals('DM', abbreviations.get('Diabetes'));
        System.assertEquals(true, abbreviations.containsKey('Hypertension'));
        System.assertEquals('HTN', abbreviations.get('Hypertension'));
        System.assertEquals(true, abbreviations.containsKey('Behavioral Health'));
        System.assertEquals('BH', abbreviations.get('Behavioral Health'));
        System.assertEquals(true, abbreviations.containsKey('Prediabetes'));
        System.assertEquals('DPP', abbreviations.get('Prediabetes'));
        System.assertEquals(true, abbreviations.containsKey('Weight Management'));
        System.assertEquals('WM', abbreviations.get('Weight Management'));
    }

    @isTest
    static void contractUpdateNoCompletePerLegalChangeTest() {
        List<Contract> pos = getProgramOverviews();
        for (Contract po : pos) {
              po.PPPM__c = 999;
        }

        Test.startTest();

        update pos;

        Test.stopTest();

        List<OpportunityLineItem> oppPrograms = getOpportunityPrograms();
        List<Opportunity> opportunities = getOpportunities();

        System.assertEquals(0, oppPrograms.size());
        //1, because opp created already in test setup
        System.assertEquals(1, opportunities.size());
    }

    @isTest
    static void contractUpdateCompletedPerLegalChangeButNoOpportunityAssociatedWithClientOverviewTest() {
        List<Opportunity> opportunities = getOpportunities();
       
        List<Relationship__c> opportunityPartnershipRelationships = [SELECT Id, RecordTypeId, Opportunity_Partnership__c FROM Relationship__c WHERE RecordTypeId = :OPPORTUNITY_PARTNERSHIP_RT AND Opportunity_Partnership__c = :opportunities[0].Id];
        //must delete opportunity partnership relationships before can delete opp.
        delete opportunityPartnershipRelationships;
        //once relationships deleted, delete opp.
        delete opportunities;

        List<Contract> pos = getProgramOverviews();
        for (Contract po : pos) {
            po.Program_End_Date__c = Date.today().addDays(10);
            po.Complete_Per_Legal__c = true;
        }

        Test.startTest();

        update pos;

        Test.stopTest();

        List<OpportunityLineItem> oppPrograms = getOpportunityPrograms();
        List<Opportunity> opps = getOpportunities();

        //None should get created because there is no Opp associated with the CO
        System.assertEquals(0, oppPrograms.size());
        //Initially inserted Opp deleted at beginning of this test method
        System.assertEquals(0, opps.size());

    }

    @isTest
    static void contractUpdateSameProgramEndDateOnProgramOverviewsTest() {

        List<Contract> pos = getProgramOverviews();
        for (Contract po : pos) {
            po.Program_End_Date__c = Date.today().addDays(5);
            po.Complete_Per_Legal__c = true;
        }

        Test.startTest();

        update pos;

        Test.stopTest();

        List<Contract> programOverviews = getProgramOverviews();
    
        for (Contract po : programOverviews) {
            System.assertEquals(Date.today().addDays(5), po.Program_End_Date__c);
        }

        List<OpportunityLineItem> oppPrograms = getOpportunityPrograms();
        Set<Id> oppIds = new Set<Id>();
        System.assertEquals(3, oppPrograms.size());
        for (OpportunityLineItem oppProgram : oppPrograms) {
            oppIds.add(oppProgram.OpportunityId);
        }

        List<Opportunity> opps = getOpportunitiesWithIds(oppIds);
        System.assertEquals(1, opps.size());
        System.assertEquals(Date.today().addDays(5), opps[0].CloseDate);
        System.assertEquals('Renewal', opps[0].Type);
        System.assertEquals('VOC', opps[0].StageName);
        System.assertEquals(System.UserInfo.getUserId(), opps[0].OwnerId);
        System.assertEquals(programOverviews[0].Client_Overview__c, opps[0].ContractId);
   
        for (OpportunityLineItem oppProgram : oppPrograms) {
            System.assertEquals(opps[0].Id, oppProgram.OpportunityId);
        }
    }

    @isTest
    static void contractUpdateDifferentProgramEndDateOnProgramOverviewsTest() {
        List<Contract> pos = getProgramOverviews();
        pos[0].Program_End_Date__c = Date.today().addDays(5);
        pos[0].Auto_Renewal__c = false;
        pos[0].Complete_Per_Legal__c = true;
        pos[1].Program_End_Date__c = Date.today().addDays(4);
        pos[1].Complete_Per_Legal__c = true;
        pos[2].Program_End_Date__c = Date.today().addDays(3);
        pos[2].Complete_Per_Legal__c = true;

        Test.startTest();

        update pos;

        Test.stopTest();
        
        List<OpportunityLineItem> oppPrograms = getOpportunityPrograms();
        Set<Id> oppIds = new Set<Id>();
        System.assertEquals(3, oppPrograms.size());
        for (OpportunityLineItem oppProgram : oppPrograms) {
            oppIds.add(oppProgram.OpportunityId);
        }

        List<Opportunity> opps = getOpportunitiesWithIds(oppIds);
        System.assertEquals(3, opps.size());
    }

    @isTest
    static void contractUpdateExistingOpportunityMatchTest() {
        Opportunity o = TestFactory.createOpportunity();
        o.Name = String.valueOf(System.today().year()) + ' Renewal - ' + TestFactory.createClientAccount().Name + ' - DM - Auto-renewal';
        o.CloseDate = Date.today().addDays(5);

        Contract po = [SELECT Id, Program_End_Date__c, Client_Overview__c, RecordTypeId, AccountId FROM Contract WHERE RecordTypeId = :PROGRAM_OVERVIEW_RT AND Program_Name__c = 'Hypertension' LIMIT 1];
        po.Program_End_Date__c = Date.today().addDays(5);
        po.Complete_Per_Legal__c = true;

        Contract clientOverview = getClientOverviewFromProgramOverview(po.Client_Overview__c);

        Pricebook2 pb = getPricebook();

        o.AccountId = clientOverview.AccountId;
        o.Contract_Path__c = clientOverview.Contract_Path__c;
        o.Pricebook2Id = pb.Id;
        o.OwnerId = clientOverview.CSM__c;
        o.ContractId = clientOverview.Id;

        insert o;

        Test.startTest();

        update po;

        Test.stopTest();
        
        List<OpportunityLineItem> oppPrograms = getOpportunityPrograms();
        System.assertEquals(1, oppPrograms.size());
        
        Set<Id> oppIds = new Set<Id>();
        oppIds.add(oppPrograms[0].OpportunityId);

        List<Opportunity> opps = getOpportunitiesWithIds(oppIds);
        System.assertEquals(1, opps.size());
        System.assertEquals(Date.today().addDays(5), opps[0].CloseDate);
        System.assertEquals('Renewal', opps[0].Type);
        System.assertEquals('Selling', opps[0].StageName);
        System.assertEquals(System.UserInfo.getUserId(), opps[0].OwnerId);
        System.assertEquals(po.Client_Overview__c, opps[0].ContractId);
        System.assertEquals(true, opps[0].Name.contains('HTN'));
        System.assertEquals(true, opps[0].Name.contains('DM'));

        System.assertEquals(opps[0].Id, oppPrograms[0].OpportunityId);
        System.assertEquals('Hypertension', oppPrograms[0].Program_Family__c);

    }

    @isTest
    static void contractUpdateExistingOpportunityMatchLongOpportunityNameTest() {
        Opportunity o = TestFactory.createOpportunity();
        o.Name = String.valueOf(System.today().year()) + ' Renewal - ' + TestFactory.createClientAccount().Name + ' - Really Really Really Really Really Really Really Really Really Unrealistically Long Program Name - Auto-renewal';
        o.Name = o.Name.substring(0,120);
        o.CloseDate = Date.today().addDays(5);

        Contract po = [SELECT Id, Program_End_Date__c, Client_Overview__c, RecordTypeId, AccountId FROM Contract WHERE RecordTypeId = :PROGRAM_OVERVIEW_RT AND Program_Name__c = 'Hypertension' LIMIT 1];
        po.Program_End_Date__c = Date.today().addDays(5);
        po.Complete_Per_Legal__c = true;

        Contract clientOverview = getClientOverviewFromProgramOverview(po.Client_Overview__c);

        Pricebook2 pb = getPricebook();

        o.AccountId = clientOverview.AccountId;
        o.Contract_Path__c = clientOverview.Contract_Path__c;
        o.Pricebook2Id = pb.Id;
        o.OwnerId = clientOverview.CSM__c;
        o.ContractId = clientOverview.Id;

        insert o;

        Test.startTest();

        update po;

        Test.stopTest();

        
        List<OpportunityLineItem> oppPrograms = getOpportunityPrograms();
        System.assertEquals(1, oppPrograms.size());
        
        Set<Id> oppIds = new Set<Id>();
        oppIds.add(oppPrograms[0].OpportunityId);

        List<Opportunity> opps = getOpportunitiesWithIds(oppIds);
        System.assertEquals(1, opps.size());
    }

    @isTest
    static void contractUpdateCheckThatDuplicateProgramsAreNotIncludedInOppNameTest() {
        List<Contract> pos = getProgramOverviews();
        for (Contract po : pos) {
            po.Complete_Per_Legal__c = true;
        }
        //create new Program Overview
        Contract programOverview = TestFactory.createProgramOverview();
        Contract clientOverview = getClientOverviewFromProgramOverview(pos[0].Client_Overview__c);
        programOverview.Client_Overview__c = clientOverview.Id;
        programOverview.AccountId = clientOverview.AccountId;
        //Make the program one that already exists (duplicate) in the set of POs
        //this will map to DPP in the abbreviations map
        programOverview.Program_Name__c = 'Prediabetes';
        insert programOverview;

        programOverview.Complete_Per_Legal__c = true;
        pos.add(programOverview);
        system.debug('pos:::'+pos);
        
        Test.startTest();

        update pos;

        Test.stopTest();

        List<OpportunityLineItem> oppPrograms = getOpportunityPrograms();

        Set<Id> oppIds = new Set<Id>();
        for (OpportunityLineItem oppProgram : oppPrograms) {
            oppIds.add(oppProgram.OpportunityId);
        }

        List<Opportunity> opps = getOpportunitiesWithIds(oppIds);
        System.assertEquals(1, opps.size());

        String oppName = opps[0].Name;
        String[] oppNameTokens = oppName.split(' ');
        Map<String, Integer> tokenToCount = new Map<String, Integer>();
        for (String oppNameToken : oppNameTokens) {
            //exclude '-' (dash) character
            if (!oppNameToken.equals('-')) {
                if (tokenToCount.containsKey(oppNameToken)) {
                    Integer count = tokenToCount.get(oppNameToken);
                    count++;
                }
                else {
                    tokenToCount.put(oppNameToken, 1);
                }
            }
        }
        //Make sure only one DPP is in the name; duplicated programs shouldn't be included in Opp name
        System.assertEquals(1, tokenToCount.get('DPP'));
    }

    @isTest
    static void contractUpdatePPPMFromPOIsNullTest() {
        List<Contract> pos = getProgramOverviews();
        pos[0].Program_End_Date__c = Date.today().addDays(5);
        pos[0].Complete_Per_Legal__c = true;
        pos[0].PPPM__c = null;
        pos[1].Program_End_Date__c = Date.today().addDays(4);
        pos[1].Complete_Per_Legal__c = true;
        pos[2].Program_End_Date__c = Date.today().addDays(3);
        pos[2].Complete_Per_Legal__c = true;

        Test.startTest();

        update pos;

        Test.stopTest();

        List<Opportunity> opps = getOpportunities();
        
        //4, because there's the initial opp inserted in testsetup
        System.assertEquals(4, opps.size());

        List<OpportunityLineItem> oppPrograms = getOpportunityPrograms();
        System.assertEquals(3, oppPrograms.size());
        System.assertEquals(DEFAULT_FALLBACK_VALUE, oppPrograms[0].UnitPrice);
    }

    @isTest
    static void contractUpdateParticipantsFromPOIsNullTest() {
        List<Contract> pos = getProgramOverviews();
        pos[0].Program_End_Date__c = Date.today().addDays(5);
        pos[0].Complete_Per_Legal__c = true;
        pos[0].Participants__c = null;
        pos[1].Program_End_Date__c = Date.today().addDays(4);
        pos[1].Complete_Per_Legal__c = true;
        pos[2].Program_End_Date__c = Date.today().addDays(3);
        pos[2].Complete_Per_Legal__c = true;

        Test.startTest();

        update pos;

        Test.stopTest();

        List<Opportunity> opps = getOpportunities();
        
        //4, because there's the initial opp inserted in testsetup
        System.assertEquals(4, opps.size());

        List<OpportunityLineItem> oppPrograms = getOpportunityPrograms();
        System.assertEquals(3, oppPrograms.size());
        System.assertEquals(DEFAULT_FALLBACK_VALUE, oppPrograms[0].Product_Participants__c);
    }
    
    @isTest
    static void contractUpdateCSMIsNullTest() {
        List<Contract> pos = getProgramOverviews();
        
        for(Contract po: pos) {
            po.Program_End_Date__c = Date.today().addDays(5);
            po.Complete_Per_Legal__c = true;
        }
        
        Contract clientOverview = getClientOverviewFromProgramOverview(pos[0].Client_Overview__c);
        clientOverview.CSM__c = null;
        update clientOverview;

        Test.startTest();

        update pos;

        Test.stopTest();
        
    }
    
    @isTest
    static void contractUpdateDownMarketCSMIsNullTest() {
        List<Contract> pos = getProgramOverviews();
        
        for(Contract po: pos) {
            po.Program_End_Date__c = Date.today().addDays(5);
            po.Complete_Per_Legal__c = true;
        }
        
        Contract clientOverview = getClientOverviewFromProgramOverview(pos[0].Client_Overview__c);
        clientOverview.CSM__c = null;
        clientOverview.Population_Type__c = 'ASO downmarket';
        update clientOverview;

        Test.startTest();

        update pos;

        Test.stopTest();

    }
    
    @isTest
    static void handleContractDelete() {
        DmlException expectedException;
        List<Contract> clientOverview = getClientOverview();
        
        Test.startTest();
        
        try {
            delete clientOverview;
        }
        catch(DmlException d) {
            expectedException = d;
        }
        
        Test.stopTest();
        System.assertNotEquals(Null, expectedException, 'Your attempt to delete this client overview could not be completed because it has associated program overview(s)');
    }
    
    @isTest
    static void createRelatedCOPOTest() {
        List<Id> oppIdList = new List<Id>();
        List<Opportunity> oppList = getOpportunities();
        List<PricebookEntry> entryList = getlivongoPBEntriesList();
        List<PricebookEntry> strandardPBEEntryList = new List<PricebookEntry>();
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        List<Product2> wpPrograms = new List<Product2>();
        List<Pricing_Structure__c> pricingStructures = getLivongoPBPricingStructures();
        Map<Id, Pricing_Structure__c> programsToPricingStructureMap = new Map<Id, Pricing_Structure__c>();
        Pricebook2 livongoPricebook = getPricebook();
        Id standardPBId = Test.getStandardPricebookId();
        String oppIdString;
        List<String> oppSource = new List<String>();
        List<List<String>> oppSourceList = new List<List<String>>();
        
        if (!pricingStructures.isEmpty()) {
            for (Pricing_Structure__c ps: pricingStructures) {
                if (ps.Program__r.Name.contains('Hypertension')) {
                    ps.Name = 'Standard HTN w/Cellular';
                }
                programsToPricingStructureMap.put(ps.Program__r.Id, ps);
            }
            update pricingStructures;
        }
        
        Product2 wpProgram1 = TestFactory.createWPProgram(DM_SOLUTION, 'Diabetes');
        Product2 wpProgram2 = TestFactory.createWPProgram(CV_SOLUTION, 'Hypertension');
        Product2 wpProgram3 = TestFactory.createWPProgram(DP_SOLUTION, 'Prediabetes');
        Product2 standalone = TestFactory.createProgram('Behavioral Health');
        
        wpPrograms.add(wpProgram1);
        wpPrograms.add(wpProgram2);
        wpPrograms.add(wpProgram3);
        wpPrograms.add(standalone);
        
        insert wpPrograms;
        
        for (Product2 program: wpPrograms) {
            PricebookEntry standardPbe = TestFactory.createPricebookEntry(standardPBId, program.Id);
            PricebookEntry pbe = TestFactory.createPricebookEntry(livongoPricebook.Id, program.Id);
            strandardPBEEntryList.add(standardPbe);
            entryList.add(pbe);
        }
        
		insert strandardPBEEntryList;
		upsert entryList;        
        
        for (Opportunity opp: oppList) {
            oppIdList.add(opp.Id);
            for(PricebookEntry pbe: entryList) {
                OpportunityLineItem oli = TestFactory.createOpportunityLineItem(opp.Id, pbe.Id);
                oli.Price_Book_ID__c = pbe.Pricebook2Id;
                oli.Program_ID__c = pbe.Product2Id;
                oli.Pricing_Structure__c = programsToPricingStructureMap.get(pbe.Product2Id) != null ? programsToPricingStructureMap.get(pbe.Product2Id).Id : null;
                oliList.add(oli);
            }
        }
        insert oliList;
        System.debug(oppIdList[0]);
        oppSource.add(oppIdList[0]);
        oppSourceList.add(oppSource);
        Test.startTest();
        ContractService.createdRelatedCoPo(oppSourceList);
        Test.stopTest();
    }
    
    @isTest
    static void wholePersonTransitionTest() {
        List<Id> oppIdList = new List<Id>();
        List<Opportunity> oppList = getOpportunities();
        List<PricebookEntry> entryList = getlivongoPBEntriesList();
        List<PricebookEntry> strandardPBEEntryList = new List<PricebookEntry>();
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        List<Product2> wpPrograms = new List<Product2>();
        List<Pricing_Structure__c> pricingStructures = getLivongoPBPricingStructures();
        Map<Id, Pricing_Structure__c> programsToPricingStructureMap = new Map<Id, Pricing_Structure__c>();
        Pricebook2 livongoPricebook = getPricebook();
        Id standardPBId = Test.getStandardPricebookId();
        String oppIdString;
        List<String> oppSource = new List<String>();
        List<List<String>> oppSourceList = new List<List<String>>();
        
        if (!pricingStructures.isEmpty()) {
            for (Pricing_Structure__c ps: pricingStructures) {
                if (ps.Program__r.Name.contains('Hypertension')) {
                    ps.Name = 'Standard HTN w/Cellular';
                }
                programsToPricingStructureMap.put(ps.Program__r.Id, ps);
            }
            update pricingStructures;
        }
        
        Product2 wpProgram1 = TestFactory.createWPProgram(DM_SOLUTION, 'Diabetes');
        Product2 wpProgram2 = TestFactory.createWPProgram(CV_SOLUTION, 'Hypertension');
        Product2 wpProgram3 = TestFactory.createWPProgram(DP_SOLUTION, 'Prediabetes');
        Product2 standalone = TestFactory.createProgram('Behavioral Health');
        
        wpPrograms.add(wpProgram1);
        wpPrograms.add(wpProgram2);
        wpPrograms.add(wpProgram3);
        wpPrograms.add(standalone);
        
        insert wpPrograms;
        
        for (Product2 program: wpPrograms) {
            PricebookEntry standardPbe = TestFactory.createPricebookEntry(standardPBId, program.Id);
            PricebookEntry pbe = TestFactory.createPricebookEntry(livongoPricebook.Id, program.Id);
            strandardPBEEntryList.add(standardPbe);
            entryList.add(pbe);
        }
        
		insert strandardPBEEntryList;
		upsert entryList;
        
        List<Contract> pos = getProgramOverviews();
        for (Contract po : pos) {
            po.Complete_Per_Legal__c = true;
            po.Program_Type__c = 'Standalone';
            po.Status = 'Active';
        }
        
        update pos;
        Contract clientOverview = getClientOverviewFromProgramOverview(pos[0].Client_Overview__c);
        
        for (Opportunity opp: oppList) {
            oppIdList.add(opp.Id);
            for(PricebookEntry pbe: entryList) {
                OpportunityLineItem oli = TestFactory.createOpportunityLineItem(opp.Id, pbe.Id);
                oli.Price_Book_ID__c = pbe.Pricebook2Id;
                oli.Program_ID__c = pbe.Product2Id;
                oli.Pricing_Structure__c = programsToPricingStructureMap.get(pbe.Product2Id) != null ? programsToPricingStructureMap.get(pbe.Product2Id).Id : null;
                oliList.add(oli);
            }
        }
        insert oliList;
        
        oppSource.add(oppIdList[0]);
        oppSource.add(clientOverview.Id);
        oppSource.add('Whole Person Program Overview Transition');
        oppSourceList.add(oppSource);
        
        Test.startTest();
        ContractService.createdRelatedCoPo(oppSourceList);
        Test.stopTest();
    }
    
    @isTest
    static void updateHelathScoresTest() {
        List<Contract> programOverviews = getProgramOverviews();
        Set<Id> accIdSet = new Set<Id>();
        for (Contract program : programOverviews) {
            program.Actual_Launch_Date__c = Date.today();
            program.Outreach_Stratification__c = 'A';
            accIdSet.add(program.AccountId);
        }
        Test.startTest();
        update programOverviews;
        Test.stopTest();
        
        List<Health_Score__c> hsList = [SELECT Id, Actual_Result__c FROM Health_Score__c WHERE Account__c IN :accIdSet AND Health_Segment__c = 'Client Launch Date'];
        for (Health_Score__c hs : hsList) {
            System.assertEquals(String.valueOf(Date.today().format()), hs.Actual_Result__c);
        }
    }
}
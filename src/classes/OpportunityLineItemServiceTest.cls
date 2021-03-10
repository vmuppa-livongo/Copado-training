@isTest
public with sharing class OpportunityLineItemServiceTest {
    
    public static final String DM_SOLUTION = System.Label.DM_Solution;
    public static final String CV_SOLUTION = System.Label.CV_Solution;
    public static final String DP_SOLUTION = System.Label.DP_Solution;
    public static Map<String, Decimal> programToParticipantPercentMap = new Map<String, Decimal>();
    
    @TestSetup
    static void testData(){
        Account clientAccount = TestFactory.createClientAccount();
        insert clientAccount;      
        
        Opportunity newBusinessOpp = TestFactory.createTypeBasedOpportunity('New Business');
        newBusinessOpp.AccountId = clientAccount.Id;
        newBusinessOpp.Opportunity_Covered_Lives__c=10000;     
        insert newBusinessOpp;
        
        Pricebook2 livongoPricebook = TestFactory.createPricebook();
        insert livongoPricebook;
        
        List<Product2> programsList = new List<Product2>();
        programsList.add(TestFactory.createProgram('Livongo for Diabetes'));
        programsList.add(TestFactory.createProgram('Livongo for Hypertension'));
        programsList.add(TestFactory.createProgram('Livongo Diabetes Prevention Program'));
        programsList.add(TestFactory.createProgram('Livongo for Weight Management'));
        programsList.add(TestFactory.createProgram('Livongo for Behavioral Health by myStrength 2.0'));
        programsList.add(TestFactory.createWPProgram(CV_SOLUTION, 'Hypertension'));
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
        
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        
        for(PricebookEntry pbe: livongoPBEntriesList) {
            oliList.add(TestFactory.createOpportunityLineItem(newBusinessOpp.Id, pbe.Id));
        }   
        insert oliList;        
    }
    
    private static Opportunity getOpportunity() {
        return [SELECT Id,Opportunity_Covered_Lives__c FROM Opportunity LIMIT 1];
    }
    
    private static Pricebook2 getPricebook() {
        return [SELECT Id, Name FROM Pricebook2 WHERE Name = 'Livongo'];
    }    
    
    private static List<OpportunityLineItem> getOLI() {
        return [SELECT Id, Program_ID__c, OpportunityProductName__c, Opportunity.Opportunity_Covered_Lives__c, Product_Participants__c,
                Pricing_Structure__c, Quantity, UnitPrice, Gross_Program_ARR__c, Gross_Program_ARR_Copy__c, Program_ARR__c, Program_ARR_Copy__c, 
                Gross_Program_TCV__c, Gross_Program_TCV_Copy__c, Bypass_Sales_Price_Validation__c FROM OpportunityLineItem];
    }
    
    
    static {
        Map<String, Decimal> ppMap = new Map<String, Decimal>();
        Program_Participant__mdt[] ppMDT = [SELECT Program_Name__c, ParticipantPercentage__c FROM Program_Participant__mdt];
        for (Program_Participant__mdt pp: ppMDT) {
            ppMap.put(pp.Program_Name__c, pp.ParticipantPercentage__c);
        }
        programToParticipantPercentMap = ppMap;        
    }
    
    @isTest
    static void calculateProgramParticipantsTest() {
        Opportunity opp=getOpportunity();               
        List<List<OpportunityLineItem>> OppLineItemList = new List<List<OpportunityLineItem>>(); 
        List<List<OpportunityLineItem>> finalOppLineItemList = new List<List<OpportunityLineItem>>(); 
        List<OpportunityLineItem> oliList = getOLI();        
        OppLineItemList.add(oliList);       
        Test.startTest();
        finalOppLineItemList = OpportunityLineItemService.calculateProgramParticipants(OppLineItemList);
        Test.stopTest();
        
        system.assertEquals(6, finalOppLineItemList[0].size());        
        for (OpportunityLineItem finalList: finalOppLineItemList[0]) {              
            if(finalList.OpportunityProductName__c!= null && finalList.OpportunityProductName__c == CV_SOLUTION){
                system.assertEquals((programToParticipantPercentMap.get(CV_SOLUTION) * opp.Opportunity_Covered_Lives__c) , finalList.Product_Participants__c);
            }else if(finalList.OpportunityProductName__c!= null && finalList.OpportunityProductName__c == 'Livongo for Diabetes'){
                system.assertEquals((programToParticipantPercentMap.get('Livongo for Diabetes') * opp.Opportunity_Covered_Lives__c), finalList.Product_Participants__c);
            }else if(finalList.OpportunityProductName__c!= null && finalList.OpportunityProductName__c == 'Livongo for Hypertension'){
                system.assertEquals((programToParticipantPercentMap.get('Livongo for Hypertension') * opp.Opportunity_Covered_Lives__c), finalList.Product_Participants__c);
            }else if(finalList.OpportunityProductName__c!= null && finalList.OpportunityProductName__c == 'Livongo for Weight Management'){
                system.assertEquals((programToParticipantPercentMap.get('Livongo for Weight Management') * opp.Opportunity_Covered_Lives__c), finalList.Product_Participants__c);
            }else if(finalList.OpportunityProductName__c!= null && finalList.OpportunityProductName__c == 'Livongo Diabetes Prevention Program'){
                system.assertEquals((programToParticipantPercentMap.get('Livongo Diabetes Prevention Program') * opp.Opportunity_Covered_Lives__c), finalList.Product_Participants__c);
            }else if(finalList.OpportunityProductName__c!= null && finalList.OpportunityProductName__c == 'Livongo for Behavioral Health by myStrength 2.0'){
                system.assertEquals(opp.Opportunity_Covered_Lives__c, finalList.Product_Participants__c);
            }            
        }     
    }
    
    @isTest
    static void calculateProgramParticipantsTest1() {
        Opportunity opp = getOpportunity();
        List<List<OpportunityLineItem>> OppLineItemList = new List<List<OpportunityLineItem>>(); 
        List<List<OpportunityLineItem>> finalOppLineItemList = new List<List<OpportunityLineItem>>(); 
        List<OpportunityLineItem> oliList = getOLI();
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Pricebook2 livongoPricebook = getPricebook();
        Id standardPBId = Test.getStandardPricebookId();
        
        Product2 wpProgram = TestFactory.createWPProgram(DM_SOLUTION, 'Diabetes');
        insert wpProgram;
        
        PricebookEntry standardPbe = TestFactory.createPricebookEntry(standardPBId, wpProgram.Id);
        PricebookEntry pbe = TestFactory.createPricebookEntry(livongoPricebook.Id, wpProgram.Id);
        
        pbeList.add(standardPbe);
        pbeList.add(pbe);
        insert pbeList;
        
        OpportunityLineItem oli = TestFactory.createOpportunityLineItem(opp.Id, pbe.Id);
        oli.Price_Book_ID__c = pbe.Pricebook2Id;
        oli.Program_ID__c = pbe.Product2Id;
        insert oli;
        
        oliList.add(oli);
        
        OppLineItemList.add(OLIList);
        
        Test.startTest();
        finalOppLineItemList = OpportunityLineItemService.calculateProgramParticipants(OppLineItemList);
        Test.stopTest();
        
        for (OpportunityLineItem finalList: finalOppLineItemList[0]) {
            if(finalList.OpportunityProductName__c!= null && finalList.OpportunityProductName__c == CV_SOLUTION){
                system.assertEquals((programToParticipantPercentMap.get('CV + DM') * opp.Opportunity_Covered_Lives__c) , finalList.Product_Participants__c);
            }else if(finalList.OpportunityProductName__c!= null && finalList.OpportunityProductName__c == DM_SOLUTION){
                system.assertEquals((programToParticipantPercentMap.get(DM_SOLUTION) * opp.Opportunity_Covered_Lives__c) , finalList.Product_Participants__c);
            }
        }
    }
    
    @isTest
    static void calculateProgramParticipantsTest2() {
        Opportunity opp = getOpportunity();
        List<List<OpportunityLineItem>> OppLineItemList = new List<List<OpportunityLineItem>>(); 
        List<List<OpportunityLineItem>> finalOppLineItemList = new List<List<OpportunityLineItem>>(); 
        List<OpportunityLineItem> oliList = getOLI();
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Pricebook2 livongoPricebook = getPricebook();
        Id standardPBId = Test.getStandardPricebookId();
        
        Product2 wpProgram = TestFactory.createWPProgram(DP_SOLUTION, 'Prediabetes');
        insert wpProgram;
        
        PricebookEntry standardPbe = TestFactory.createPricebookEntry(standardPBId, wpProgram.Id);
        PricebookEntry pbe = TestFactory.createPricebookEntry(livongoPricebook.Id, wpProgram.Id);
        
        pbeList.add(standardPbe);
        pbeList.add(pbe);
        insert pbeList;
        
        OpportunityLineItem oli = TestFactory.createOpportunityLineItem(opp.Id, pbe.Id);
        oli.Price_Book_ID__c = pbe.Pricebook2Id;
        oli.Program_ID__c = pbe.Product2Id;
        insert oli;
        
        oliList.add(oli);
        
        OppLineItemList.add(oliList);
        
        Test.startTest();
        finalOppLineItemList = OpportunityLineItemService.calculateProgramParticipants(OppLineItemList);
        Test.stopTest();
        
        for (OpportunityLineItem finalList: finalOppLineItemList[0]) {
            if(finalList.OpportunityProductName__c!= null && finalList.OpportunityProductName__c == CV_SOLUTION){
                system.assertEquals((programToParticipantPercentMap.get('CV + DP') * opp.Opportunity_Covered_Lives__c) , finalList.Product_Participants__c);
            }else if(finalList.OpportunityProductName__c!= null && finalList.OpportunityProductName__c == DM_SOLUTION){
                system.assertEquals((programToParticipantPercentMap.get(DM_SOLUTION) * opp.Opportunity_Covered_Lives__c) , finalList.Product_Participants__c);
            }else if(finalList.OpportunityProductName__c!= null && finalList.OpportunityProductName__c == DP_SOLUTION){
                system.assertEquals((programToParticipantPercentMap.get(DP_SOLUTION) * opp.Opportunity_Covered_Lives__c) , finalList.Product_Participants__c);
            }
        }
    }
    
    @isTest
    static void calculateProgramParticipantsTest3() {
        Opportunity opp = getOpportunity();
        List<List<OpportunityLineItem>> OppLineItemList = new List<List<OpportunityLineItem>>(); 
        List<List<OpportunityLineItem>> finalOppLineItemList = new List<List<OpportunityLineItem>>(); 
        List<OpportunityLineItem> oliList = getOLI();
        List<PricebookEntry> standardPbeList = new List<PricebookEntry>();
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Pricebook2 livongoPricebook = getPricebook();
        Id standardPBId = Test.getStandardPricebookId();
        List<Product2> wpPrograms = new List<Product2>();
        
        wpPrograms.add(TestFactory.createWPProgram(DM_SOLUTION, 'Diabetes'));
        wpPrograms.add(TestFactory.createWPProgram(DP_SOLUTION, 'Prediabetes'));
        insert wpPrograms;
        
        for (Product2 program: wpPrograms) {
            standardPbeList.add(TestFactory.createPricebookEntry(standardPBId, program.Id));
            pbeList.add(TestFactory.createPricebookEntry(livongoPricebook.Id, program.Id));
        }
        
        insert standardPbeList;
        insert pbeList;
        
        for (PricebookEntry pbe: pbeList) {
            OpportunityLineItem oli = TestFactory.createOpportunityLineItem(opp.Id, pbe.Id);
            oli.Price_Book_ID__c = pbe.Pricebook2Id;
            oli.Program_ID__c = pbe.Product2Id;
            oliList.add(oli);
        }
        
        upsert oliList;
        
        OppLineItemList.add(oliList);
        
        Test.startTest();
        finalOppLineItemList = OpportunityLineItemService.calculateProgramParticipants(OppLineItemList);
        Test.stopTest();
        
        for (OpportunityLineItem finalList: finalOppLineItemList[0]) {           
            if(finalList.OpportunityProductName__c!= null && finalList.OpportunityProductName__c == CV_SOLUTION){
                system.assertEquals((programToParticipantPercentMap.get('CV + DM + DP') * opp.Opportunity_Covered_Lives__c) , finalList.Product_Participants__c);
            }
        }        
    }
    
    @isTest
    static void opportunityLineItemTriggerHandlerTest() {
        List<OpportunityLineItem> oppLineItemList = getOLI();
        for (OpportunityLineItem oli: oppLineItemList) {
            oli.Quantity = 12;
            oli.UnitPrice = 50;
            oli.Bypass_Sales_Price_Validation__c = True;
        }
        update oppLineItemList;
    }
}
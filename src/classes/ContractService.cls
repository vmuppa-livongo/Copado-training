/**
* This class contains the primary business logic for the Contract object.
* Created : 05/13/2019
* @author Connor Gallaher - Slalom
*/

public class ContractService {
    public static final Integer DEFAULT_NUM_MONTHS = Integer.valueOf(System.Label.Default_Renewal_Opp_Num_Months);
    public static final String DEFAULT_RENEWAL_OPP_TYPE = System.Label.Default_Renewal_Opp_Type;
    public static final String DEFAULT_RENEWAL_OPP_STAGE = System.Label.Default_Renewal_Opp_Stage;
    public static final String DEFAULT_RENEWAL_OPP_STAGE_VOC = System.Label.Default_Renewal_Opp_Stage_VOC;
    public static final String DEFAULT_PRICEBOOK_NAME = System.Label.Default_Renewal_Opp_Pricebook_Name;
    public static final Integer DEFAULT_FALLBACK_VAL = Integer.valueOf(System.Label.Default_Renewal_Opp_Fallback_Value);
    public static final String TONYCOLISTRAUSERID = System.Label.TonyColistraUserId;
    public static final String GARYALPERTUSERID = System.Label.GaryAlpertUserId;
    public static final String JESSICAGAHANGUUSERID = System.Label.JessicaGahunguUserId;
    public static final String POPULATIONTYPEASODOWNMARKET = System.Label.PopulationTypeASODownMarket;
    public static final String DEFAULT_PROGRAM_IMPLEMENTATION_STATUS = System.Label.Default_Program_Implementation_Status;
    public static final String NEW_DEVICE_TYPE_HTAND = System.Label.New_Device_Type_HTAND;
    public static final String NEW_DEVICE_TYPE_HT900 = System.Label.New_Device_Type_HT900;
    public static final String DEFAULT_BH_V1_PROGRAM_NAME = System.Label.Default_BH_1_0_Program_Name;
    public static final String DEFAULT_MYSTRENGTH_PROGRAM_PLATFORM_VERSION = System.Label.myStrength_Program_Platform_Version;
	public static final Id CLIENT_OVERVIEW_RT =  Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Client_Overview').getRecordTypeId(); 
	public static final Id PROGRAM_OVERVIEW_RT = Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Program_Overview').getRecordTypeId(); 
    public static final String POPULATIONTYPENONHSSDOWNMARKET = System.Label.PopulationTypeNonHSSDownmarket;
     
    public static Map<String, String> abbreviations { get; set; }
    public static Map<Id, Id> activeUserIdMap { get; set; }
    public static Map<String, List<Whole_Person_Solution_Mapping__mdt>> wpMappings {get; set;}
    public static Map<String, Decimal> programToPercentMap = new Map<String, Decimal>();    
    
    static {
        Map<String, Decimal> pprMap = new Map<String, Decimal>();
        ProgramParticipantsRenewals__mdt[] pprMDT = [SELECT ProgramName__c, Percentage__c FROM ProgramParticipantsRenewals__mdt];
        for (ProgramParticipantsRenewals__mdt ppr: pprMDT) {
            pprMap.put(ppr.ProgramName__c, ppr.Percentage__c);
        }
        programToPercentMap = pprMap;        
    }

    static {
        //Get Custom Metadata Type storing Program Names => their Abbreviation
        Program_Abbreviation__mdt[] programMdts = [SELECT Program_Name__c, Abbreviation__c FROM Program_Abbreviation__mdt];
        Map<String, String> programsToAbbreviations = new Map<String, String>();
        for (Program_Abbreviation__mdt programMdt : programMdts) {
            programsToAbbreviations.put(programMdt.Program_Name__c, programMdt.Abbreviation__c);
        }
        abbreviations = programsToAbbreviations;
        
        Map<Id, Id> usersIdMap = new Map<Id, Id>();
        List<User> userList = [SELECT Id, Name FROM User WHERE (Id = :TONYCOLISTRAUSERID OR Id = :GARYALPERTUSERID OR Id = :JESSICAGAHANGUUSERID) AND IsActive = TRUE];
        for (User u: userList) {
            usersIdMap.put(u.Id, u.Id);
        }
        activeUserIdMap = usersIdMap;
        
        Whole_Person_Solution_Mapping__mdt[] wpMappingsMDT = [SELECT Solution__c, Program__c,Program_Type__c  FROM Whole_Person_Solution_Mapping__mdt];
        Map<String, List<Whole_Person_Solution_Mapping__mdt>> wpMappingMap = new Map<String, List<Whole_Person_Solution_Mapping__mdt>>();
        for (Whole_Person_Solution_Mapping__mdt wpMdt : wpMappingsMDT) {
            string key = wpMdt.Solution__c;
            if (wpMappingMap.keySet().contains(key)) {
                wpMappingMap.get(key).add(wpMdt);
            }
            else {
                wpMappingMap.put(key, new List<Whole_Person_Solution_Mapping__mdt>{wpMdt});
            }
        }  
        wpMappings = wpMappingMap;
    }

    /*
    * Main method called from the ContractTriggerHandler class.  Handles initial queries for key objects and data
    * that will be needed throughout this class.  Handles delegation of creation of objects through calls to
    * other methods and overall primary handling of business logic.
    */
    public static void autoCreateRenewalOpportunities(List<Contract> contracts) {
        //Iterate through POs and add unique Client Overviews to a set
        Set<Id> clientOverviewIds = new Set<Id>();
        for (Contract c : contracts) {
            clientOverviewIds.add(c.Client_Overview__c);
        }

        //Find opportunities related to those Client Overviews
        List<Contract> contractsToRenew = new List<Contract>();
        List<Opportunity> opportunities = [SELECT Id, ContractId FROM Opportunity WHERE ContractId IN :clientOverviewIds];
        for (Opportunity o : opportunities) {
            for (Contract c : contracts) {
                if (c.Client_Overview__c == o.ContractId && c.Program_Type__c != 'WP Non-Anchor') {
                    //List will contain only contracts for which P.E.D. has changed
                    //and for which there is an existing Opportunity related to the Client Overview
                    contractsToRenew.add(c);
                }
            }
        }

        Map<Id, ContractRenewalHelper> helperMap = new Map<Id, ContractRenewalHelper>();
        ContractRenewalHelper helper;

        //Construct ContractRenewalHelper objects
        for (Contract c : contractsToRenew) {
            helper = new ContractRenewalHelper(c);
            helperMap.put(c.Id, helper);
        }

        //Get Default Pricebook
        Pricebook2 livongoPricebook = [SELECT Id, Name FROM Pricebook2 WHERE Name = :DEFAULT_PRICEBOOK_NAME LIMIT 1];

        //Get (unique) names of Programs from Contracts
        Set<String> uniqueProgramNames = new Set<String>();
        for (ContractRenewalHelper h : helperMap.values()) {
            uniqueProgramNames.add(h.programOverview.Program_Name__c);
        }

        Id primaryProductRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName().get('Primary_Product').getRecordTypeId();
        //To store program family names
        Map<Id, Product2> programMap = new Map<Id, Product2>([SELECT Id, Name, Family, RecordTypeId, IsActive, Whole_Person_Solution__c FROM Product2 WHERE Family IN :uniqueProgramNames AND IsActive = TRUE]);
        for (ContractRenewalHelper h : helperMap.values()) {
            Boolean wpProgramOverview = h.programOverview.Program_Type__c == 'WP Anchor';
            for (Product2 program : programMap.values()) {
                //Only use primary record type Product2 objects
                if (h.programOverview.Program_Name__c == program.Family && program.RecordTypeId == primaryProductRecordTypeId && wpProgramOverview == program.Whole_Person_Solution__c) {
                    h.program = program;
                    break;
                }
                else if (h.programOverview.Program_Name__c == program.Family && program.RecordTypeId == primaryProductRecordTypeId) {
                    h.program = program;
                } 
            }
        }

        //Map each Program Id to its corresponding PricebookEntry Id
        Map<Id, Id> programIdsToPriceBookEntryIds = new Map<Id, Id>();
        for (PriceBookEntry entry : [SELECT Id, Product2Id, Pricebook2Id, IsActive FROM PriceBookEntry WHERE IsActive = TRUE AND Pricebook2Id =: livongoPricebook.Id AND Product2Id IN :programMap.keySet()]) {
            programIdsToPriceBookEntryIds.put(entry.Product2Id, entry.Id);
        }
        //Get unique Client Overview Ids
        Set<Id> coIds = new Set<Id>();
        for (Contract c : contractsToRenew) {
            coIds.add(c.Client_Overview__c);
        }

        Set<Id> accountIds = new Set<Id>();
        //Map Client Overview Id to the corresponding Client Overview (Contract) object
        Map<Id, Contract> clientOverviewMap = new Map<Id, Contract>([SELECT Id, CSM__c, CIM__c, Contract_Path__c, AccountId, Account.Name, Account.OwnerId, Account.of_Enrolled_RPwDs_to_date__c, Account.of_Enrolled_RPwHs_to_Date__c,
                                                                     Population_Type__c, Contract_Path__r.Name FROM Contract WHERE Id IN :coIds]);  
        for (ContractRenewalHelper h : helperMap.values()) {
            h.clientOverview = clientOverviewMap.get(h.programOverview.Client_Overview__c);
            //Store unique Account Ids
            accountIds.add(h.clientOverview.AccountId);
        }

        findAndUpdateExistingOpportunities(helperMap.values(), accountIds);

        List<Opportunity> newOpps = createAndInsertNewOpportunities(helperMap.values(), livongoPricebook.Id);

        //Iterate through each PO, update PO to Opportunity map with proper mappings
        for (ContractRenewalHelper h : helperMap.values()) {
            if (h.opp != null) {
                //Opportunity already set, continue to next iteration
                continue;
            }
            else {
                for (Opportunity o : newOpps) {
                    if (h.clientOverview.Contract_Path__c == o.Contract_Path__c && h.clientOverview.AccountId == o.AccountId && h.programOverview.Program_End_Date__c == o.CloseDate) {
                        //Opportunity found, so set lookup to that Opportunity and stop looping.
                        h.opp = o;
                        break;
                    }
                }
            }
        }
        findAndUpdateExistingOpportunityPrograms(helperMap.values());
        
        createAndInsertOpportunityPrograms(helperMap.values(), programIdsToPriceBookEntryIds);
    }

    /*
    * Finds existing Opportunity/Opportunities based on each Program Overview's End Date, as well as the corresponding Client Overview's Contract Path and Account.
    * If an Opportunity is found, set Opportunity to the found Opportunity, and update the name by appending the Family from the current PO to the Opp name.
    * Finally, update the Opportunity/Opportunities.
    */
    public static void findAndUpdateExistingOpportunities(List<ContractRenewalHelper> helpers, Set<Id> accountIds) {
        //Map each Program Overview to the Opportunity it will be associated with
       Set<Id> updatedSetOpps = new Set<Id>();
       Map<Id, Opportunity> updatedMapOpps = new Map<Id, Opportunity>();
       List<Opportunity> updatedOpps = new List<Opportunity>();
        for (Opportunity o : [SELECT Id, Name, Contract_Path__c, AccountId, CloseDate, Pricebook2Id FROM Opportunity WHERE AccountId IN :accountIds]) {
            for (ContractRenewalHelper h : helpers) {
                if (h.clientOverview.Contract_Path__c == o.Contract_Path__c && h.clientOverview.AccountId == o.AccountId && h.programOverview.Program_End_Date__c == o.CloseDate) {
                    h.opp = o;
                    String updatedOppName = updateOppNameWithNewProgram(o.Name, h.program.Family, h.program.Whole_Person_Solution__c);
                    o.Name = updatedOppName;
                    //Add to Map and Set for update
                    updatedMapOpps.put(o.Id, o);
                    updatedSetOpps.add(o.Id);
                }
            }
        }
        if (updatedSetOpps.size() > 0) {
            for (Id oppId: updatedSetOpps){
                updatedOpps.add(updatedMapOpps.get(oppId));
            }
        }
        //Update Opportunity(ies) with new name(s)
        if (!updatedOpps.isEmpty()) {
            try {
                update updatedOpps;
            }
            catch (DmlException ex) {
                System.debug('An exception occurred: ' + ex.getMessage());
            }
        }
    }

    /*
    * Stub out new Opportunity/Opportunities with defined criteria from the POs/COs and insert these new Opportunity/Opportunities.
    * @return list of these newly created Opportunity objects.
    */
    public static List<Opportunity> createAndInsertNewOpportunities(List<ContractRenewalHelper> helpers, Id pbId) {
        //Stub out remaining Opportunities for POs without an associated Opportunity
        Opportunity oppStub;
        Set<Opportunity> oppStubs = new Set<Opportunity>();
        for (ContractRenewalHelper h : helpers) {
            Boolean skipStub = false;
            if (h.opp == null) {
                for (Opportunity o : oppStubs) {
                    //Check if Opportunity stub already exists with the criteria matching the current PO/CO
                    if (h.clientOverview.AccountId == o.AccountId && h.programOverview.Program_End_Date__c == o.CloseDate && h.clientOverview.Contract_Path__c == o.Contract_Path__c) {
                        //Update the Opportunity name to include the new program family name
                        String updatedOppName = updateOppNameWithNewProgram(o.Name, h.program.Family, h.program.Whole_Person_Solution__c);
                        o.Name = updatedOppName;
                        //Will want to skip stubbing an Opportunity for this iteration, so stop looking through Opportunities
                        skipStub = true;
                        break;
                    }
                }
                //Stub out a new Opportunity, if needed
                if (!skipStub) {
                    oppStub = new Opportunity();
                    oppStub.AccountId = h.clientOverview.AccountId;
                    oppStub.Pricebook2Id = pbId;
                    oppStub.Type = DEFAULT_RENEWAL_OPP_TYPE;
                    if (h.programOverview.Auto_Renewal__c) {
                        oppStub.StageName = DEFAULT_RENEWAL_OPP_STAGE_VOC;
                        oppStub.Bypass_Product_Requirement__c = TRUE; // allows bypass of Opp Validiation Rule  Prevent_update_from_proposal2
                    }
                    else {
                        oppStub.StageName = DEFAULT_RENEWAL_OPP_STAGE;   
                    }
                    oppStub.CloseDate = h.programOverview.Program_End_Date__c;
                    if (h.clientOverview.CSM__c != null) {
                        oppStub.OwnerId = h.clientOverview.CSM__c;
                    }
                    else if (h.clientOverview.CSM__c == null && (h.clientOverview.Population_Type__c == POPULATIONTYPEASODOWNMARKET ||
                                                                 h.clientOverview.Population_Type__c == POPULATIONTYPENONHSSDOWNMARKET) &&
                             activeUserIdMap.get(TONYCOLISTRAUSERID) != null) {
                                 oppStub.OwnerId = activeUserIdMap.get(TONYCOLISTRAUSERID);
                             }
                    else if (h.clientOverview.CSM__c == null && (h.clientOverview.Population_Type__c == POPULATIONTYPEASODOWNMARKET ||
                             									 h.clientOverview.Population_Type__c == POPULATIONTYPENONHSSDOWNMARKET ) &&
                             activeUserIdMap.get(GARYALPERTUSERID) != null) {
                                 oppStub.OwnerId = activeUserIdMap.get(GARYALPERTUSERID);
                             }
                    else if (h.clientOverview.CSM__c == null && h.clientOverview.Population_Type__c != POPULATIONTYPEASODOWNMARKET &&
                             activeUserIdMap.get(GARYALPERTUSERID) != null) {
                                 oppStub.OwnerId = activeUserIdMap.get(GARYALPERTUSERID);
                             }
                    else if (activeUserIdMap.get(JESSICAGAHANGUUSERID) != null) {
                        oppStub.OwnerId = JESSICAGAHANGUUSERID;
                    }
                    else {
                        oppStub.OwnerId = h.clientOverview.Account.OwnerId;
                    }
                    String oppName = String.valueOf(h.programOverview.Program_End_Date__c.year()) + ' Renewal - ';
                    if (h.clientOverview.Account.Name.length() > 40) {
                        oppName += h.clientOverview.Account.Name.substring(0, 40);
                    }
                    else {
                        oppName += h.clientOverview.Account.Name;
                    }
                    oppName += ' - ';
                    if (h.clientOverview.Contract_Path__c != null && h.clientOverview.Contract_Path__r.Name.length() > 40) {
                        oppName += h.clientOverview.Contract_Path__r.Name.substring(0, 40);
                        oppName += ' - ';
                    }
                    else if(h.clientOverview.Contract_Path__c != null) {
                        oppName += h.clientOverview.Contract_Path__r.Name;
                        oppName += ' - ';
                    }
                    if (h.program.Whole_Person_Solution__c && !oppName.contains('WP')) {
                        oppName += 'WP - ';
                    }
                    oppName += abbreviations.get(String.valueOf(h.program.Family));
                    if (h.programOverview.Auto_Renewal__c) {
                        oppName += ' - Auto-renewal';
                    }
                    //Opportunity Name field is restricted to 120 characters
                    if (oppName.length() > 120) {
                        oppStub.Name = oppName.substring(0, 120);
                    }
                    else {
                        oppStub.Name = oppName;
                    }
                    oppStub.Contract_Path__c = h.clientOverview.Contract_Path__c;
                    oppStub.ContractId = h.clientOverview.Id;
                    oppStubs.add(oppStub);
                }
            }
        }
        
        List<Opportunity> newOpps = new List<Opportunity>(oppStubs);
        //Insert new Opportunity objects to get IDs
        if (!newOpps.isEmpty()) {
            try {
                insert newOpps;
            }
            catch (DmlException ex) {
                System.debug('An exception occurred: ' + ex.getMessage());
            }
        }
        return newOpps;
    }
    
    /*
    * Finds existing Opportunity Programs for the Opportunities associated with each
    * Program Overview.  Program Overviews are potentially updated multiple times
    * in SpringCM, and we do not want to create a new Opportunity Program each time
    * SpringCM is updated.  This method ensures no duplicate Opportunity Programs
    * are created by finding any existing Opportunity Programs under a Program Overview's
    * associated Opportunity based on the Program Id (Product2Id)
    */
    public static void findAndUpdateExistingOpportunityPrograms(List<ContractRenewalHelper> helpers) {
        Set<Id> oppIds = new Set<Id>();
        Map<Id, List<OpportunityLineItem>> opportunityToOppPrograms = new Map<Id, List<OpportunityLineItem>>();
        for (ContractRenewalHelper h : helpers) {
            oppIds.add(h.opp.Id);
            opportunityToOppPrograms.put(h.opp.Id, new List<OpportunityLineItem>());
        }
        List<OpportunityLineItem> existingOppPrograms = [SELECT Id, Product2Id, OpportunityId FROM OpportunityLineItem WHERE OpportunityId IN :oppIds];
        
        for (OpportunityLineItem existingOppProgram : existingOppPrograms) {
            opportunityToOppPrograms.get(existingOppProgram.OpportunityId).add(existingOppProgram);
        }
        for (ContractRenewalHelper h : helpers) {
            for (OpportunityLineItem op : opportunityToOppPrograms.get(h.opp.Id)) {
                if (h.program.Id == op.Product2Id) {
                    h.oppProgram = op;
                    break;
                }
            }
        }
    }

    /*
    * Create an Opportunity Program (OpportunityLineItem) for each Program Overview with defined criteria and insert these new Opportunity Program(s).
    */
    public static void createAndInsertOpportunityPrograms(List<ContractRenewalHelper> helpers, Map<Id, Id> programIdsToPriceBookEntryIds) {
        //Create a new Opp Program for each PO
        //Map each Program Overview to its corresponding Opportunity Program
        List<OpportunityLineItem> oppPrograms = new List<OpportunityLineItem>();
        for (ContractRenewalHelper h : helpers) {
            //Opp Program would only be set already if there was one found in
            //the method findAndUpdateExistingOpportunityPrograms.  If one is set already,
            //skip that iteration.
            if (h.oppProgram != null) {
                continue;
            }
            //Otherwise, continue with creating a new Opp Program
            OpportunityLineItem oppProgram = new OpportunityLineItem();
			//if (h.programOverview.Participants__c != null) {
                //oppProgram.Product_Participants__c = h.programOverview.Participants__c;
                //JENGA 1505 - no longer using Program Overview's Participants
                //instead using 25% of Account's of_Enrolled_RPwDs_to_date__c if Diabetes, or 10% of of_Enrolled_RPwHs_to_Date__c if HTN
            if (h.clientOverview.Account.of_Enrolled_RPwDs_to_date__c != null && h.programOverview.Program_Name__c == 'Diabetes') {
                oppProgram.Product_Participants__c = (h.clientOverview.Account.of_Enrolled_RPwDs_to_date__c * programToPercentMap.get('Diabetes'));
            }
            else if (h.clientOverview.Account.of_Enrolled_RPwHs_to_Date__c != null && h.programOverview.Program_Name__c == 'Hypertension') {
                oppProgram.Product_Participants__c = (h.clientOverview.Account.of_Enrolled_RPwHs_to_Date__c * programToPercentMap.get('Hypertension'));
            }
            else {
                oppProgram.Product_Participants__c = DEFAULT_FALLBACK_VAL;
            }
            if(oppProgram.Product_Participants__c != null){
                   oppProgram.Product_Participants__c = oppProgram.Product_Participants__c.round(); 
            }
            oppProgram.PricebookEntryId = programIdsToPriceBookEntryIds.get(h.program.Id);
            if (h.programOverview.PPPM__c != null) {
                oppProgram.UnitPrice = h.programOverview.PPPM__c;
            }
            else {
                oppProgram.UnitPrice = DEFAULT_FALLBACK_VAL;
            }
            oppProgram.Quantity = DEFAULT_NUM_MONTHS;
            h.oppProgram = oppProgram;
            h.oppProgram.OpportunityId = h.opp.Id;
            oppPrograms.add(h.oppProgram);
        }

        //Finally, insert all Opportunity Programs
        if (!oppPrograms.isEmpty()) {
            try {
                insert oppPrograms;
            }
            catch (DmlException ex) {
                System.debug('An exception occurred: ' + ex.getMessage());
            }
        }
    }

    /*
    * Update the Opportunity name with the new program family name
    * @return the updated String for the Opportunity name
    */
    public static String updateOppNameWithNewProgram(String oppName, String programFamily, Boolean wholePersonSolution) {
        Boolean keepAutoRenewalInName = false;
        if (oppName.contains('Auto-renewal')) {
            oppName = oppName.substring(0, oppName.lastIndexOf(' - '));
            keepAutoRenewalInName = true;
        }
        else {
            oppName = oppName.substring(0, oppName.length());
        }
        oppName += ' ';
        if (wholePersonSolution && !oppName.contains('WP')) {
            String remainingStr = oppName.substring(oppName.lastIndexOf(' - '));
            oppName = oppName.substring(0, oppName.lastIndexOf(' - '));
            oppName += '- WP ' + remainingStr;
        }
        String programAbbreviation = abbreviations.get(programFamily);
        //Ensure Opp name won't contain the same program
        //(e.g. YYYY Renewal - Account - DM DM ; This should NOT happen)
        if (!oppName.contains(programAbbreviation)) {
            oppName += programAbbreviation;
        }
        if (keepAutoRenewalInName) {
            oppName += ' - Auto-renewal';
        }
        //Opportunity Name field is restricted to 120 characters
        if (oppName.length() > 120) {
            oppName = oppName.substring(0, 120);
        }
        return oppName;
    }
    
    //Creating related Client Overview and Program Overview
    //Invocable Methods called from Opportunity Process Builder and Create Client Overview Bundle button on Opportunity
    @InvocableMethod(label='Create Related Client Overview and Program Overviews')
    public static void createdRelatedCoPo(List<List<String>> oppSource) {     
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        Map<Id, Contract> oppToClientOverviewsMap = new Map<Id, Contract>();
        Map<String, Contract> programOverviewsToCreateMap = new Map<String, Contract>();
        Map<Id, Id> oppContractMap = new Map<Id, Id>();
        List<ProgramWrap> programWrapList = new List<ProgramWrap>();
        List<Contract> poList = new List<Contract>();
        ProgramWrap programWrap;
        Id oppId;
        Id coId;
        String sourceType;
        Map<String, Contract> existingProgramsMap = new Map<String, Contract>();
        Contract existingPO;

        //Getting OppId from oppSource
        if (oppSource.size() > 0) {
            oppId = oppSource.get(0).get(0);
        }
        //Getting Client Overview Id and Source Type from source parameter
        if (oppSource.size() > 0 && oppSource.get(0).size() > 1) {
            coId = oppSource.get(0).get(1);
            sourceType = oppSource.get(0).get(2);
        }

        //Get Opportunity Info
        List<Opportunity> oppList = [SELECT Id, AccountId, Contract_Path__c, Account.Name, Contract_Path__r.Name, CIM__c, BillingPartner__c,
                           			ContractId, Launch_Date__c, (SELECT Id, Program_Family__c, Pricing_Structure__c, Pricing_Structure__r.Name, PO_WholePerson__c, 
                                                 Product2.Whole_Person_Solution__c, OpportunityProductName__c FROM OpportunityLineItems) 
                           			FROM Opportunity WHERE Id = :oppId];
        Opportunity opp = oppList[0];

        //Get Programs realted to CO if coId not equal to null and add them to Map
        //These Existing Programs are used to set defaults for WP Program Transitions
        if (coId != null) {
            List<Contract> existingCO = [SELECT Id FROM Contract WHERE Id = :coId LIMIT 1];
            Contract CO = existingCO[0];

            poList = [SELECT Id, AccountId, Client_Overview__c, Program_Name__c, OE_Month_End__c, Actual_Launch_Date__c, Member_Recruitment_Began__c, 
                      Initial_Targeted_Marketing__c, Recruitable_Pop_Current__c, Product_Enrollment_Cap__c, CSM__c,
                      CIM__c, cbi_header__c, cbi_step1__c, cbi_step2__c, cbi_step3__c, cbi_disclaimer__c, Program_Began_as_Pilot__c,
                      Disclaimer__c, Eligibility_Sentence__c, Spanish_Eligibility_Sentence__c, Automated_Enrollment_Injection__c,
                      Relaunch_Start_Date__c, Pop_Refresh_Start_Date__c, Name, Is_there_Lapse_Criteria__c, Lapsed_Criteria_Source__c,
                      Escalation_Details__c, Eligibility_Escalation_Path__c, Eligibility_Verification_Method__c  
                      FROM Contract WHERE RecordTypeId = :PROGRAM_OVERVIEW_RT AND Client_Overview__c = :coId AND Status = 'Active' AND Program_Type__c = 'Standalone'];

            if (!poList.isEmpty()) {
                for (Contract po: poList) {
                existingProgramsMap.put(po.Program_Name__c, po);
                }
            }

            oppToClientOverviewsMap.put(oppId, CO);
        }
             
        //If there is no existing CO, Create a new CO
        if (coId == null) {
                Contract clientOverview = new Contract();
                clientOverview.AccountId = opp.AccountId;
                clientOverview.BillingPartner__c = opp.BillingPartner__c ;
                clientOverview.CIM__c = opp.CIM__c;
                clientOverview.Contract_Path__c = opp.Contract_Path__c;
                if (opp.Contract_Path__c != null && opp.AccountId != null) {
                    clientOverview.Name = opp.Account.Name + ' - ' + opp.Contract_Path__r.Name;
                }
                else if (opp.AccountId != null) {
                    clientOverview.Name = opp.Account.Name;
                }
                clientOverview.RecordTypeId = CLIENT_OVERVIEW_RT;
                oppToClientOverviewsMap.put(opp.Id, clientOverview);
            
            //Inserting the COs
            if (oppToClientOverviewsMap.size() > 0) {
                try {
                    insert oppToClientOverviewsMap.values();
                }
                catch (DmlException ex) {
                    System.debug('An exception occurred: ' + ex.getMessage());
                }
            }
        }
        
        //Looping over the opportunity lineitems to create the related POs based on the opportunity line items
        //Get the whole person mapping if any and add them to the program wrap list.
        for (OpportunityLineItem oppLineItem: opp.OpportunityLineItems) {
            if (oppLineItem.Product2.Whole_Person_Solution__c) {
                List<Whole_Person_Solution_Mapping__mdt> wpPrograms = wpMappings.get(oppLineItem.OpportunityProductName__c);
                if (wpPrograms.size() > 0) {
                    for (Whole_Person_Solution_Mapping__mdt wpProgram: wpPrograms) {
                        programWrap = new ProgramWrap(wpProgram);
                        programWrapList.add(programWrap);
                    }
                }
            }
            else {
                programWrap = new ProgramWrap(oppLineItem);
                programWrapList.add(programWrap);
            }
        }

        //Creating Program Overviews for all the programs that came from both Standalone and Whole Person Solution OLIs
        if (programWrapList.size() > 0) {
            for (ProgramWrap program: programWrapList) {
                String programName = program.ProgramName;
                //If the program is already existing in the Map, It doesn't add duplicate programs rather it updates the Program Type based on the below logic
                if (programOverviewsToCreateMap.keySet().contains(programName)) {        
                    switch on programOverviewsToCreateMap.get(programName).Program_Type__c {
                        when 'WP Anchor' {
                            programOverviewsToCreateMap.get(programName).Program_Type__c = 'WP Anchor';
                        }
                        when 'WP Non-Anchor' {
                            if (program.programType == 'WP Anchor') {
                                programOverviewsToCreateMap.get(programName).Program_Type__c = 'WP Anchor';
                            }
                            else if (program.programType == 'Standalone') {
                                programOverviewsToCreateMap.get(programName).Program_Type__c = 'WP Non-Anchor + Standalone';
                            }
                        }
                        when 'Standalone' {
                            if (program.programType == 'WP Anchor') {
                                programOverviewsToCreateMap.get(programName).Program_Type__c = 'WP Anchor';
                            }
                            else if (program.programType == 'WP Non-Anchor') {
                                programOverviewsToCreateMap.get(programName).Program_Type__c = 'WP Non-Anchor + Standalone';
                            }
                        }
                        when 'WP Non-Anchor + Standalone' {
                            if (program.programType == 'WP Anchor') {
                                programOverviewsToCreateMap.get(programName).Program_Type__c = 'WP Anchor';
                            }
                        }
                    }
                }
                //If the program is not existing it adds a new program to Map
                else {
                    Contract programOverview = new Contract();
                    programOverview.AccountId = opp.AccountId;
                    programOverview.Client_Overview__c = oppToClientOverviewsMap.get(opp.Id).Id;
                    programOverview.RecordTypeId = PROGRAM_OVERVIEW_RT;
                    programOverview.Program_Name__c = program.programName;
                    if (opp.Contract_Path__c != null && opp.AccountId != null) {
                        programOverview.Name = opp.Account.Name + ' - ' + program.programName + ' - ' + opp.Contract_Path__r.Name;
                    }
                    else if (opp.AccountId != null) {
                        programOverview.Name = opp.Account.Name + ' - ' + program.programName;
                    }
                    programOverview.Program_Type__c = program.programType;
                    if (program.programName == 'Hypertension' && program.pricingStructure != null && program.pricingStructure.Contains('Cellular')) {
                        programOverview.New_Device_Type__c = NEW_DEVICE_TYPE_HT900;
                    }
                    else if (program.programName == 'Hypertension' && program.pricingStructure != null && program.pricingStructure.Contains('Bluetooth')) {
                        programOverview.New_Device_Type__c = NEW_DEVICE_TYPE_HTAND;
                    }
                    else if (program.programName == 'Hypertension' && programOverview.Program_Type__c != 'Standalone') {
                        programOverview.New_Device_Type__c = NEW_DEVICE_TYPE_HT900;
                    }
                    if (program.oliName != null && program.oliName == DEFAULT_BH_V1_PROGRAM_NAME) {
                        programOverview.Program_Platform_Version__c = DEFAULT_MYSTRENGTH_PROGRAM_PLATFORM_VERSION;
                    }
                    programOverview.Program_Implementation_status__c = DEFAULT_PROGRAM_IMPLEMENTATION_STATUS;
                    programOverviewsToCreateMap.put(programOverview.Program_Name__c, programOverview);
                }
            }
            //If the sourceType is Whole Person Program Overview Transition it sets the deafult values for programs from existing standalone programs
            if (sourceType == 'Whole Person Program Overview Transition' && programOverviewsToCreateMap.size() > 0) {
                for (Contract p : programOverviewsToCreateMap.Values()) {
                    if (p.Program_Type__c != 'WP Non-Anchor') {
                        existingPO = existingProgramsMap.get(p.Program_Name__c);
                        if (existingPO != null) {
                            p.Whole_Person_Transition_Date__c = opp.Launch_Date__c;
                            p.OE_Month_End__c = existingPO.OE_Month_End__c;
                            p.Actual_Launch_Date__c = existingPO.Actual_Launch_Date__c;
                            p.Member_Recruitment_Began__c = existingPO.Member_Recruitment_Began__c;
                            p.Initial_Targeted_Marketing__c = existingPO.Initial_Targeted_Marketing__c;
                            p.Recruitable_Pop_Current__c = existingPO.Recruitable_Pop_Current__c;
                            p.Product_Enrollment_Cap__c = existingPO.Product_Enrollment_Cap__c;
                            p.CSM__c = existingPO.CSM__c;
                            p.CIM__c = existingPO.CIM__c;
                            p.cbi_header__c = existingPO.cbi_header__c;
                            p.cbi_step1__c = existingPO.cbi_step1__c;
                            p.cbi_step2__c = existingPO.cbi_step2__c;
                            p.cbi_step3__c = existingPO.cbi_step3__c;
                            p.cbi_disclaimer__c = existingPO.cbi_disclaimer__c;
                            p.Program_Began_as_Pilot__c = existingPO.Program_Began_as_Pilot__c;
                            p.Disclaimer__c = existingPO.Disclaimer__c;
                            p.Eligibility_Sentence__c = existingPO.Eligibility_Sentence__c;
                            p.Spanish_Eligibility_Sentence__c = existingPO.Spanish_Eligibility_Sentence__c;
                            p.Automated_Enrollment_Injection__c = existingPO.Automated_Enrollment_Injection__c;
                            p.Relaunch_Start_Date__c = existingPO.Relaunch_Start_Date__c;
                            p.Pop_Refresh_Start_Date__c = existingPO.Pop_Refresh_Start_Date__c;
                            p.Name = existingPO.Name;
                            p.Is_there_Lapse_Criteria__c = existingPO.Is_there_Lapse_Criteria__c;
                            p.Lapsed_Criteria_Source__c = existingPO.Lapsed_Criteria_Source__c;
                            p.Escalation_Details__c = existingPO.Escalation_Details__c;
                            p.Eligibility_Escalation_Path__c = existingPO.Eligibility_Escalation_Path__c;
                            p.Eligibility_Verification_Method__c = existingPO.Eligibility_Verification_Method__c;
                        }
                    }
                }
            }
            
        }
        //Inserting the POs
        if (programOverviewsToCreateMap.size() > 0) {
            try {
           		insert programOverviewsToCreateMap.values();
            }
            catch (DmlException ex) {
                System.debug('An exception occurred: ' + ex.getMessage());
            }
        }
        
        //Updating the opp so the newly created CO is associated with the Opportunity.
        opp.ContractId = oppToClientOverviewsMap.get(opp.Id).Id;
        update opp;
    }

    //Chatter in the TechOps group for field tracking
    //Create chatter notifications based on the type of operation type
    public static void chatterTechOps(Map<Id, Contract> oldContracts, List<Contract> newContracts, List<Schema.FieldSetMember> contractTrackedFields, String operationType) {
        List<ConnectApi.BatchInput> batchInputs = new List<ConnectApi.BatchInput>();
        CollaborationGroup chatterGroup;
        List<CollaborationGroup> chatterGroupList = [SELECT Id, Name from CollaborationGroup WHERE Name = 'TechOps' LIMIT 1];
        if (chatterGroupList.size() > 0) {
            chatterGroup = chatterGroupList[0];
            if (operationType == 'Insert' || operationType == 'Update') {
                for (Contract newContract : newContracts) {
                    String recordTypeName = Schema.SObjectType.Contract.getRecordTypeInfosById().get(newContract.RecordtypeId).getName();
                    if (operationType == 'Update') {
                        Contract oldContract = oldContracts.get(newContract.Id);
                        for (Schema.FieldSetMember fsm : contractTrackedFields) {
                            String fieldName  = fsm.getFieldPath();
                            String fieldLabel = fsm.getLabel();
                            
                            if (newContract.get(fieldName) == oldContract.get(fieldName))
                                continue;
                            
                            if (newContract.get(fieldName) != oldContract.get(fieldName)) {
                                String inputText = '\n' + fieldLabel + ' has been updated on ' + recordTypeName + ' ' +
                                    newContract.get('ContractNumber')+'\n' + 
                                    'Old Value: ' + oldContract.get(fieldName) + '\n' + 
                                    'New Value: ' + newContract.get(fieldName) + '\n';
                                ConnectApi.FeedItemInput feedItemInput = createFeed(inputText, chatterGroup.Id, newContract.Id);
                                ConnectApi.BatchInput batchInput = new ConnectApi.BatchInput(feedItemInput);
                                batchInputs.add(batchInput);
                            }
                        }
                    }
                    else if (operationType == 'Insert' && recordTypeName == 'Program Overview') {
                        String inputText = '\nNew ' + recordTypeName +' '+newContract.get('ContractNumber')+' has been created';
                        ConnectApi.FeedItemInput feedItemInput = createFeed(inputText, chatterGroup.Id, newContract.Id);
                        ConnectApi.BatchInput batchInput = new ConnectApi.BatchInput(feedItemInput);
                        batchInputs.add(batchInput);   
                    } 
                }
            }
            if (operationType == 'Delete' && oldContracts != null) {
                List<Contract> oldContractList = oldContracts.Values();
                if (oldContracts.Values().size() > 0) {
                    for (Contract p : oldContracts.Values()) {
                        String recordTypeName = Schema.SObjectType.Contract.getRecordTypeInfosById().get(p.RecordtypeId).getName();
                        if (recordTypeName == 'Program Overview') {
                            String inputText = '\n'+ p.Program_Name__c+' Program Overview ' + p.ContractNumber + ' has been deleted';
                            ConnectApi.FeedItemInput feedItemInput = createFeed(inputText, chatterGroup.Id, p.Client_Overview_Id__c);
                            ConnectApi.BatchInput batchInput = new ConnectApi.BatchInput(feedItemInput);
                            batchInputs.add(batchInput);
                        }
                    }  
                }
            }
            ConnectApi.ChatterFeeds.postFeedElementBatch(Network.getNetworkId(), batchinputs);
        }
    }
    //Create a feed item using Connect Api with the InputText, Mention and RecordId
    public static ConnectApi.FeedItemInput createFeed(String inputText, Id mentionId, Id recordId) {
        ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput();
        ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput();
        ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
        ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();

        messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();

        mentionSegmentInput.id = mentionId;
        messageBodyInput.messageSegments.add(mentionSegmentInput);

        textSegmentInput.text = inputText;
        messageBodyInput.messageSegments.add(textSegmentInput);

        feedItemInput.body = messageBodyInput;
        feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem;
        feedItemInput.subjectId = recordId == null ? 'me' : recordId;
        return feedItemInput;
    }
    
    public static void updateHealthScores(List<Contract> newContracts) {
        Set<Id> accIdSet = new Set<Id>();
        Map<Id, Map<String, List<Contract>>> accToConMap = new Map<Id, Map<String, List<Contract>>>();
        List<Health_Score__c> hsListToUpdate = new List<Health_Score__c>();
        String outreachStratificationDM;
        String outreachStratificationHTN;
        for (Contract con : newContracts) {
            accIdSet.add(con.AccountId);
        }
        if (accIdSet.size() > 0){
            List<Contract> conList = [SELECT Id, AccountId, Program_Name__c, Actual_Launch_Date__c, Last_Date_of_Data_Refresh__c, Outreach_Stratification__c 
                                      FROM Contract WHERE AccountId IN :accIdSet AND RecordType.Name = 'Program Overview'];
            
            if (conList != null) {
                for (Contract con : conList) {
                    if (accToConMap.containsKey(con.AccountId)) {
                        Map<String, List<Contract>> conMap = accToConMap.get(con.AccountId);
                        if (conMap.containsKey(con.Program_Name__c)) {
                            List<Contract> contractList = conMap.get(con.Program_Name__c);
                            contractList.add(con);
                        }
                        else {
                            conMap.put(con.Program_Name__c, new List<Contract> {con});
                        } 
                    }
                    else {
                        accToConMap.put(con.AccountId, new Map<String, List<Contract>> {con.Program_Name__c => new List<Contract> {con}});
                    }
                } 
            } 
            
            List<Health_Score__c> hsList = [SELECT Id, Account__c, Actual_Result__c, Program__c, Health_Segment__c FROM Health_Score__c 
                                            WHERE Account__c IN :accIdSet AND RecordType.Name = 'Program Health Score' 
                                            AND (Health_Segment__c = 'Client Launch Date' OR Health_Segment__c = 'Marketing Type (Outreach Stratification)')];
            
            if (hsList.size() > 0) {
                for (Health_Score__c hs : hsList) {
                    List<Contract> programs;
                    if (accToConMap.get(hs.Account__c) != null) {
                        programs = accToConMap.get(hs.Account__c).get(hs.Program__c);
                    }
                    if (programs != null) {
                        Contract closestCon = findClosestCon(programs, 'LaunchDate');
                        if (closestCon.Actual_Launch_Date__c != null && hs.Health_Segment__c == 'Client Launch Date') {
                            hs.Actual_Result__c = String.valueOf(closestCon.Actual_Launch_Date__c.format());
                        }
                        if (programs.size() > 1 && hs.Health_Segment__c == 'Marketing Type (Outreach Stratification)') {
                            String outreachStratification;
                            for (Contract po : programs) {
                                if (po.Outreach_Stratification__c == 'C') {
                                    hs.Actual_Result__c = 'C';
                                }
                                else if (po.Outreach_Stratification__c == 'B' && outreachStratification != 'C') {
                                    hs.Actual_Result__c = 'B';
                                }
                                else if (po.Outreach_Stratification__c == 'A' && (outreachStratification != 'B' || outreachStratification != 'C')) {
                                    hs.Actual_Result__c = 'A';
                                }
                                else {
                                    hs.Actual_Result__c = po.Outreach_Stratification__c;
                                }
                            }
                            
                        }
                        else if (hs.Health_Segment__c == 'Marketing Type (Outreach Stratification)'){
                            hs.Actual_Result__c = programs[0].Outreach_Stratification__c;
                        }
                        hsListToUpdate.add(hs);
                    }
                } 
            }
        }
        try {
            if (hsListToUpdate.size() > 0) {
                update hsListToUpdate;
            } 
        }
        catch (DmlException ex) {
            System.debug('An exception occurred: ' + ex.getMessage());
        }
    }
    
    public static Contract findClosestCon(List<Contract> conList, String fieldName) {
        Contract closestCon = new Contract();
        Map<Date, Contract> conMap = new Map<Date, Contract>();
        Set<Date> dateSet = new Set<Date>();
        List<Date> dateList;
        
        if(conList.Size() > 0) {
            for(Contract con : conList) {
                if (fieldName == 'LaunchDate') {
                    conMap.put(con.Actual_Launch_Date__c, con);
                }
                else {
                    conMap.put(con.Actual_Launch_Date__c, con);
                }
            }
            dateSet = conMap.keySet();
            dateList = new List<Date>(dateSet);
            dateList.sort();
            closestCon = conMap.get(dateList[dateList.size() - 1]);
        }
        return closestCon;
    }
    
    public class ProgramWrap {
        public String programName {get; set;}
        public String programType {get; set;}
        public String pricingStructure {get; set;}
        public String oliName {get; set;}
        
        public ProgramWrap(OpportunityLineItem oli) {
            this.programName = oli.Program_Family__c;
            this.programType = 'Standalone';
            this.pricingStructure = oli.Pricing_Structure__r.Name;
            this.oliName = oli.OpportunityProductName__c;
        }
        
        public ProgramWrap(Whole_Person_Solution_Mapping__mdt wpProgram) {
            this.programName = wpProgram.Program__c;
            this.programType = wpProgram.Program_Type__c ;
        }
    }

    /*
    * Inner class used to store key data that will be used/reused throughout the ContractService class.
    */
    public class ContractRenewalHelper {
        public Contract programOverview { get; set; }
        public Contract clientOverview { get; set; }
        public Product2 program { get; set; }
        public OpportunityLineItem oppProgram { get; set; }
        public Opportunity opp { get; set; }

        public ContractRenewalHelper(Contract programOverview) {
            this.programOverview = programOverview;
        }
    }
}
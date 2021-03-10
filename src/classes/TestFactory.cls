/**
* This class is used to generate test data for unit tests.
* Created : 05/20/2019
* @author Connor Gallaher
*/
@isTest
global class TestFactory {
    //Creates and returns a Program with the specified program name
    public static Product2 createProgram(String programName) {
        Product2 program = new Product2(Name=programName, Family=programName, IsActive=true, ProductCode = programName);
        return program;
    }
    
    //Creates and returns a Whole Person Program with the specified program name
    public static Product2 createWPProgram(String programName, String programFamily) {
        Product2 program = new Product2(Name=programName, Family=programFamily, IsActive=true, ProductCode = programName, Whole_Person_Solution__c = true);
        return program;
    }

    //Creates and returns a Pricebook
    public static Pricebook2 createPricebook() {
        Pricebook2 livongoPricebook = new Pricebook2(Name='Livongo', IsActive=true);
        return livongoPricebook;
    }

    //Creates and returns a PricebookEntry in the Pricebook with the specified Pricebook Id and specified Program Id
    public static PricebookEntry createPricebookEntry(Id pricebookId, Id programId) {
        PricebookEntry pbe = new PricebookEntry(Pricebook2ID = pricebookId, Product2Id = programId, UnitPrice=10, IsActive=true);
        return pbe;
    }

    //Creates and returns an Account with the Client Account Record Type
    public static Account createClientAccount() {
        Account testAccount = new Account();
        testAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Client_Account').getRecordTypeId();
        testAccount.Name = 'Test Client Account';
        testAccount.Type = 'Self Funded Employer';
        testAccount.Covered_Lives__c = 10000;
        return testAccount;
    }
    
    //Creates and returns an Account with the Downmarket Client Record Type
    public static Account createDownmarketClientAccount() {
        Account testAccount = new Account();
        testAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Downmarket_Client').getRecordTypeId();
        testAccount.Name = 'Test Downmarket Client Account';
        testAccount.Type = 'Self Funded Employer';
        testAccount.Covered_Lives__c = 10000;
        return testAccount;
    }

    //Creates and returns an Account with the Competitor Account Record Type
    public static Account createCompetitorAccount() {
        Account testAccount = new Account();
        testAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Competitor_Account').getRecordTypeId();
        testAccount.Name = 'Test Competitor Account';
        testAccount.Type = 'Payer';
        testAccount.Covered_Lives__c = 10000;
        return testAccount;
    }

    //Creates and returns an Account with the Partner Account Record Type
    public static Account createPartnerAccount() {
        Account testAccount = new Account();
        testAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Partner_Account').getRecordTypeId();
        testAccount.Name = 'Test Partner Account';
        testAccount.Type = 'Payer';
        testAccount.Covered_Lives__c = 10000;
        return testAccount;
    }

    //Creates and returns a new Opportunity
    public static Opportunity createOpportunity() {
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.StageName = 'Selling';
        opp.Type = 'Renewal';
        opp.CloseDate = Date.today().addDays(1);
        return opp;
    }
    
    //Creates and returns a new Opportunity based on the type provided
    public static Opportunity createTypeBasedOpportunity(String type) {
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity ' + type;
        opp.StageName = 'Selling';
        opp.Type = type;
        opp.CloseDate = Date.today().addDays(1);
        opp.LeadSource = 'Direct Outreach';
        return opp;
    }
    
    //Creates and returns a new Pricing Structure
    public static Pricing_Structure__c createPricingStructure(Id pricebookId, Id programId) {
        Pricing_Structure__c ps = new Pricing_Structure__c();
        ps.Name = 'Standard';
        ps.Price_Book__c = pricebookId;
        ps.Program__c = programId;
        ps.IsActive__c = true;
        ps.List_Price__c = 65;
        return ps;
    }
    
    //Creates and returns a new OpportunityLineItem
    public static OpportunityLineItem createOpportunityLineItem(Id opptyId, Id pbeId) {
        OpportunityLineItem oli = new OpportunityLineItem();
        oli.OpportunityId = opptyId;
        oli.PricebookEntryId = pbeId;
        oli.Quantity = 12;
        oli.Product_Participants__c = 100;
        oli.UnitPrice = 65;
        return oli;
    }

    //Creates and returns a Contract (Client Overview)
    public static Contract createClientOverview() {
        Contract clientOverview = new Contract();
        clientOverview.RecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Client_Overview').getRecordTypeId();
        clientOverview.Status = 'Draft';
        return clientOverview;
    }

    //Creates and returns a Contract (Program Overview)
    public static Contract createProgramOverview() {
        Contract programOverview = new Contract();
        programOverview.RecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Program_Overview').getRecordTypeId();
        programOverview.Status = 'Draft';
        programOverview.Auto_Renewal__c = true;
        programOverview.PPPM__c = 100;
        programOverview.Participants__c = 1000;
        programOverview.Program_End_Date__c = Date.today();
        programOverview.Complete_Per_Legal__c = false;
        return programOverview;
    }
    
    //Creates and returns a TaskRayProject
    public static TASKRAY__Project__c createTaskRayProject() {
        TASKRAY__Project__c project = new TASKRAY__Project__c();
       	project.TaskRayStatus__c = 'Not Started';
        project.Project_Template_Category__c = 'Project Template';
        project.Project_Type__c = 'New Client / Contract Path';
        project.Project_Sub_Type__c = 'Direct > 2,500 Employees';
        return project;
    }

    //Creates and returns a ClientHandoffSummary
    public static Client_Handoff_Summary__c createClientHandoffSummary() {
        Client_Handoff_Summary__c chs = new Client_Handoff_Summary__c();
        return chs;
    }

    //Creates and returns a Contact
    public static Contact createSalesContact() {
        Contact con = new Contact();
        con.FirstName = 'Spider Man';
        con.LastName = 'Marvel';
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Sales_Contact').getRecordTypeId();
        con.Phone = '1234567890';
        con.Email = 'contest@test.com';
        return con;
    }
    
    //Creates and returns a Relationship based on the type
    public static Relationship__c createRelationship(String type) {
        Relationship__c  rel = new Relationship__c();
        rel.RelationshipType__c = type;
        return rel;
    }
    
    //Creates and returns a Client Member Code
    public static ClientMemberCode__c createClientMemberCode(){
        ClientMemberCode__c memberCode= new ClientMemberCode__c();
        memberCode.RecordTypeId=Schema.SObjectType.ClientMemberCode__c.getRecordTypeInfosByDeveloperName().get('ClientMemberCode').getRecordTypeId();
        memberCode.UsedforRegistration__c=true;
        memberCode.ClientMemberCode__c='CMCXYZ9000';     
        return memberCode;
    }
    
    
}
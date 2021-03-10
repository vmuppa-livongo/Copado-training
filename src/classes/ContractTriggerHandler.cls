/**
* This class serves as a handler for the Contract trigger.
* Created : 05/13/2019
* @author Connor Gallaher - Slalom
*/

public class ContractTriggerHandler {
    public static final Id CLIENT_OVERVIEW_RT =  Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Client_Overview').getRecordTypeId(); 
    public static final Id PROGRAM_OVERVIEW_RT = Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Program_Overview').getRecordTypeId();
    
    public static void handleContractAfterInsert(List<Contract> newContracts) {
        if (!Test.isRunningTest())
            ContractService.chatterTechOps(null, newContracts, null, 'Insert');
    }
    public static void handleContractUpdate(Map<Id, Contract> oldContracts, List<Contract> newContracts) {
        List<Contract> initialContractsToRenew = new List<Contract>();
        List<Contract> programsToUpdateHS = new List<Contract>();
        //Iterate through contracts to find the POs which are marked complete (TRUE)
        //AND which used to be marked incomplete previously (FALSE)
        //Note: This is because the SpringCM workflow unchecks (FALSE) the Complete Per Legal field at the beginning of the workflow
        //and rechecks (TRUE) the Complete Per Legal field at the end of the workflow
        for (Contract c : newContracts) {
            if (c.Complete_Per_Legal__c && (c.Complete_Per_Legal__c != oldContracts.get(c.Id).Complete_Per_Legal__c)) {
                initialContractsToRenew.add(c);
            }
            
            if (c.RecordTypeId == PROGRAM_OVERVIEW_RT && c.Actual_Launch_Date__c != null && c.Actual_Launch_Date__c != oldContracts.get(c.Id).Actual_Launch_Date__c ||
                c.Outreach_Stratification__c != null && c.Outreach_Stratification__c != oldContracts.get(c.Id).Outreach_Stratification__c) {
                    programsToUpdateHS.add(c);
            }
        }
        //Pass list of changed Contracts to ContractService class
        if (!initialContractsToRenew.isEmpty()) {
            ContractService.autoCreateRenewalOpportunities(initialContractsToRenew);
        }
        
        //Tracking Fields and notifying TechOps Chatter Group
        final List<Schema.FieldSetMember> contractTrackedFields = SObjectType.Contract.FieldSets.HistoryTracking.getFields();
        if (!contractTrackedFields.isEmpty()) {
            if (!Test.isRunningTest())
                ContractService.chatterTechOps(oldContracts, newContracts, contractTrackedFields, 'Update');    
        }
        
        if (!programsToUpdateHS.isEmpty()) {
            ContractService.updateHealthScores(programsToUpdateHS);
        }
    }
    //JENGA-1304 Users will not be able to delete the Client Overviews if there are any Program Overviews associated
    public static void handleContractDelete(List<Contract> oldContracts) {
        List<Contract> programOverviewList = [SELECT Id From Contract WHERE Client_Overview__c IN :oldContracts];
        for (Contract c: oldContracts) {
            Id contractRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Client_Overview').getRecordTypeId();
            if (c.RecordTypeId == contractRecordTypeId && programOverviewList.Size() > 0) {
                c.addError(System.Label.ClientOverviewDeleteMessage);
            }   
        }
    }
    public static void handleContractAfterDelete(Map<Id, Contract> oldContracts) {
        if (!Test.isRunningTest())
            ContractService.chatterTechOps(oldContracts, null, null, 'Delete');
    }
}
/**
* This class contains the test methods for chatter posts made on the Contract Service Apex Class .
* Created : 07/08/2020
* @author Virinchi Bairisetty
*/
@isTest
public class ContractHistortyTrackingTest {
    public static final List<Schema.FieldSetMember> contractTrackedFields = SObjectType.Contract.FieldSets.HistoryTracking.getFields();
    @isTest(SeeAllData=true)
    static void contractHistoryTrackingInsertOperation() {
        List<Contract> newContracts = new List<Contract>();
        
        Account clientAccount = TestFactory.createClientAccount();
        insert clientAccount;
        
        Contract clientOverview = TestFactory.createClientOverview();
        clientOverview.AccountId = clientAccount.Id;
        insert clientOverview;
        
        Contract newProgramOverview = TestFactory.createProgramOverview();
        newProgramOverview.Program_Name__c = 'Diabetes';
        newProgramOverview.New_Device_Type__c = 'HTAND';
        newProgramOverview.Client_Overview__c = clientOverview.Id;
        newProgramOverview.AccountId = clientAccount.Id;
        newContracts.add(newProgramOverview);
        insert newContracts;
        
        ContractService.chatterTechOps(null, newContracts, null, 'Insert');
        system.assertEquals(1, newContracts.size());
    }
    
    @isTest(SeeAllData=true)
    static void contractHistoryTrackingDeleteOperation() {
        Map<Id, Contract> oldContracts = new Map<Id, Contract>();
        List<Contract> oldContractsList = new List<Contract>();
        
        Account clientAccount = TestFactory.createClientAccount();
        insert clientAccount;
        
        Contract clientOverview = TestFactory.createClientOverview();
        clientOverview.AccountId = clientAccount.Id;
        insert clientOverview;
        
        Contract oldProgramOverview = TestFactory.createProgramOverview();
        oldProgramOverview.AccountId = clientAccount.Id;
        oldProgramOverview.Program_Name__c = 'Diabetes';
        oldProgramOverview.New_Device_Type__c = 'HTAND';
        oldProgramOverview.Client_Overview__c = clientOverview.Id;
        oldContractsList.add(oldProgramOverview);
        insert oldContractsList;
        
        for (Contract oldCon : oldContractsList) {
            oldContracts.put(oldCon.Id, oldCon);
        }
        
        ContractService.chatterTechOps(oldContracts, null, null, 'Delete');
        system.assertEquals(1, oldContracts.size());
    }
}
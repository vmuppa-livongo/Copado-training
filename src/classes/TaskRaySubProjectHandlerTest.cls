@IsTest
public class TaskRaySubProjectHandlerTest{
  @TestSetup
    public static void setupData() {
        Account acc = TestFactory.createDownmarketClientAccount();
        acc.Name = 'Test DownMarket1';
        insert acc;
        List<Account> acclist = new List<Account>();
        Account acc1 = new Account(Name = 'Test Acc1');
        Account acc2 = new Account(Name = 'Test Acc2');
        Account acc3 = new Account(Name = 'Test Acc3');
        accList.add(acc1);
        accList.add(acc2);
        accList.add(acc3);
        insert accList; 
        Contract clientOverview = TestFactory.createClientOverview();
        clientOverview.Name = 'Test CO';
        clientOverview.AccountId = acc1.Id;
        clientOverview.Contract_Path__c = acc.Id;
        insert clientOverview;
        Opportunity opp1 = TestFactory.createOpportunity();
        opp1.Name = 'Opp1';
        opp1.AccountId = acc1.Id;
        opp1.ContractId = clientOverview.Id;
        insert opp1;
        Opportunity opp2 = TestFactory.createOpportunity();
        opp2.Name = 'Opp2';
        opp2.AccountId = acc2.Id;
        opp2.ContractId = clientOverview.Id;
        insert opp2;
        Opportunity opp3 = TestFactory.createOpportunity();
        opp3.Name = 'opp3';
        opp3.AccountId = acc3.Id;
        opp3.ContractId = clientOverview.Id;
        insert opp3;
        TASKRAY__Project__c tp = new TASKRAY__Project__c(Name = 'Test CO - Select Partner Account',
                                                        Project_Type__c = 'New Client / Contract Path',
                                                        Project_Template_Category__c = 'Project Template',
                                                        Project_Sub_Type__c = 'Select Partner Account - Parent Project',
                                                        Client_Overview__c = clientOverview.Id,
                                                        TASKRAY__Project_Start__c = system.Today(),
                                                        TASKRAY__Project_End__c = system.Today() + 7,
                                                        TaskRayLaunchDate__c = system.today() + 7);
        insert tp;
        
        TASKRAY__Project__c tpsubProject = new TASKRAY__Project__c(Name = '[Template] Client Name - SPA Sub Project',
                                                         Project_Type__c = 'New Client / Contract Path',
                                                         Project_Template_Category__c = 'Project Template',
                                                         Project_Sub_Type__c = 'Select Partner Account - Sub Project',
                                                         TASKRAY__trTemplate__c = true);
       insert tpsubProject;        
    } 
    
    @isTest
    private static void createSubProjects(){
        TASKRAY__Project__c tp = [Select Id, Name,Project_Sub_Type__c,TASKRAY__Project_Start__c,TASKRAY__Project_End__c,
                                   TaskRayLaunchDate__c from TaskRay__Project__c where Name = 'Test CO - Select Partner Account' Limit 1];
        TASKRAY__Project__c tpsubProject = [Select Id from TASKRAY__Project__c where Name = '[Template] Client Name - SPA Sub Project' Limit 1];
        String templateId = tpsubProject.Id;
        List<String> templateIdlist = new List<String>();
        List<String> opIdList = new List<String>();
        List<List<String>> sourceList = new List<List<String>>();
        templateIdList.add(templateId);
        List<Opportunity> opps = [Select Id from opportunity where Name IN ('opp1', 'opp2','opp3') Limit 3];
        for(Opportunity op : opps){
            opIdList.add(op.Id);
        }
        opIdList.add(tp.Id);
        sourceList.add(opIdList);
        sourceList.add(templateIdList);
        Test.startTest();
        List<List<TaskRay__Project__c>> tpListFinals = new List<List<TaskRay__Project__c>>();
        tpListfinals = TaskRaySubProjectHandler.taskRayOpps(sourceList);
        Test.stopTest();
        System.assertNotEquals(null, tpListfinals);
        System.assertEquals(3, tpListfinals.get(0).size());
    }
}
global class TaskRaySubProjectHandler{
    
    public static final String PROJECT_SUB_TYPE = 'Select Partner Account - Parent Project';
    @InvocableMethod
    public static List<List<TaskRay__Project__c>> taskRayOpps(List<List<String>> sourceInfoList){
        system.debug('SourceInforList::: ' + sourceInfoList);
        Map<String,Map<String,Object>> projectInfo = new Map<String,Map<String,Object>>();
        List<Id> OppIdList = new List<Id>();
        String templateId;
        String parentProjectId;
        String newProjectName = '';
        String newSubProjectName = '[Template] Client Name - SPA Sub Project';
        String clientOverviewId;        
        templateId = System.label.TaskRayTemplateId;
        oppIdList = sourceInfoList.get(0);
        parentProjectId = oppIdList.remove(oppIdList.size()-1);
        if(Test.isRunningTest()){
            templateId = sourceInfoList.get(1).get(0);   
        }
        List<Opportunity> oppList = [Select Id, Account.Name,ContractId  from Opportunity where Id IN: oppIdList];
        clientOverviewId = oppList[0].ContractId;
        TaskRay__Project__c tp = [Select Id, TaskRayLaunchDate__c,TASKRAY__Project_Start__c, TASKRAY__Project_End__c
                                  from TaskRay__Project__c where Client_Overview__c =: clientOverviewId and 
                                  Project_Sub_Type__c =: PROJECT_SUB_TYPE and Id =:parentProjectId Limit 1];
        for(Opportunity opp: oppList){
            Map<String,Object> projectDetails = new Map<String,Object>();
            newProjectName = newSubProjectName.replace('[Template] Client Name',opp.Account.Name);
            projectDetails.put('templateProjectId',templateId);
            projectDetails.put('newName',newProjectName);
            projectDetails.put('depCloneBasedOnProjectStart', true);
            if(tp != Null && tp.TASKRAY__Project_Start__c != Null){
               projectDetails.put('newStartDate',tp.TASKRAY__Project_Start__c); 
            }
            projectDetails.put('contextRecordId', opp.Id);
            projectInfo.put(opp.Id,projectDetails);
        }
        try {
        Map<String,Object> cloneOptions = new Map<String,Object>();
        cloneOptions.put('assignInactiveToCurrent', true);  
        Map<String,Id> retInfo = TASKRAY.trTaskBoardController.cloneProjectsReturnIds(projectInfo, cloneOptions);
        List<TaskRay__Project__c> tpList = [Select Id, Name, TASKRAY__trOpportunity__c, TASKRAY__Project_Parent__c from 
                                            TaskRay__Project__c where ID IN: retInfo.values()]; 
        List<List<TaskRay__Project__c>> tpListFinal = new List<List<TaskRay__Project__c>>();
        tpListFinal.add(tpList);
        return tpListFinal;
        }
        catch (Exception e){
            System.debug('An unexpected error occured ' + e.getMessage());
            return null;            
        }
    } 
}
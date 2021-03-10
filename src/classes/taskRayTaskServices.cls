public class taskRayTaskServices {

    @InvocableMethod
    public static List<List<String>> BulkCloneTasks(List<List<String>> sourceInfo){
        List<List<String>> createdTaskIds = new List<List<String>>();
        List<String> starter = new List<String>{''};
       
       createdTaskIds.add(starter);
        Date projectEnd = date.parse(sourceInfo[0][0].replace('-','/').right(5) + '/' + sourceInfo[0][0].left(4));
        String projectId = sourceInfo[0][1];
        sourceInfo[0].remove(0);
        sourceInfo[0].remove(0);

        List<TASKRAY__Project_Task__c> allSourceTasks = 
            [SELECT Id, Name, TASKRAY__trBusinessDuration__c, TASKRAY__trDuration__c FROM TASKRAY__Project_Task__c WHERE Id IN :sourceInfo[0]];
        
        List<Map<String,Object>> taskInfo = new List<Map<String,Object>>();

        for(TASKRAY__Project_Task__c currentTask : allSourceTasks){
		
            Map<String,Object> taskInfoRecord = new Map<String,Object>();
            taskInfoRecord.put('templateTaskId',currentTask.Id);
            taskInfoRecord.put('taskName',currentTask.Name);
            
            //Formula below calculates business days. Use 'projectEnd.addDays(-Integer.valueOf(TASKRAY__trDuration__c) + 1)' to calculate ALL days (including weekends) 
            taskInfoRecord.put('taskStartDate',AddBusinessDays(projectEnd, -(Integer.valueOf(currentTask.TASKRAY__trBusinessDuration__c) - 1)));
            taskInfoRecord.put('taskEndDate',projectEnd);
            taskInfoRecord.put('projectId',projectId);
            taskInfo.add(taskInfoRecord);
        }

		Map<String,String> cloneOptions = new Map<String,String>();

		List<TASKRAY__Project_Task__c> newlyClonedTasks = TASKRAY.trTaskBoardController.cloneTasksReturnTasks(taskInfo, cloneOptions);
        
        for(TASKRAY__Project_Task__c currentClonedTask : [SELECT Id, TASKRAY__trTemplateSource__c FROM TASKRAY__Project_Task__c WHERE Id = :newlyClonedTasks]){
            
            createdTaskIds[0].add(currentClonedTask.TASKRAY__trTemplateSource__c + ':' + currentClonedTask.Id );
        }
        
        return createdTaskIds;
    }
    
    
	public static Boolean IsWeekendDay(Date dateParam)
   {
      boolean result     = false;
      system.debug('dateParam = '+dateParam); 
      //Recover the day of the week
      Date startOfWeek   = dateParam.toStartOfWeek();
      system.debug('startOfWeek = '+startOfWeek);
      Integer dayOfWeek  = startOfWeek.daysBetween(dateParam);
      system.debug('dayOfWeek = '+dayOfWeek);   
      result = dayOfWeek == 0 || dayOfWeek == 6 ? true : false;
      system.debug('result = '+result); 
      return result;
   } 
   
   
   public static Date AddBusinessDays(Date StartDate, integer BusinessDaysToAdd )
   {
      //Add or decrease in BusinessDaysToAdd days 
      Date finalDate = StartDate;
      system.debug('finaldate = '+finalDate);
      integer direction = BusinessDaysToAdd < 0 ? -1 : 1;
      system.debug('direction = '+direction);
       while(BusinessDaysToAdd != 0)
       {
           finalDate = finalDate.AddDays(direction);
           system.debug('BusinessDaysToAdd = '+BusinessDaysToAdd);            
           system.debug('finaldate = '+finalDate);
           if (!isWeekendDay(finalDate))
           {
               BusinessDaysToAdd -= direction;
               
           }
       }

       return finalDate;
   }
}
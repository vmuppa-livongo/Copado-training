/**
* AccountTriggerHandler Class
* 
*/

public class AccountTriggerHandler {
    public static final Id CLIENT_ACCOUNT_RT = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Client_Account').getRecordTypeId();
    public static final Id PARTNER_ACCOUNT_RT = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Partner_Account').getRecordTypeId();
    
    public static void handleAccountUpdate(Map<Id,Account> oldAccounts, List<Account> newAccounts) {
        List<Account> updatedAccounts = new List<Account>();
        List<Account> hsUpdateAccounts = new List<Account>();
        List<Account> hsProgramScoreAccounts = new List<Account>();
        for(Account acc : newAccounts){
            if(acc.Client_Risk_Notes__c != null && acc.Client_Risk_Notes__c != oldAccounts.get(acc.Id).Client_Risk_Notes__c){
                updatedAccounts.add(acc);
            }
            if ((acc.RecordTypeId == CLIENT_ACCOUNT_RT || acc.RecordTypeId == CLIENT_ACCOUNT_RT) &&
                acc.Enrollment_Percentage_rPwDs__c != null && acc.Enrollment_Percentage_rPwDs__c != oldAccounts.get(acc.Id).Enrollment_Percentage_rPwDs__c ||
                acc.Enrollment_Percentage_rPwHs__c != null && acc.Enrollment_Percentage_rPwHs__c != oldAccounts.get(acc.Id).Enrollment_Percentage_rPwHs__c || 
                acc.Activation__c  != null && acc.Activation__c  != oldAccounts.get(acc.Id).Activation__c || 
                acc.Activated_Percent_HTN__c != null && acc.Activated_Percent_HTN__c != oldAccounts.get(acc.Id).Activated_Percent_HTN__c ||
                acc.Usage_Last_30_day_Diabetes__c != null && acc.Usage_Last_30_day_Diabetes__c != oldAccounts.get(acc.Id).Usage_Last_30_day_Diabetes__c ||
                acc.Usage_Last_30_day_HTN__c != null && acc.Usage_Last_30_day_HTN__c != oldAccounts.get(acc.Id).Usage_Last_30_day_HTN__c ||
                acc.Email_Coverage_Percentage_DM__c != null && acc.Email_Coverage_Percentage_DM__c != oldAccounts.get(acc.Id).Email_Coverage_Percentage_DM__c || 
                acc.Email_Coverage_Percentage_HTN__c != null && acc.Email_Coverage_Percentage_HTN__c != oldAccounts.get(acc.Id).Email_Coverage_Percentage_HTN__c) {
                    hsUpdateAccounts.add(acc);
                }
        }
        if (!updatedAccounts.isEmpty()) {
            AccountService.autoCreateNote(updatedAccounts);           
        }
        if (!hsUpdateAccounts.isEmpty()) {
            AccountService.updateHealthScores(hsUpdateAccounts, oldAccounts);
        }
    }
    public static void handleAccountAfterInsert(List<Account> newAccounts) {
        List<Account> accList = new List<Account>();
        for (Account acc: newAccounts) {
            if (acc.RecordTypeId == CLIENT_ACCOUNT_RT || acc.RecordTypeId == PARTNER_ACCOUNT_RT) {
                accList.add(acc);
            }
        }
        if (!accList.isEmpty()) {
            AccountService.createHealthScores(accList);
        }
    }
}
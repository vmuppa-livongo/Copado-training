/**
* This is the TriggerHandler Class for the OpportunityLineItem Trigger.
* Created : 10/09/2020
* @author : Virinchi Bairisetty
*/
public class OpportunityLineItemTriggerHandler {
    //Method to update ARR and TCV formula fields into the ARR and TCV Copy fields which will be used to roll-up on the Opportuntiy.
    public static void handleOpportunityLineItemInsert(List<OpportunityLineItem> newOppLineList) {
        for (OpportunityLineItem oppLine: newOppLineList) {
            if (oppLine.Gross_Program_ARR__c  != null) {
                oppLine.Gross_Program_ARR_Copy__c = oppLine.Gross_Program_ARR__c;
            }
            if (oppLine.Program_ARR__c != null) {
                oppLine.Program_ARR_Copy__c = oppLine.Program_ARR__c;
            }
            if (oppLine.Gross_Program_TCV__c != null) {
                oppLine.Gross_Program_TCV_Copy__c = oppLine.Gross_Program_TCV__c;
            }
        }
    }
    
    //Method to update ARR and TCV formula fields into the ARR and TCV Copy fields which will be used to roll-up on the Opportuntiy.
    public static void handleOpportunityLineItemUpdate(Map<Id, OpportunityLineItem> oldOppLineMap, List<OpportunityLineItem> newOppLineList) {
        for (OpportunityLineItem oppLine: newOppLineList) {
            if (oppLine.Gross_Program_ARR__c  != null && oppLine.Gross_Program_ARR__c != oldOppLineMap.get(oppLine.Id).Gross_Program_ARR__c) {
                oppLine.Gross_Program_ARR_Copy__c = oppLine.Gross_Program_ARR__c;
            }
            if (oppLine.Program_ARR__c != null && oppLine.Program_ARR__c != oldOppLineMap.get(oppLine.Id).Program_ARR__c) {
                oppLine.Program_ARR_Copy__c = oppLine.Program_ARR__c;
            }
            if (oppLine.Gross_Program_TCV__c != null && oppLine.Gross_Program_TCV__c != oldOppLineMap.get(oppLine.Id).Gross_Program_TCV__c) {
                oppLine.Gross_Program_TCV_Copy__c = oppLine.Gross_Program_TCV__c;
            }
        }
    }
}
/**
* This is the Trigger for OpportunityLineItem object.
* Created : 10/09/2020
* @author : Virinchi Bairisetty
*/
trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert, before update) {
    if (Trigger.isInsert) {
        OpportunityLineItemTriggerHandler.handleOpportunityLineItemInsert(Trigger.new);
    }
    if (Trigger.isUpdate) {
        OpportunityLineItemTriggerHandler.handleOpportunityLineItemUpdate(Trigger.oldmap,  Trigger.new);
    }
}
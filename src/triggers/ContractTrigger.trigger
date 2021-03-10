/**
* A Trigger for the Contract object.
* Created : 05/13/2019
* @author Connor Gallaher - Slalom
*/

trigger ContractTrigger on Contract (after insert, after update, before delete, after delete) {
    if (Trigger.isAfter && Trigger.isInsert) {
        ContractTriggerHandler.handleContractAfterInsert(Trigger.new);
    }
    if (Trigger.isAfter && Trigger.isUpdate) {
        ContractTriggerHandler.handleContractUpdate(Trigger.oldMap, Trigger.new);
    }
    if (Trigger.isBefore && Trigger.isDelete){
        ContractTriggerHandler.handleContractDelete(Trigger.old);
    }
    if (Trigger.isAfter && Trigger.isDelete){
        ContractTriggerHandler.handleContractAfterDelete(Trigger.oldMap);
    }
}
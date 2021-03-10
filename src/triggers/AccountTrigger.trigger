/**
 * A Trigger for the Account Object
 *  
 */

trigger AccountTrigger on Account (after insert, after update) {
  if (Trigger.isInsert) {
     AccountTriggerHandler.handleAccountAfterInsert(Trigger.new);
  }
  if (Trigger.isUpdate) {
      AccountTriggerHandler.handleAccountUpdate(Trigger.oldmap,  Trigger.new);
   }
}
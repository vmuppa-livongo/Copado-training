/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trNotificationHelper {
    global static List<TASKRAY.trNotificationHelper.InboxNotificationWrapper> fetchNotifications(Id contextRecordId, Date startingDate, Date endingDate) {
        return null;
    }
global class InboxNotificationWrapper implements System.Comparable {
    global Datetime notificationDate {
        get;
        set;
    }
    global SObject notificationRecord {
        get;
        set;
    }
    global String notificationType {
        get;
        set;
    }
    global InboxNotificationWrapper(TASKRAY__trProjectInboxNotification__c notification) {

    }
    global InboxNotificationWrapper(TASKRAY__trTaskInboxNotification__c notification) {

    }
    global InboxNotificationWrapper(String notificationType, TASKRAY__Project_Task__c task) {

    }
    global InboxNotificationWrapper(String notificationType, TASKRAY__Project__c project) {

    }
    global InboxNotificationWrapper(String notificationType, TASKRAY__trContributor__c contributor) {

    }
}
}

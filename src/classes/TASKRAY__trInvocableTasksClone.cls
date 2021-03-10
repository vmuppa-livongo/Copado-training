/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trInvocableTasksClone {
    global trInvocableTasksClone() {

    }
    @InvocableMethod(label='Bulk Clone TaskRay Tasks (Flow Only)' description='Bulk Clone TaskRay Tasks in Flow')
    global static List<List<Id>> trInvocableTasksClone(List<TASKRAY.trInvocableTasksClone.Request> requests) {
        return null;
    }
global class Request {
    @InvocableVariable(label='Task Group Ids' required=false)
    global List<Id> newTaskGroupIds;
    @InvocableVariable(label='Task Owner Ids' required=false)
    global List<Id> newTaskOwnerIds;
    @InvocableVariable(label='Project Ids' required=true)
    global List<Id> newTaskProjectIds;
    @InvocableVariable(label='Task Schedule Modes (Enter "Start" or "End")' required=true)
    global List<String> scheduleModes;
    @InvocableVariable(label='Target Dates' required=true)
    global List<Date> targetDates;
    @InvocableVariable(label='Template Task Ids' required=true)
    global List<Id> templateTaskIds;
    global Request() {

    }
}
}

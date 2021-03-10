/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trCloneTasksFlow {
    global trCloneTasksFlow() {

    }
    @InvocableMethod(label='Deprecated (Do Not Use)' description='Bulk Clone TaskRay Tasks in Flow')
    global static List<Id> trCloneTasksFlow(List<TASKRAY.trCloneTasksFlow.Request> requests) {
        return null;
    }
global class Request {
    @InvocableVariable(label='New Task End Date' required=false)
    global List<Date> newTaskEndDates;
    @InvocableVariable(label='New Project Name List' required=true)
    global List<String> newTaskNames;
    @InvocableVariable(label='New Task Owner Ids' required=false)
    global List<Id> newTaskOwnerIds;
    @InvocableVariable(label='New Task Project Ids' required=false)
    global List<Id> newTaskProjectIds;
    @InvocableVariable(label='New Task Start Date' required=false)
    global List<Date> newTaskStartDates;
    @InvocableVariable(label='Template Task Id List' required=true)
    global List<Id> templateTaskIds;
    global Request() {

    }
}
}

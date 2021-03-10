/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trCloneProjectsFlow {
    global trCloneProjectsFlow() {

    }
    @InvocableMethod(label='Deprecated (Do Not Use)' description='Bulk Clone TaskRay Project in Flow')
    global static List<Id> trCloneProjectsFlow(List<TASKRAY.trCloneProjectsFlow.Request> requests) {
        return null;
    }
global class Request {
    @InvocableVariable(label='New Project Name List' required=true)
    global List<String> newProjectNames;
    @InvocableVariable(label='Project Schedule Mode List ("Start", "End", or a Milestone Id)' required=false)
    global List<String> projectScheduleModes;
    @InvocableVariable(label='Project Target Date List' required=false)
    global List<Date> projectTargetDates;
    @InvocableVariable(label='Source Record Id List' required=false)
    global List<Id> sourceRecordIds;
    @InvocableVariable(label='Template Project Id List' required=true)
    global List<Id> templateProjectIds;
    global Request() {

    }
}
}

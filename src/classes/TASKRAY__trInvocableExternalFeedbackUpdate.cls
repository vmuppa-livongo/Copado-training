/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trInvocableExternalFeedbackUpdate {
    global trInvocableExternalFeedbackUpdate() {

    }
    @InvocableMethod(label='Input External Onboarding Feedback' description='Use this method to update a TaskRay Project with onboarding feedback from a Site Guest user. This will update the record without sharing, which is required for Site Guest Users to make updates to records.')
    global static void trInvocableExternalFeedbackUpdate(List<TASKRAY.trInvocableExternalFeedbackUpdate.Request> requests) {

    }
global class Request {
    @InvocableVariable(label='Fields to Update' description='Specify the API names of the fields on the TaskRay Project that you would like to update.  Accepted format is TaskRay Project API field names separated by commas.' required=true)
    global String fieldsToUpdate;
    @InvocableVariable(label='TaskRay Project' description='Specify the TaskRay Project to update.  The fields specified in the "Fields to Update" input variable will be updated on this TaskRay Project.' required=true)
    global TASKRAY__Project__c project;
    global Request() {

    }
}
}

/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class trInvocableProjectOnbScoreCalc {
    global trInvocableProjectOnbScoreCalc() {

    }
    @InvocableMethod(label='Calculate Customer Onboarding Score' description='Use this method when your project is complete and ready to have the onboarding score calculated.')
    global static List<TASKRAY.trInvocableProjectOnbScoreCalc.Response> trInvocableProjectOnbScoreCalc(List<TASKRAY.trInvocableProjectOnbScoreCalc.Request> requests) {
        return null;
    }
global class Request {
    @InvocableVariable(label='Project Id' required=true)
    global Id projectId;
    global Request() {

    }
}
global class Response {
    @InvocableVariable(label='Customer Onboarding Score' required=false)
    global Double customerOnboardingScore;
    global Response() {

    }
}
}

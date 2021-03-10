/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class RuleRequest {
    global Set<Id> excludeRecords {
        get;
        set;
    }
    global Boolean isDelete {
        get;
        set;
    }
    global Boolean isInsert {
        get;
        set;
    }
    global Boolean isUndelete {
        get;
        set;
    }
    global Boolean isUpdate {
        get;
        set;
    }
    global List<String> objectFields {
        get;
    }
    global String objectName {
        get;
    }
    global Integer objectsNumber {
        get;
    }
    global Map<Id,SObject> oldObjectValues;
    global Set<Id> recordsIds {
        get;
    }
    global RuleRequest() {

    }
    global RuleRequest(Map<Id,SObject> newObjectValueMap, Map<Id,SObject> oldObjectValuesMap) {

    }
    global List<PFLSFTMA.FormulaSObjectValue> getFormulaValues(List<SObject> objects) {
        return null;
    }
}

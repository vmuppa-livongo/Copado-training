<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Archive_TaskRay_Project</fullName>
        <field>TASKRAY__Status__c</field>
        <literalValue>1</literalValue>
        <name>Archive TaskRay Project</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Complete_True</fullName>
        <field>TASKRAY__trCompleted__c</field>
        <literalValue>1</literalValue>
        <name>Complete True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Complete</fullName>
        <field>TaskRayStatus__c</field>
        <literalValue>Complete</literalValue>
        <name>Status Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>TaskRay Project marked %22100%25%22</fullName>
        <actions>
            <name>Complete_True</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Status_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TASKRAY__Project__c.TASKRAY__trCompletionPercentage__c</field>
            <operation>equals</operation>
            <value>100</value>
        </criteriaItems>
        <criteriaItems>
            <field>TASKRAY__Project__c.TASKRAY__Status__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <description>All Tasks in a TaskRay Project are marked &quot;Complete,&quot; so the Project Progress is &quot;100&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Archive_TaskRay_Project</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>

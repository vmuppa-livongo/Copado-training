<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Generic_Task</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Task_Type</fullName>
        <field>Type</field>
        <literalValue>Resource Request</literalValue>
        <name>Set Task Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Set Resource Request Task Parameters</fullName>
        <actions>
            <name>Set_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Task_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Subject</field>
            <operation>contains</operation>
            <value>Resource Request</value>
        </criteriaItems>
        <description>Set Resource Request Task Parameters like record type and type</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>

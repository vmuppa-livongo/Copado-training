<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Client_Tag_Validation_field</fullName>
        <description>Updates Client Tag Name custom field with value of the Client Tag Name</description>
        <field>Client_Tag_Name__c</field>
        <formula>Name</formula>
        <name>Update Client Tag Validation field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Run Client Tag Name Validation</fullName>
        <actions>
            <name>Update_Client_Tag_Validation_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Client Tag Validation field to match the Client Tag Name and validates it&apos;s unique.</description>
        <formula>ISNEW() || ISCHANGED( Name )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

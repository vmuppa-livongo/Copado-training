<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>PFLSFTMA__Update_TMA_CM_Field</fullName>
        <description>Update TMA Event Value</description>
        <field>PFLSFTMA__TMA_Event_Value__c</field>
        <formula>Text(Status)</formula>
        <name>Update TMA CM Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>PFLSFTMA__Set TMA Event Value</fullName>
        <actions>
            <name>PFLSFTMA__Update_TMA_CM_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Campaign.IsActive</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Moves data from Campaign Status to Custom field to allow APEX trigger to move data to contact record for TMA Send Rules to fire.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

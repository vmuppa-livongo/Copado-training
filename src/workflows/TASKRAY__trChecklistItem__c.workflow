<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Deselect_Template</fullName>
        <field>Template__c</field>
        <literalValue>0</literalValue>
        <name>Deselect Template</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Unassign_Checklist_Item</fullName>
        <field>TASKRAY__trOwner__c</field>
        <name>Unassign Checklist Item</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>New Template Checklist Item</fullName>
        <actions>
            <name>Unassign_Checklist_Item</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Checklist Item is created on a Wizard Template Project</description>
        <formula>AND(   TASKRAY__trOwner__c = $User.Id,   TASKRAY__Project_Task__r.TASKRAY__Project__r.TASKRAY__trTemplate__c = TRUE )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>

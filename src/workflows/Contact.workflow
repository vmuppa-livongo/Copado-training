<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>zaapit__Call Contact</fullName>
        <actions>
            <name>zaapit__Call_Contact</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Call Contact  - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Email Contact</fullName>
        <actions>
            <name>zaapit__Email_Contact</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Email Contact - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Send Letter Contact</fullName>
        <actions>
            <name>zaapit__Send_Letter_Contact</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Send Letter Contact - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Send Quote Contact</fullName>
        <actions>
            <name>zaapit__Send_Quote_Contact</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Send Quote Contact - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>zaapit__Call_Contact</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Call</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__Email_Contact</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Email</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__Send_Letter_Contact</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Send Letter</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__Send_Quote_Contact</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Send Quote</subject>
    </tasks>
</Workflow>

<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notify_Users_on_Survey_Status</fullName>
        <description>Notify Users on Survey Status</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Enrollment_Marketing_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Enrollment_Communications_Survey_Status_Updated</template>
    </alerts>
    <rules>
        <fullName>Notify Owner and EML when survey status is changed</fullName>
        <actions>
            <name>Notify_Users_on_Survey_Status</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Survey_Status__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

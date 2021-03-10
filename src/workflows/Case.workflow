<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Auto_Response_to_new_CRM_Request_case</fullName>
        <description>Auto Response to new CRM Request case</description>
        <protected>false</protected>
        <recipients>
            <field>ContactId</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Internal_CRM_Case_Received</template>
    </alerts>
    <alerts>
        <fullName>Case_ready_to_nurture</fullName>
        <ccEmails>sfintegration@livongo.com</ccEmails>
        <description>Case ready for JIRA</description>
        <protected>false</protected>
        <recipients>
            <recipient>vijay.polamraju@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Automated_Email_Notifications/Salesforce_Case_to_Jira_Story</template>
    </alerts>
    <alerts>
        <fullName>Case_to_Story_In_Jira</fullName>
        <description>Case to Story In Jira</description>
        <protected>false</protected>
        <recipients>
            <field>ContactId</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Case_to_Story_In_Jira</template>
    </alerts>
    <alerts>
        <fullName>Notify_Case_Owner_for_New_Reference_Request_Case</fullName>
        <description>Notify Case Owner for New Reference Request Case</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Reference_Request_Assignment</template>
    </alerts>
    <fieldUpdates>
        <fullName>Assign_Reference_Requests_to_Lisa_Thomas</fullName>
        <field>OwnerId</field>
        <lookupValue>lisa.thomas@livongo.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Reference Requests to Lisa Thomas</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Salesforce_Admins</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Assign CRM Requests to CRM Queue</fullName>
        <actions>
            <name>Update_Owner_to_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3)</booleanFilter>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notEqual</operation>
            <value>Sales Admin</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>CRM Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Assign Reference Requests to Lisa Thomas</fullName>
        <actions>
            <name>Assign_Reference_Requests_to_Lisa_Thomas</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Reference Request</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Case Auto Response</fullName>
        <actions>
            <name>Auto_Response_to_new_CRM_Request_case</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Reference Request Auto Response</fullName>
        <actions>
            <name>Notify_Case_Owner_for_New_Reference_Request_Case</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Reference Request</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>

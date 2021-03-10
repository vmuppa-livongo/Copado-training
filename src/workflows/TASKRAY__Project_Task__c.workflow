<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notify_Enrollment_Marketing_when_DOPS_tasks_are_completed</fullName>
        <ccEmails>marketing_automation@livongo.com</ccEmails>
        <description>Notify Enrollment Marketing when DOPS tasks are completed</description>
        <protected>false</protected>
        <recipients>
            <field>Client_Success_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Enrollment_Marketing_Lead_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Notify_Enrollment_Marketing_when_DOPS_tasks_are_completed</template>
    </alerts>
    <alerts>
        <fullName>Notify_Project_Owner_when_Task_is_assigned_from_queue_to_user</fullName>
        <description>Notify Project Owner when Task is assigned from queue to user</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Task_in_your_project_assigned_to_user</template>
    </alerts>
    <alerts>
        <fullName>TaskRay_Assignment_Notification</fullName>
        <description>TaskRay Assignment Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/TaskRay_Assignment_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Add_Completed_Date_Timestamp</fullName>
        <field>Completed_Date__c</field>
        <formula>TODAY()</formula>
        <name>Add Completed Date Timestamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Description_is_Blank</fullName>
        <field>Description_is_Blank__c</field>
        <literalValue>1</literalValue>
        <name>Description is Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Description_is_Not_Blank</fullName>
        <field>Description_is_Blank__c</field>
        <literalValue>0</literalValue>
        <name>Description is Not Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_CSM_Email_field</fullName>
        <description>If no CSM, add CIM instead</description>
        <field>Client_Success_Manager_Email__c</field>
        <formula>IF ( ISBLANK( TASKRAY__Project__r.Client_Overview__r.CSM__c ),
TASKRAY__Project__r.Client_Overview__r.CIM__r.Email, TASKRAY__Project__r.Client_Overview__r.CSM__r.Email)</formula>
        <name>Update CSM Email field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_EML_Email_on_Task</fullName>
        <field>Enrollment_Marketing_Lead_Email__c</field>
        <formula>TASKRAY__Project__r.Client_Overview__r.EML__r.Email</formula>
        <name>Update EML Email on Task</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Description is Blank</fullName>
        <actions>
            <name>Description_is_Blank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TASKRAY__Project_Task__c.TASKRAY__Description__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Description is Not Blank</fullName>
        <actions>
            <name>Description_is_Not_Blank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TASKRAY__Project_Task__c.TASKRAY__Description__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Billing Task</fullName>
        <actions>
            <name>TaskRay_Assignment_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Fire rule whenever a TaskRay Task is created and the owner is the Billing Unassigned Queue</description>
        <formula>OwnerId =  $Label.TaskRay_Billing_Unassigned_Queue_Id</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notify Enrollment Marketing when DOPS tasks are completed</fullName>
        <actions>
            <name>Notify_Enrollment_Marketing_when_DOPS_tasks_are_completed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notify Enrollment Marketing when DOPS tasks are completed</description>
        <formula>ISPICKVAL( Request_Type__c , &quot;Process and Load Data Files&quot;) 
&amp;&amp; Notify_CSM_ML__c = TRUE 
&amp;&amp; (ISCHANGED(TASKRAY__List__c) || ISNEW())
&amp;&amp; TEXT(TASKRAY__List__c) = &quot;Complete&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify Project Owner when task is assigned to user</fullName>
        <actions>
            <name>Notify_Project_Owner_when_Task_is_assigned_from_queue_to_user</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notify Project Owner when task is assigned from a queue to a user</description>
        <formula>IF(OwnerId &lt;&gt; CreatedById,  AND(  ISCHANGED(OwnerId),  LEFT(PRIORVALUE(OwnerId), 3)=&quot;00G&quot;,  LEFT(OwnerId,3) = &apos;005&apos;  ), FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Timestamp Completed Date</fullName>
        <actions>
            <name>Add_Completed_Date_Timestamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When a Task is marked &apos;Completed&apos; timestamp the current date.</description>
        <formula>ISCHANGED(  TASKRAY__List__c ) &amp;&amp; TEXT( TASKRAY__List__c ) = &apos;Complete&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Enrollment Marketing Email</fullName>
        <actions>
            <name>Update_CSM_Email_field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_EML_Email_on_Task</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISPICKVAL(Request_Type__c, &quot;Process and Load Data Files&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

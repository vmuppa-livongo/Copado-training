<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Account_Status_has_changed_to_Former_Client</fullName>
        <ccEmails>clientsuccessleadership@livongo.com</ccEmails>
        <description>Account Status has changed to Former Client</description>
        <protected>false</protected>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Account_Status_is_Former_Client</template>
    </alerts>
    <alerts>
        <fullName>CS_Client_Survey</fullName>
        <description>CS Client Survey</description>
        <protected>false</protected>
        <recipients>
            <field>Primary_CS_POC__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <recipient>lcrowe@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>lcrowe@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CS_Survey</template>
    </alerts>
    <alerts>
        <fullName>Enrollment_Marketing_Lead_Assignemnt</fullName>
        <description>Enrollment Marketing Lead Assignemnt</description>
        <protected>false</protected>
        <recipients>
            <field>EML__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Enrollment_Marketing_Lead_Assigned_to_You</template>
    </alerts>
    <alerts>
        <fullName>Impending_Client_Termination</fullName>
        <ccEmails>ssackrider@livongo.com</ccEmails>
        <description>Impending Client Termination</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <recipient>aclaypool@livongo.com.sales</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cpark@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>galpert@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jpursley@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kgreiter@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>legal@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mvandenberg@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>skapadia@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sroberts@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>CSM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Automated_SFDC_Notification_Impending_Client_Termination</template>
    </alerts>
    <fieldUpdates>
        <fullName>Multi_program</fullName>
        <field>Single_or_Multi_Program2__c</field>
        <literalValue>Multi Program</literalValue>
        <name>Multi program</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_CSM_60_Days</fullName>
        <field>RequestCSM__c</field>
        <literalValue>1</literalValue>
        <name>Request CSM_60 Days</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Single_program</fullName>
        <field>Single_or_Multi_Program2__c</field>
        <literalValue>Single Program</literalValue>
        <name>Single program</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_changed_to_Prosp_Exp_Int</fullName>
        <field>Account_Type__c</field>
        <literalValue>Prospecting - Expressed Interest</literalValue>
        <name>Status changed to Prosp-Exp Int</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Turn_Status_to_Engaging</fullName>
        <field>Account_Type__c</field>
        <literalValue>Engaging</literalValue>
        <name>Turn Status to Engaging</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Prior_Account_Status</fullName>
        <description>JENGA-1279</description>
        <field>Prior_Account_Status__c</field>
        <formula>TEXT(PRIORVALUE(Account_Type__c))</formula>
        <name>Update Prior Account Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Whole_Person_Populate</fullName>
        <field>Single_or_Multi_Program2__c</field>
        <literalValue>Whole Person</literalValue>
        <name>Whole Person Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Account Status Engaging</fullName>
        <actions>
            <name>Turn_Status_to_Engaging</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Account_Type__c</field>
            <operation>notEqual</operation>
            <value>Engaging,Client,Disqualified,Active Partner</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Closed_Won_Opportunity_Count__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Open_Opportunity_Count__c</field>
            <operation>notEqual</operation>
            <value>0</value>
        </criteriaItems>
        <description>An account with an open opportunity should be in the Account Status &apos;Engaging.&apos;</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Email notification for Impending Termination</fullName>
        <actions>
            <name>Impending_Client_Termination</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Impending_Client_Termination_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Enrollment Marketing Lead Assigned to You</fullName>
        <actions>
            <name>Enrollment_Marketing_Lead_Assignemnt</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.EML__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lost Opp Account status Expressed Interest</fullName>
        <actions>
            <name>Status_changed_to_Prosp_Exp_Int</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND (4 OR 5)</booleanFilter>
        <criteriaItems>
            <field>Account.Account_Type__c</field>
            <operation>equals</operation>
            <value>Prospecting,Engaging</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Open_Opportunity_Count__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Closed_Won_Opportunity_Count__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Total_Closed_No_Decision_Opps__c</field>
            <operation>notEqual</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Total_Closed_Lost_Opps__c</field>
            <operation>notEqual</operation>
            <value>0</value>
        </criteriaItems>
        <description>If a prospect has a closed no decision/lost opp, and no open opp, the status should be Prospecting - Expressed Interest</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Multi Program populate</fullName>
        <actions>
            <name>Multi_program</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Program_Count2__c</field>
            <operation>greaterOrEqual</operation>
            <value>2</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.PO_WholePerson__c</field>
            <operation>lessThan</operation>
            <value>1</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Request CIM</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Account.RequestCIM__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Creates a task and assigns to Client Implementation Director for purposes of requesting CIM to be assigned to Account.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request CSM</fullName>
        <actions>
            <name>Resource_Request_CSM_Needed_on_this_Account2</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Resource_Request_CSM_Needed_on_this_Account3</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Resource_Request_CSM_Needed_on_this_Account4</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Resource_Request_CSM_Needed_on_this_Account5</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Resource_Request_CSM_Needed_on_this_Account_1</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Resource_Request_CSM_Needed_on_this_Account_2</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.RequestCSM__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Creates a task and assigns to Client Success Director for purposes of requesting CSM to be assigned to Account.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request CSM_60 Days</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.Earliest_Active_Initial_Launch_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Client Account</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RequestCSM__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.CSM__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Account_Type__c</field>
            <operation>notEqual</operation>
            <value>Former Client,Disqualified,Study</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Request_CSM_60_Days</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Account.Earliest_Active_Initial_Launch_Date__c</offsetFromField>
            <timeLength>60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Send CS Survey</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.Account_Type__c</field>
            <operation>equals</operation>
            <value>Client - Launched</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Member_recruitment_began__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Client_Tier__c</field>
            <operation>equals</operation>
            <value>Tier 1,Tier 2</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Account_ID_Long__c</field>
            <operation>equals</operation>
            <value>0014600000jx15KAAQ,0014600000YHwkKAAT</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CS_Client_Survey</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>CS_Survey_Email_Sent</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Account.Member_recruitment_began__c</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Single program populate</fullName>
        <actions>
            <name>Single_program</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Program_Count2__c</field>
            <operation>equals</operation>
            <value>1</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.PO_WholePerson__c</field>
            <operation>lessThan</operation>
            <value>1</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Prior Account Status</fullName>
        <actions>
            <name>Update_Prior_Account_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>JENGA-1279</description>
        <formula>AND(ISCHANGED(Account_Type__c), NOT(ISPICKVAL(Account_Type__c, &apos;&apos;)), NOT(ISBLANK(PRIORVALUE(Account_Type__c))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Whole Person Populate</fullName>
        <actions>
            <name>Whole_Person_Populate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.PO_WholePerson__c</field>
            <operation>equals</operation>
            <value>1</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Call  - Account %28Exmaple by ZaapIT%29</fullName>
        <active>false</active>
        <description>Call Account - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Call %28Exmaple by ZaapIT%29</fullName>
        <active>false</active>
        <description>Call Account Example by ZaapIT (don&apos;t activated - an example)</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Email - Account %28Exmaple by ZaapIT%29</fullName>
        <actions>
            <name>zaapit__Email</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Email Account - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Send Letter  - Account %28Exmaple by ZaapIT%29</fullName>
        <actions>
            <name>zaapit__SendLetterAccount</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Send Letter Account - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Send Quote - Account %28Exmaple by ZaapIT%29</fullName>
        <actions>
            <name>zaapit__SendQuoteAccount</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Send Quote Account - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>CS_Survey_Email_Sent</fullName>
        <assignedTo>salesops@livongo.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>The CS Survey email was sent to the CS Primary Contact today. Message can be seen in this email template:
https://livongohealth2ndorg.my.salesforce.com/00X46000000YhMM</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>CS Survey Email Sent</subject>
    </tasks>
    <tasks>
        <fullName>Resource_Request_CSM_Needed_on_this_Account</fullName>
        <assignedTo>galpert@livongo.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Resource Request: CSM Needed on this Account</subject>
    </tasks>
    <tasks>
        <fullName>Resource_Request_CSM_Needed_on_this_Account2</fullName>
        <assignedTo>stacey.deweerdt@livongo.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Resource Request: CSM Needed on this Account</subject>
    </tasks>
    <tasks>
        <fullName>Resource_Request_CSM_Needed_on_this_Account3</fullName>
        <assignedTo>suzanne.falaschetti@livongo.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Resource Request: CSM Needed on this Account</subject>
    </tasks>
    <tasks>
        <fullName>Resource_Request_CSM_Needed_on_this_Account4</fullName>
        <assignedTo>sara.young@livongo.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Resource Request: CSM Needed on this Account</subject>
    </tasks>
    <tasks>
        <fullName>Resource_Request_CSM_Needed_on_this_Account5</fullName>
        <assignedTo>dana.smith@livongo.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Resource Request: CSM Needed on this Account</subject>
    </tasks>
    <tasks>
        <fullName>Resource_Request_CSM_Needed_on_this_Account_1</fullName>
        <assignedTo>sroberts@livongo.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Resource Request: CSM Needed on this Account</subject>
    </tasks>
    <tasks>
        <fullName>Resource_Request_CSM_Needed_on_this_Account_2</fullName>
        <assignedTo>skapadia@livongo.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Resource Request: CSM Needed on this Account</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__Call</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Call</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__Email</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Email</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__SendLetterAccount</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Send Letter</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__SendQuoteAccount</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Send Quote</subject>
    </tasks>
</Workflow>

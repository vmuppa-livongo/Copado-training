<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Client_Must_Approved_Assets_has_changed</fullName>
        <description>Client_Must_Approved_Assets_has_changed</description>
        <protected>false</protected>
        <recipients>
            <field>CSM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Client_Must_Approved_Assets_has_changed</template>
    </alerts>
    <alerts>
        <fullName>Consecutive_Inactive_Months_to_Lapse_is_changed</fullName>
        <description>Consecutive_Inactive_Months_to_Lapse_is_changed</description>
        <protected>false</protected>
        <recipients>
            <field>Client_Overview_CSM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Consecutive_Inactive_Months_to_Lapse_is_changed</template>
    </alerts>
    <alerts>
        <fullName>Contract_Term_Date_14_Days</fullName>
        <description>Contract_Term_Date_14_Days</description>
        <protected>false</protected>
        <recipients>
            <recipient>dana.smith@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>galpert@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sara.young@livongo.com</recipient>
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
        <template>Automated_Email_Notifications/Contract_Term_Date_14_Days</template>
    </alerts>
    <alerts>
        <fullName>Contract_Termination_Date_has_changed</fullName>
        <description>Contract_Termination_Date_has_changed</description>
        <protected>false</protected>
        <recipients>
            <field>CSM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Contract_Termination_Date_has_changed</template>
    </alerts>
    <alerts>
        <fullName>Detailed_Invoice_has_changed</fullName>
        <description>Detailed_Invoice_has_changed</description>
        <protected>false</protected>
        <recipients>
            <field>CSM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Detailed_Invoice_has_changed</template>
    </alerts>
    <alerts>
        <fullName>Email_CSM_90_days_prior_to_Contract_expiration</fullName>
        <description>Email CSM 90 days prior to Contract expiration</description>
        <protected>false</protected>
        <recipients>
            <recipient>Client Success Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Program_Schedule_90_days_from_expiration</template>
    </alerts>
    <alerts>
        <fullName>Is_There_Laspe_Criteria_has_Changed</fullName>
        <description>Is_There_Laspe_Criteria_has_Changed</description>
        <protected>false</protected>
        <recipients>
            <field>Client_Overview_CSM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Is_There_Laspe_Criteria_has_Changed</template>
    </alerts>
    <alerts>
        <fullName>Lapse_Criteria_has_Changed</fullName>
        <description>Lapse_Criteria_has_Changed</description>
        <protected>false</protected>
        <recipients>
            <field>Client_Overview_CSM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Lapse_Criteria_has_Changed</template>
    </alerts>
    <alerts>
        <fullName>Notify_Legal_Cannot_Activate_Contract_No_Lapse_Criteria</fullName>
        <ccEmails>legal@livongo.com</ccEmails>
        <description>Notify Legal - Cannot Activate Contract - No Lapse Criteria</description>
        <protected>false</protected>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Cannot_Activate_Contract_No_Lapse_Criteria</template>
    </alerts>
    <alerts>
        <fullName>Notify_Legal_with_required_fields_missing_on_contract</fullName>
        <ccEmails>legal@livongo.com</ccEmails>
        <description>Notify Legal with required fields missing on contract</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notify_Legal_with_Required_Fields_Required</template>
    </alerts>
    <alerts>
        <fullName>Notify_when_Client_Overview_status_is_changed_to_Expired_or_Terminated</fullName>
        <ccEmails>clientsuccessleadership@livongo.com</ccEmails>
        <description>Notify when Client Overview status is changed to Expired or Terminated</description>
        <protected>false</protected>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/ClientOverview_is_Expired_or_Terminated</template>
    </alerts>
    <alerts>
        <fullName>Participants_Term_Mininum_Months_has_changed</fullName>
        <description>Participants_Term_Mininum_Months_has_changed</description>
        <protected>false</protected>
        <recipients>
            <field>Client_Overview_CSM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Participants_Term_Mininum_Months_has_changed</template>
    </alerts>
    <alerts>
        <fullName>Program_End_Date_has_Changed</fullName>
        <description>Program_End_Date_has_Changed</description>
        <protected>false</protected>
        <recipients>
            <field>Client_Overview_CSM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Program_End_Date_has_changed</template>
    </alerts>
    <alerts>
        <fullName>Program_Overview_Date_14_Days</fullName>
        <description>Program_Overview_Date_14_Days</description>
        <protected>false</protected>
        <recipients>
            <recipient>dana.smith@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>galpert@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sara.young@livongo.com</recipient>
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
            <recipient>suzanne.falaschetti@livongo.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Client_Overview_CSM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Program_Overview_Date_14_Days</template>
    </alerts>
    <alerts>
        <fullName>Program_Status_has_Changed</fullName>
        <description>Program_Status_has_Changed</description>
        <protected>false</protected>
        <recipients>
            <field>Client_Overview_CSM__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>sfdc-sales@livongo.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Automated_Email_Notifications/Program_Status_has_changed</template>
    </alerts>
    <fieldUpdates>
        <fullName>Complete_Per_Legal_Date_Time</fullName>
        <field>Date_Completed_By_Legal__c</field>
        <formula>NOW()</formula>
        <name>Complete Per Legal Date-Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Program_Implementation_Status</fullName>
        <field>Program_Implementation_status__c</field>
        <literalValue>Terminated</literalValue>
        <name>Program Implementation  Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Registration_Status</fullName>
        <field>Registration_Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Registration Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateProgramImplementationStatus</fullName>
        <description>Update Prog Implementation Status to &quot;Launch+90&quot;</description>
        <field>Program_Implementation_status__c</field>
        <literalValue>Launched +90</literalValue>
        <name>UpdateProgramImplementationStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateRegStatus</fullName>
        <description>udpate the reg status to Open</description>
        <field>Registration_Status__c</field>
        <literalValue>Open</literalValue>
        <name>UpdateRegStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Contract_Status_Activated</fullName>
        <description>Updates the Status on Contract to &quot;Activated&quot;</description>
        <field>Status</field>
        <literalValue>Activate</literalValue>
        <name>Update Contract Status - Activated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Contract_Status_Terminated</fullName>
        <description>Updates the Contract status to &quot;Expired&quot;</description>
        <field>Status</field>
        <literalValue>Expired</literalValue>
        <name>Update Contract Status - Expired</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Program_Agreement_default_name</fullName>
        <description>Set&apos;s contract name field to Account name</description>
        <field>Name</field>
        <formula>Account.Name</formula>
        <name>Update Program Agreement default name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Program_Overview_Name</fullName>
        <description>Default the name for a Program Overview record</description>
        <field>Name</field>
        <formula>LEFT(Account.Name &amp; &quot; - &quot; &amp;  TEXT(Program_Name__c)  &amp; &quot; - &quot; &amp; Client_Overview__r.Contract_Path__r.Name, 80)</formula>
        <name>Update Program Overview Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_TargetedRecruitableField_on_PO</fullName>
        <field>Targeted_Recruitable_Data__c</field>
        <literalValue>1</literalValue>
        <name>Update TargetedRecruitableField on PO</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Contract_Term_Date_14_Days</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>Client Overview</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Contract_Termination_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>notEqual</operation>
            <value>Terminated</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Contract_Term_Date_14_Days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.Contract_Termination_Date__c</offsetFromField>
            <timeLength>-14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Date Stamp Complete per Legal</fullName>
        <actions>
            <name>Complete_Per_Legal_Date_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Complete_Per_Legal__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Default Program Overview Name</fullName>
        <actions>
            <name>Update_Program_Overview_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When a Program Overview record is manually created and the &quot;Name&quot; field is blank, give it a default name</description>
        <formula>CASESAFEID(RecordType.Id) =  $Label.Program_Schedule_Record_Type  &amp;&amp; OR(ISCHANGED( Program_Name__c ), ISBLANK(Name))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify when Client Overview is Expired or Terminated</fullName>
        <actions>
            <name>Notify_when_Client_Overview_status_is_changed_to_Expired_or_Terminated</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notify CS Leadership when Client Overview status changes to Expired or Terminated.</description>
        <formula>AND(RecordType.Name=&quot;Client Overview&quot;, 				ISCHANGED(Status), 				OR(ISPICKVAL(Status, &quot;Expired&quot;) ,ISPICKVAL(Status, &quot;Terminated&quot;)) 			)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Program_Overview_Date_14_Days</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>Program Overview</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Program_End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Program_Implementation_status__c</field>
            <operation>notEqual</operation>
            <value>Terminated</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Program_Overview_Date_14_Days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.Program_End_Date__c</offsetFromField>
            <timeLength>-14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Send CSM email when contract is 90 days prior to expiration</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>Program Overview</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Activated</value>
        </criteriaItems>
        <description>Notify the CSM assigned to an account 90 days prior to a contract expiration (end date), so they can initiate renewal activities</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_CSM_90_days_prior_to_Contract_expiration</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contract.ContractRenewalDate__c</offsetFromField>
            <timeLength>-90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Set default Program Agreement Name</fullName>
        <actions>
            <name>Update_Program_Agreement_default_name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>Program Agreement</value>
        </criteriaItems>
        <description>Set&apos;s the default contract name field of a Program Agreement to the name of the account it&apos;s related too.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Client Overview Status - Activate</fullName>
        <active>true</active>
        <description>Updates the status of a Client Overview to &quot;Activated&quot; on the Contract Effective Date.</description>
        <formula>AND(RecordType.Name = &quot;Client Overview&quot;, TEXT(Status) = &quot;Draft&quot;, NOT(ISBLANK(Contract_Effective_Date__c)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Contract_Status_Activated</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Contract.Contract_Effective_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update Client Overview Status - Expired</fullName>
        <active>true</active>
        <description>Updates the status of a Client Overview to &quot;Expired&quot; on the Contract Terminated Date.</description>
        <formula>AND(RecordType.Name = &quot;Client Overview&quot;, TEXT(Status) = &quot;Active&quot;, NOT(ISBLANK(Contract_Termination_Date__c)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notify_when_Client_Overview_status_is_changed_to_Expired_or_Terminated</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Update_Contract_Status_Terminated</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Contract.Contract_Termination_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update PO Fields when Status is Terminated</fullName>
        <actions>
            <name>Program_Implementation_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Registration_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Program Implementation Status” to be updated to “Terminated” and “Registration Status” as “Closed” , when the Program Status  is Terminated</description>
        <formula>AND(RecordType.Name = &quot;Program Overview&quot;, ISPICKVAL(Status, &quot;Terminated&quot;), NOT(ISBLANK(Program_End_Date__c)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update PO Reg Status and Implementation Status</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>Program Overview</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>notEqual</operation>
            <value>Terminated,Expired</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Actual_Launch_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Jenga#1451  update PO registration status =&apos;open&apos; and Prog Implementation Status =&apos;Launch+90&apos; if launch date is passed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>UpdateProgramImplementationStatus</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>UpdateRegStatus</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Contract.Actual_Launch_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update Program Overview Status - Activate</fullName>
        <active>true</active>
        <description>Updates the status of a Program Overview to &quot;Activated&quot; on the Program Start Date.</description>
        <formula>AND(RecordType.Name = &quot;Program Overview&quot;,      				NOT(ISBLANK(Program_Start_Date__c)),  				TEXT(Status) = &quot;Draft&quot;,       Client_Overview_Status__c 	= &quot;Active&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Contract_Status_Activated</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Contract.Program_Start_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update Program Overview Status - Expired</fullName>
        <active>true</active>
        <description>Updates the status of a Program Overview to &quot;Expired&quot; on the Program End Date.</description>
        <formula>AND(RecordType.Name = &quot;Program Overview&quot;, TEXT(Status) = &quot;Active&quot;, NOT(ISBLANK(Program_End_Date__c)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Contract_Status_Terminated</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Contract.Program_End_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update TargetedRecruitableData field when PO is created</fullName>
        <actions>
            <name>Update_TargetedRecruitableField_on_PO</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract.RecordTypeId</field>
            <operation>equals</operation>
            <value>Program Overview</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>

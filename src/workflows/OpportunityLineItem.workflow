<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Copy_Gross_EVA</fullName>
        <field>Gross_Program_TCV_Copy__c</field>
        <formula>Gross_Program_TCV__c</formula>
        <name>Copy Gross EVA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Gross_Program_ARR</fullName>
        <field>Gross_Program_ARR_Copy__c</field>
        <formula>Gross_Program_ARR__c</formula>
        <name>Copy Gross Program ARR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Net_Program_ARR</fullName>
        <field>Program_ARR_Copy__c</field>
        <formula>Program_ARR__c</formula>
        <name>Copy Net Program ARR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Gross_Program_ARR_Copy_Formula_Update</fullName>
        <field>Gross_Program_ARR_Copy__c</field>
        <formula>IF(AND(Program_Family__c == &apos;Behavioral Health&apos;), (BLANKVALUE(Product_Participants__c, 0) * (BLANKVALUE(UnitPrice, 0) * 12) + ((BLANKVALUE(Product_Participants__c, 0) * 0.02) * BLANKVALUE(PMPM__c, 0) * 6)),
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Commercial&apos;), OR(Program_Family__c == &apos;Prediabetes&apos;, Program_Family__c == &apos;Weight Management&apos;), BLANKVALUE(UnitPrice, 0) == 1.00), (608.00 * (BLANKVALUE(Product_Participants__c, 0) * 0.10)),
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Health Services&apos;), OR(Program_Family__c == &apos;Prediabetes&apos;, Program_Family__c == &apos;Weight Management&apos;), BLANKVALUE(UnitPrice, 0) == 1.00), (608.00 * (BLANKVALUE(Product_Participants__c, 0) * 0.08)),
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Commercial&apos;), Program_Family__c == &apos;Diabetes&apos;), (0.25 * BLANKVALUE(Product_Participants__c, 0) * (BLANKVALUE(UnitPrice, 0) * 12)) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * 0.25 * BLANKVALUE(Incremental_Sales_Price__c, 0) * 12,
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Commercial&apos;), NOT(Program_Family__c == &apos;Diabetes&apos;)), (0.10 * BLANKVALUE(Product_Participants__c, 0) * (BLANKVALUE(UnitPrice, 0) * 12)) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * 0.10 * BLANKVALUE(Incremental_Sales_Price__c, 0) * 12,
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Health Services&apos;), Program_Family__c == &apos;Diabetes&apos;), (0.20 * BLANKVALUE(Product_Participants__c, 0) * (BLANKVALUE(UnitPrice, 0) * 12)) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * 0.20 * BLANKVALUE(Incremental_Sales_Price__c, 0) * 12,
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Health Services&apos;), NOT(Program_Family__c == &apos;Diabetes&apos;)), (0.08 * BLANKVALUE(Product_Participants__c, 0) * (BLANKVALUE(UnitPrice, 0) * 12)) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * 0.08 * BLANKVALUE(Incremental_Sales_Price__c, 0) * 12,
(BLANKVALUE(Product_Participants__c, 0) * (BLANKVALUE(UnitPrice, 0) * 12)) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * BLANKVALUE(Incremental_Sales_Price__c, 0) * 12
)))))))</formula>
        <name>Gross Program ARR Copy Formula Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Gross_Program_TCV_Copy_Formula_Update</fullName>
        <field>Gross_Program_TCV_Copy__c</field>
        <formula>CASE(Program_Family__c,
&apos;Diabetes&apos;, BLANKVALUE(Product_Participants__c, 0) * 0.25 * BLANKVALUE(UnitPrice, 0) * BLANKVALUE(Quantity, 0) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * 0.25 * BLANKVALUE(Incremental_Sales_Price__c, 0) * BLANKVALUE(Quantity, 0),
&apos;Hypertension&apos;, BLANKVALUE(Product_Participants__c, 0) * 0.10 * BLANKVALUE(UnitPrice, 0) * BLANKVALUE(Quantity, 0) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * 0.10 * BLANKVALUE(Incremental_Sales_Price__c, 0) * BLANKVALUE(Quantity, 0),
&apos;Weight Management&apos;, IF(BLANKVALUE(UnitPrice, 0) == 1.00,
500 * BLANKVALUE(Product_Participants__c, 0) * 0.10 + BLANKVALUE(Product_Participants__c, 0) * 0.10 * BLANKVALUE(Year_2_Price__c, 0) * MAX(BLANKVALUE(Quantity, 0) - 12, 0),
BLANKVALUE(Product_Participants__c, 0) * 0.10 * BLANKVALUE(UnitPrice, 0) * 12 + BLANKVALUE(Product_Participants__c, 0) * 0.10 * BLANKVALUE(Year_2_Price__c, 0) * MAX(BLANKVALUE(Quantity, 0) - 12, 0)) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * 0.10 * BLANKVALUE(Incremental_Sales_Price__c, 0) * BLANKVALUE(Quantity, 0),
&apos;Prediabetes&apos;, IF(BLANKVALUE(UnitPrice, 0) == 1.00,
500 * BLANKVALUE(Product_Participants__c, 0) * 0.10 + BLANKVALUE(Product_Participants__c, 0) * 0.10 * BLANKVALUE(Year_2_Price__c, 0) * MAX(BLANKVALUE(Quantity, 0) - 12, 0),
BLANKVALUE(Product_Participants__c, 0) * 0.10 * BLANKVALUE(UnitPrice, 0) * 12 + BLANKVALUE(Product_Participants__c, 0) * 0.10 * BLANKVALUE(Year_2_Price__c, 0) * MAX(BLANKVALUE(Quantity, 0) - 12, 0)) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * 0.10 * BLANKVALUE(Incremental_Sales_Price__c, 0) * BLANKVALUE(Quantity, 0),
BLANKVALUE(Product_Participants__c, 0) * BLANKVALUE(UnitPrice, 0) * BLANKVALUE(Quantity, 0) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * BLANKVALUE(Incremental_Sales_Price__c, 0) * BLANKVALUE(Quantity, 0))</formula>
        <name>Gross Program TCV Copy Formula Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Net_Program_TCV_Update</fullName>
        <description>Update Net Program TCV Copy field with the value from the Net Program TCV field</description>
        <field>Net_Program_TCV_Copy__c</field>
        <formula>Net_Program_TCV__c</formula>
        <name>Net Program TCV Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PO_WholePerson</fullName>
        <field>PO_WholePerson__c</field>
        <formula>1</formula>
        <name>PO#_WholePerson</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Program_ARR_Copy_Formula_Update</fullName>
        <field>Program_ARR_Copy__c</field>
        <formula>IF(AND(Program_Family__c == &apos;Behavioral Health&apos;), (BLANKVALUE(Product_Participants__c, 0) * ((BLANKVALUE(UnitPrice, 0) - (BLANKVALUE(Estimated_At_Risk_PPPM__c, 0) + BLANKVALUE(Estimated_Partner_Admin_Fees__c, 0))) * 12 + BLANKVALUE(Up_Front_Per_Member__c, 0)) + ((BLANKVALUE(Product_Participants__c, 0) * 0.02) * BLANKVALUE(PMPM__c, 0) * 6)),
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Commercial&apos;), OR(Program_Family__c == &apos;Prediabetes&apos;, Program_Family__c == &apos;Weight Management&apos;), UnitPrice == 1.00), (608.00 * (BLANKVALUE(Product_Participants__c, 0) * 0.10)),
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Health Services&apos;), OR(Program_Family__c == &apos;Prediabetes&apos;, Program_Family__c == &apos;Weight Management&apos;), UnitPrice == 1.00), (608.00 * (BLANKVALUE(Product_Participants__c, 0) * 0.08)),
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Commercial&apos;), Program_Family__c == &apos;Diabetes&apos;), (0.25 * BLANKVALUE(Product_Participants__c, 0) * ((BLANKVALUE(UnitPrice, 0) - (BLANKVALUE(Estimated_At_Risk_PPPM__c, 0) + BLANKVALUE(Estimated_Partner_Admin_Fees__c, 0))) * 12 + BLANKVALUE(Up_Front_Per_Member__c, 0))) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * 0.25 * BLANKVALUE(Incremental_Sales_Price__c, 0) * 12,
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Commercial&apos;), NOT(Program_Family__c == &apos;Diabetes&apos;)), (0.1 * BLANKVALUE(Product_Participants__c, 0) * ((BLANKVALUE(UnitPrice, 0) - (BLANKVALUE(Estimated_At_Risk_PPPM__c, 0) + BLANKVALUE(Estimated_Partner_Admin_Fees__c, 0))) * 12 + BLANKVALUE(Up_Front_Per_Member__c, 0))) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * 0.10 * BLANKVALUE(Incremental_Sales_Price__c, 0) * 12,
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Health Services&apos;), Program_Family__c == &apos;Diabetes&apos;), (0.2 * BLANKVALUE(Product_Participants__c, 0) * ((BLANKVALUE(UnitPrice, 0) - (BLANKVALUE(Estimated_At_Risk_PPPM__c, 0) + BLANKVALUE(Estimated_Partner_Admin_Fees__c, 0))) * 12 + BLANKVALUE(Up_Front_Per_Member__c, 0))) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * 0.20 * BLANKVALUE(Incremental_Sales_Price__c, 0) * 12,
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Health Services&apos;), NOT(Program_Family__c == &apos;Diabetes&apos;)), (0.08 * BLANKVALUE(Product_Participants__c, 0) * ((BLANKVALUE(UnitPrice, 0) - (BLANKVALUE(Estimated_At_Risk_PPPM__c, 0) + BLANKVALUE(Estimated_Partner_Admin_Fees__c, 0))) * 12 + BLANKVALUE(Up_Front_Per_Member__c, 0))) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * 0.08 * BLANKVALUE(Incremental_Sales_Price__c, 0) * 12,
(BLANKVALUE(Product_Participants__c, 0) * ((BLANKVALUE(UnitPrice, 0) - (BLANKVALUE(Estimated_At_Risk_PPPM__c, 0) + BLANKVALUE(Estimated_Partner_Admin_Fees__c, 0))) * 12 + BLANKVALUE(Up_Front_Per_Member__c, 0))) + BLANKVALUE(Currently_Enrolled_Members__c, 0) * BLANKVALUE(Incremental_Sales_Price__c, 0) * 12
)))))))</formula>
        <name>Net Program ARR Copy Formula Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Program_ARR_Copy_Update</fullName>
        <description>Update Program ARR Copy field with the value from the Program ARR field</description>
        <field>Program_ARR_Copy__c</field>
        <formula>Program_ARR__c</formula>
        <name>Program ARR Copy Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Program_TCV_Copy_Formula_Update</fullName>
        <field>Net_Program_TCV_Copy__c</field>
        <formula>IF(AND(Program_Family__c == &apos;Behavioral Health&apos;, NOT(Exclude_Enrollment__c)), (BLANKVALUE(Product_Participants__c, 0) * ((BLANKVALUE(UnitPrice, 0) - (BLANKVALUE(Estimated_At_Risk_PPPM__c, 0) + BLANKVALUE(Estimated_Partner_Admin_Fees__c, 0))) * BLANKVALUE(Quantity, 0) + BLANKVALUE(Up_Front_Per_Member__c, 0)) + ((BLANKVALUE(Product_Participants__c, 0) * 0.02) * BLANKVALUE(PMPM__c, 0) * 6)),
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Commercial&apos;), OR(Program_Family__c == &apos;Prediabetes&apos;, Program_Family__c == &apos;Weight Management&apos;), UnitPrice == 1.00, NOT(Exclude_Enrollment__c)), (608.00 * (BLANKVALUE(Product_Participants__c, 0) * 0.10) * (BLANKVALUE(Quantity, 0) / 12)),
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Health Services&apos;), OR(Program_Family__c == &apos;Prediabetes&apos;, Program_Family__c == &apos;Weight Management&apos;), UnitPrice == 1.00, NOT(Exclude_Enrollment__c)), (608.00 * (BLANKVALUE(Product_Participants__c, 0) * 0.08) * (BLANKVALUE(Quantity, 0) / 12)),
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Commercial&apos;), Program_Family__c == &apos;Diabetes&apos;, NOT(Exclude_Enrollment__c)), (0.25 * BLANKVALUE(Product_Participants__c, 0) * ((BLANKVALUE(UnitPrice, 0) - (BLANKVALUE(Estimated_At_Risk_PPPM__c, 0) + BLANKVALUE(Estimated_Partner_Admin_Fees__c, 0))) * BLANKVALUE(Quantity, 0) + BLANKVALUE(Up_Front_Per_Member__c, 0))),
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Commercial&apos;), NOT(Program_Family__c == &apos;Diabetes&apos;), NOT(Exclude_Enrollment__c)), (0.1 * BLANKVALUE(Product_Participants__c, 0) * ((BLANKVALUE(UnitPrice, 0) - (BLANKVALUE(Estimated_At_Risk_PPPM__c, 0) + BLANKVALUE(Estimated_Partner_Admin_Fees__c, 0))) * BLANKVALUE(Quantity, 0) + BLANKVALUE(Up_Front_Per_Member__c, 0))),
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Health Services&apos;), Program_Family__c == &apos;Diabetes&apos;, NOT(Exclude_Enrollment__c)), (0.2 * BLANKVALUE(Product_Participants__c, 0) * ((BLANKVALUE(UnitPrice, 0) - (BLANKVALUE(Estimated_At_Risk_PPPM__c, 0) + BLANKVALUE(Estimated_Partner_Admin_Fees__c, 0))) * BLANKVALUE(Quantity, 0) + BLANKVALUE(Up_Front_Per_Member__c, 0))),
IF(AND(CONTAINS(Opportunity.Opp_Owner_Role__c, &apos;Health Services&apos;), NOT(Program_Family__c == &apos;Diabetes&apos;), NOT(Exclude_Enrollment__c)), (0.08 * BLANKVALUE(Product_Participants__c, 0) * ((BLANKVALUE(UnitPrice, 0) - (BLANKVALUE(Estimated_At_Risk_PPPM__c, 0) + BLANKVALUE(Estimated_Partner_Admin_Fees__c, 0))) * BLANKVALUE(Quantity, 0) + BLANKVALUE(Up_Front_Per_Member__c, 0))),
(BLANKVALUE(Product_Participants__c, 0) * ((BLANKVALUE(UnitPrice, 0) - (BLANKVALUE(Estimated_At_Risk_PPPM__c, 0) + BLANKVALUE(Estimated_Partner_Admin_Fees__c, 0))) * BLANKVALUE(Quantity, 0) + BLANKVALUE(Up_Front_Per_Member__c, 0)))
)))))))</formula>
        <name>Program TCV Copy Formula Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sales_Price_equals_Sales_Comm_Price</fullName>
        <field>Sales_Commissionable_Price__c</field>
        <formula>UnitPrice</formula>
        <name>Sales Price equals Sales Comm Price</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Integrate_Program_field_to_TRUE</fullName>
        <description>Sets the Integrate Program field on the Opportunity Program to TRUE when an Opportunity Program is created.</description>
        <field>IntegrateProgram__c</field>
        <literalValue>1</literalValue>
        <name>Set Integrate Program field to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_Opportunity_Product_Name</fullName>
        <field>OpportunityProductName__c</field>
        <formula>Product2.Name</formula>
        <name>Set the Opportunity Product Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Opportunity_Product_Record_Type</fullName>
        <description>Update the Product record type field with the related product record type</description>
        <field>Product_Record_Type__c</field>
        <formula>Product2.RecordType.DeveloperName</formula>
        <name>Update Opportunity Product Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>ARR and TCV on Creation</fullName>
        <actions>
            <name>Gross_Program_ARR_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Gross_Program_TCV_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Program_ARR_Copy_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Program_TCV_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>NOT(ISBLANK(UnitPrice))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Owner Role IsChanged</fullName>
        <actions>
            <name>Copy_Gross_EVA</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Gross_Program_ARR</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Net_Program_ARR</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Opportunity_Owner_Role__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PO%23_WholePerson</fullName>
        <actions>
            <name>PO_WholePerson</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Product2.Whole_Person_Solution__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate Product Record Type</fullName>
        <actions>
            <name>Update_Opportunity_Product_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Populate the Opportunity Line Item &quot;Product Record Type&quot; to be used with roll up summary fields.</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Sales Commisionable Price on Creation</fullName>
        <actions>
            <name>Sales_Price_equals_Sales_Comm_Price</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>notEqual</operation>
            <value>Closed Won,Closed Lost,Closed No Decision</value>
        </criteriaItems>
        <description>Sales Commissionable Price will be updated to match Sales Price until the Opportunity is Closed Won.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Quantity and Product Participants Values Updated</fullName>
        <actions>
            <name>Gross_Program_ARR_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Gross_Program_TCV_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Program_ARR_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Program_TCV_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(NOT(ISNEW()), OR(ISCHANGED(Quantity), ISCHANGED(Product_Participants__c), ISCHANGED(Currently_Enrolled_Members__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sales Price updates Sales Comm Price until closed</fullName>
        <actions>
            <name>Sales_Price_equals_Sales_Comm_Price</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>notEqual</operation>
            <value>Closed Won,Closed Lost,Closed No Decision</value>
        </criteriaItems>
        <description>Sales Commissionable Price will be updated to match Sales Price until the Opportunity is Closed Won.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Integrate Program Field on Opportunity Product</fullName>
        <actions>
            <name>Set_Integrate_Program_field_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Sets the Integrate Program field on the Opportunity Program to TRUE.</description>
        <formula>IntegrateProgram__c = FALSE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set the Product Name</fullName>
        <actions>
            <name>Set_the_Opportunity_Product_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Sets the product name on the Opportunity Product</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Gross Program ARR and TCV Copy</fullName>
        <actions>
            <name>Gross_Program_ARR_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Gross_Program_TCV_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>OR(ISCHANGED(UnitPrice), ISCHANGED(Opportunity_Owner_Role__c), ISCHANGED(PMPM__c),ISCHANGED(Incremental_Sales_Price__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Gross Program ARR or TCV Copy</fullName>
        <actions>
            <name>Gross_Program_ARR_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Gross_Program_TCV_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>OR(ISCHANGED(UnitPrice), ISCHANGED(Opportunity_Owner_Role__c), ISCHANGED(PMPM__c), ISCHANGED(Exclude_Enrollment__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Net Program TCV Copy</fullName>
        <actions>
            <name>Net_Program_TCV_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Update Net Program TCV Copy field with the value from the Net Program TCV field. The Net Program TCV Copy field will be used to roll up into Net TCV on Opportunity object.</description>
        <formula>ISCHANGED(Net_Program_TCV__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Net Program TCV Copy V2</fullName>
        <actions>
            <name>Program_TCV_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>OR(ISCHANGED(UnitPrice), ISCHANGED(Opportunity_Owner_Role__c), ISCHANGED(Estimated_At_Risk_PPPM__c), ISCHANGED(Estimated_Partner_Admin_Fees__c), ISCHANGED(Up_Front_Per_Member__c), ISCHANGED(PMPM__c), ISCHANGED(Exclude_Enrollment__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Program ARR Copy</fullName>
        <actions>
            <name>Program_ARR_Copy_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Update Program ARR Copy field with the value from the Program ARR field.  The Program ARR Copy field will be used to roll up into Net ARR on Opportunity object.</description>
        <formula>ISCHANGED(Program_ARR__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Program ARR Copy V2</fullName>
        <actions>
            <name>Program_ARR_Copy_Formula_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Update Program ARR Copy with Program ARR Version 2. (JENGA-1267)</description>
        <formula>OR(ISCHANGED(UnitPrice), ISCHANGED(Opportunity_Owner_Role__c), ISCHANGED(Up_Front_Per_Member__c), ISCHANGED(Estimated_At_Risk_PPPM__c), ISCHANGED(Estimated_Partner_Admin_Fees__c), ISCHANGED(PMPM__c), ISCHANGED(Incremental_Sales_Price__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

@isTest(SeeAllData=true)
public class RHX_TEST_CMCAssociation {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM CMCAssociation__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new CMCAssociation__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}
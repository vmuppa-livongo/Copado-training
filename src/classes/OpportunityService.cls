public class OpportunityService {
    public static Map<Id, List<OpportunityLineItem>> oppLineItemMap = new Map<Id, List<OpportunityLineItem>>();
    public static void updateClientARR (List<Opportunity> oppList, Set<Id> accIdSet){
        List<Account> updateAccList = New List<Account>();
        Map<Id, List<Opportunity>> accIdWithOppListMap = new Map<Id, List<Opportunity>>();
        //Get Account Details for Current Opportunity
        List<Opportunity> oppWAccList = [SELECT Id, AccountId, Account.Client_Arr__c, Type, Adjusted_Annual_Renewal_Value_Enrolled__c, 
                                         Gross_ARR__c, CloseDate FROM Opportunity WHERE Id IN: oppList];
        
        // Find all the Opportunities under this Opportunity's Account
        for(Account acc: [SELECT Id, (SELECT Id, Type, Adjusted_Annual_Renewal_Value_Enrolled__c, Gross_ARR__c, CloseDate FROM Opportunities
                                      WHERE StageName = 'Closed Won' ORDER BY CloseDate DESC) FROM Account WHERE Id IN: accIdSet]) {
                                          accIdWithOppListMap.put(acc.Id, acc.Opportunities);
                                      }
        
        //Find all OpportunityLineItems under this account and map it with opportunities
        for(Opportunity opp1: [SELECT Id, (SELECT Id, Product2.Name FROM OpportunityLineItems) FROM Opportunity WHERE AccountId IN: accIdSet]) {
            oppLineItemMap.put(opp1.Id, opp1.OpportunityLineItems);
        }
        
        //Process the opportunities
        for(Opportunity opp: oppWAccList) {
            processOpportunties(opp.Account, accIdWithOppListMap.get(opp.AccountId));
            updateAccList.add(opp.Account);
        }
        
        if(updateAccList.size() > 0) {
            try {
                update updateAccList;
            }
            catch(DMLException e) {
                system.debug('The following exception has occurred:' + e.getMessage());
            }
        }
    }
    public static void processOpportunties(Account acc, List<Opportunity> accountOppList) {
        Opportunity opp = new Opportunity();
        List<Opportunity> relatedOppList = New List<Opportunity>();
        List<Opportunity> relatedRenewalOpps = New List<Opportunity>();
        List<Opportunity> relatedContractPathChangeOpps = New List<Opportunity>();
        List<Opportunity> relatedCrossSellOpps = New List<Opportunity>();
        List<Opportunity> relatedExpansionOpps = New List<Opportunity>();
        List<Opportunity> relatedNonRenewalOpps = New List<Opportunity>();
        List<Opportunity> oppList = New List<Opportunity>();
        List<String> stringList1 = New List<String>();
        List<String> stringList2 = New List<String>();
        Opportunity closestOpp = new Opportunity();
        Decimal nonRenewalARR = 0;
        
        // If there is only Opporuntiy of Type either Renewal or any Non-Renewal
        If(accountOppList.Size() == 1) {
            opp = accountOppList[0];
            If(opp.Type == 'Renewal') {
                acc.Client_Arr__c = opp.Adjusted_Annual_Renewal_Value_Enrolled__c;
            }
            else {
                acc.Client_Arr__c = opp.Gross_ARR__c ;        
            }
        }
        
        // If thre are Multiple Opportunities
        else If(accountOppList.Size() > 1) {
            for(Opportunity relOpp: accountOppList) {
                if(relOpp.Type == 'Renewal') {
                    relatedRenewalOpps.add(relOpp);
                }
                else if(relOpp.Type == 'Contract Path Change') {
                    relatedContractPathChangeOpps.add(relOpp);
                }
                else {
                    relatedNonRenewalOpps.add(relOpp);
                }
            }
            
            // Renewal Opportunity Logics
            
            // If Type = Renewal + Contract Path Change
            // a. If Contract Path Change opportunity close date is greater than Renewal opportunity close date
            // 	  then Client ARR = Contract Path Change ARR(Gross ARR)
            // b. If Renewal opportuntiy close date is greater than Contract Path Change opportunity close date
            //    then Client ARR = Renewal ARR(Adjusted Annual Renewal Value Enrolled)
            if(relatedRenewalOpps.Size() > 0 && relatedContractPathChangeOpps.Size() > 0) {
                oppList.clear();
                oppList.addAll(relatedRenewalOpps); 
                oppList.addAll(relatedContractPathChangeOpps);
                closestOpp = findClosestOpp(oppList);
                if(closestOpp.Type == 'Renewal') {
                    acc.Client_Arr__c = closestOpp.Adjusted_Annual_Renewal_Value_Enrolled__c ;
                }
                else{
                    acc.Client_Arr__c = closestOpp.Gross_ARR__c;
                }
            }
            
            // If Type = Renewal + Expansion/Cross-Sell
            // If There is a Expansion or Cross-Sell opportuntiy for which the close date is greater than
            // renewal opportuntiy. The Client ARR = Expansion or Cross-sell opportunity's ARR (Gross ARR) + Renewal opportunity's ARR.
            else if(relatedRenewalOpps.Size() > 0 && relatedNonRenewalOpps.Size() > 0) {
                Opportunity renewalClosestOpp = findClosestOpp(relatedRenewalOpps);
                Opportunity nonRenewalClosestOpp = findClosestOpp(relatedNonRenewalOpps);
                Boolean isProdutsMatched = findIfOppProductsMatch(renewalClosestOpp, nonRenewalClosestOpp);
                nonRenewalARR = 0;
                
                for(Opportunity nonRenOpp: relatedNonRenewalOpps) {
                    if((nonRenOpp.Type == 'Cross-sell (New product)' || nonRenOpp.Type == 'Expansion') && 
                       nonRenOpp.CloseDate >= renewalClosestOpp.CloseDate) {
                           nonRenewalARR += nonRenOpp.Gross_ARR__c;
                       }
                }
                
                if((nonRenewalClosestOpp.Type == 'Cross-sell (New product)' || nonRenewalClosestOpp.Type == 'Expansion') &&
                   nonRenewalClosestOpp.CloseDate >= renewalClosestOpp.CloseDate) {
                       acc.Client_Arr__c = nonRenewalARR + renewalClosestOpp.Adjusted_Annual_Renewal_Value_Enrolled__c;
                   }
                else if((nonRenewalClosestOpp.Type == 'Cross-sell (New product)' || nonRenewalClosestOpp.Type == 'Expansion') &&
                        renewalClosestOpp.CloseDate >= nonRenewalClosestOpp.CloseDate && !isProdutsMatched) {
                            acc.Client_Arr__c = nonRenewalClosestOpp.Gross_ARR__c + renewalClosestOpp.Adjusted_Annual_Renewal_Value_Enrolled__c;
                        }
                
                // If Type = Renewal
                // If there are any other Renewal opportunities left.
                else if(relatedRenewalOpps.Size() > 0) {
                    closestOpp = findClosestOpp(relatedRenewalOpps);
                    acc.Client_Arr__c = closestOpp.Adjusted_Annual_Renewal_Value_Enrolled__c;
                }
            }
            
            
            
            // Non-Renewal Opportunity Logics
            
            else {
                if(relatedContractPathChangeOpps.Size() > 0) {
                    closestOpp = findClosestOpp(relatedContractPathChangeOpps);
                    acc.Client_Arr__c = closestOpp.Gross_ARR__c;
                }
                else {
                    nonRenewalARR = 0;
                    for(Opportunity nonRenewalOpp: relatedNonRenewalOpps) {
                        nonRenewalARR += nonRenewalOpp.Gross_ARR__c ;
                    }
                    acc.Client_Arr__c = nonRenewalARR;
                }   
            }
        }
    }
    
    //Finds the closest opportunity based on opportuntiy close date near to today.
    public static Opportunity findClosestOpp(List<Opportunity> oppList) {
        Opportunity closestOpp = new Opportunity();
        Map<Date, Opportunity> oppMap = new Map<Date, Opportunity>();
        Set<Date> closedDateSet = new Set<Date>();
        List<Date> closedDateList;
        
        if(oppList.Size() > 0) {
            for(Opportunity opp: oppList) {
                oppMap.put(opp.CloseDate, opp);
            }
            closedDateSet = oppMap.keySet();
            closedDateList = new List<Date>(closedDateSet);
            closedDateList.sort();
            closestOpp = oppMap.get(closedDateList[closedDateList.size() - 1]);
        }
        return closestOpp;
    }
    
    public static Boolean findIfOppProductsMatch(Opportunity opp1, Opportunity opp2) {
        List<String> stringList1 = new List<String>();
        List<String> stringList2 = new List<String>();
        for(OpportunityLineItem Oli1: oppLineItemMap.get(opp1.Id)) {
            stringList1.add(Oli1.Product2.Name);
        }
        for(OpportunityLineItem Oli2: oppLineItemMap.get(opp2.Id)) {
            stringList2.add(Oli2.Product2.Name);
        }
        return stringList1.equals(stringList2);
    }
    
    public static void handleClientARRUpdateFromAccount(Set<Id> accIdSet){
        Map<Id, List<Opportunity>> accIdWithOppListMap = new Map<Id, List<Opportunity>>();
        List<Account> accList = new List<Account>();
        List<Account> accUpdateList = new List<Account>();
        
        for(Account acc: [SELECT Id, Client_Arr__c, (SELECT Id, Type, Adjusted_Annual_Renewal_Value_Enrolled__c, Gross_ARR__c, CloseDate FROM Opportunities
                                                     WHERE StageName = 'Closed Won' ORDER BY CloseDate DESC) FROM Account WHERE Id IN: accIdSet]) {
                                                         accList.add(acc);
                                                         accIdWithOppListMap.put(acc.Id, acc.Opportunities);
                                                     }
        oppLineItemMap.clear();
        //Find all OpportunityLineItems under this account and map it with opportunities
        for(Opportunity opp1: [SELECT Id, (SELECT Id, Product2.Name FROM OpportunityLineItems) FROM Opportunity WHERE AccountId IN: accIdSet]) {
            oppLineItemMap.put(opp1.Id, opp1.OpportunityLineItems);
        }
        
        for(Account acc1: accList) {
            processOpportunties(acc1, accIdWithOppListMap.get(acc1.Id));
            accUpdateList.add(acc1);
        }
        
        if(accUpdateList.size() > 0) {
            try {
                update accUpdateList;
            }
            catch(DMLException e) {
                system.debug('The following exception has occurred:' + e.getMessage());
            }
        }
    }
    
    public static void updateHealthScores(List<Opportunity> newOpportunities) {
        Set<Id> accIdSet = new Set<Id>();
        Map<Id, List<Opportunity>> accToOppMap = new Map<Id, List<Opportunity>>();
        List<Health_Score__c> hsListToUpdate = new List<Health_Score__c>();
        for (Opportunity opp : newOpportunities) {
            if (opp.Type == 'Renewal') {
                accIdSet.add(opp.AccountId);
            }
        }
        if (accIdSet.size() > 0){
            List<Account> accList = [SELECT Id, (SELECT Id, CloseDate FROM Opportunities) FROM Account WHERE Id IN :accIdSet];
            for (Account acc : accList) {
                accToOppMap.put(acc.Id, acc.Opportunities);
            }
            List<Health_Score__c> hsList = [SELECT Id, Account__c, Actual_Result__c FROM Health_Score__c 
                                            WHERE Account__c IN :accIdSet AND RecordType.Name = 'Account Health Score' 
                                            AND Health_Segment__c = 'Renewal Timing'];
            if (hsList.size() > 0) {
                for (Health_Score__c hs : hsList) {
                    Opportunity closestOpp = findClosestOpp(accToOppMap.get(hs.Account__c));
                    if (Date.today().monthsBetween(closestOpp.CloseDate) < 6) {
                        hs.Actual_Result__c = '<6 months';
                    }
                    else if (Date.today().monthsBetween(closestOpp.CloseDate) >= 6 && Date.today().monthsBetween(closestOpp.CloseDate) <= 12) {
                        hs.Actual_Result__c = '6 months - 1 year';
                    }
                    else if (Date.today().monthsBetween(closestOpp.CloseDate) > 12) {
                        hs.Actual_Result__c = '>1 year';
                    }
                    hsListToUpdate.add(hs);
                } 
            }
            if (hsListToUpdate.size() > 0) {
                try {
                    update hsListToUpdate;
                }
                catch(DMLException e){
                    system.debug('The following exception has occurred:' + e.getMessage());
                }
            }
        }
    }
}
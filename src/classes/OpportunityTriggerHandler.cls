public class OpportunityTriggerHandler {
    public static Boolean isFirstTime = true;
    public static void handleOpportunityAfterUpdate(Map<Id, Opportunity> oldOpportunities, List<Opportunity> newOpportunities) {
        List<Opportunity> oppList = new List<Opportunity>();
        List<Opportunity> hsOppList = new List<Opportunity>();
        List<Account> updateAccList = new List<Account>();
        Set<Id> accIdSet = new Set<Id>();
        for(Opportunity opp: newOpportunities) {
            if(opp.StageName == 'Closed Won' && (opp.StageName != oldOpportunities.get(opp.Id).StageName)){
                oppList.add(opp);
                accIdSet.add(opp.AccountId);
            }
            if (opp.Type == 'Renewal' && opp.CloseDate != oldOpportunities.get(opp.Id).CloseDate) {
                hsOppList.add(opp);
            }
        }
        if(oppList.Size() > 0) {
            OpportunityService.updateClientARR(oppList, accIdSet);
        }
        if (hsOppList.size() > 0) {
            OpportunityService.updateHealthScores(hsOppList);
        }
    }
    public static void handleOpportunityAfterInsert(List<Opportunity> newOpportunities) {
        List<Opportunity> hsOppList = new List<Opportunity>();
        for(Opportunity opp: newOpportunities) {
            if (opp.Type == 'Renewal') {
                hsOppList.add(opp);
            } 
        }
        if (hsOppList.size() > 0) {
            OpportunityService.updateHealthScores(hsOppList);
        }
    }
}
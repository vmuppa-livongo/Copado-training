public without sharing class OpportunityLineItemService {
    public static final String DM_SOLUTION = System.Label.DM_Solution;
    public static final String CV_SOLUTION = System.Label.CV_Solution;
    public static final String DP_SOLUTION = System.Label.DP_Solution;
    public static Map<String, Decimal> programToParticipantPercentMap = new Map<String, Decimal>();
    
    static {
        Map<String, Decimal> ppMap = new Map<String, Decimal>();
        Program_Participant__mdt[] ppMDT = [SELECT Program_Name__c, ParticipantPercentage__c FROM Program_Participant__mdt];
        for (Program_Participant__mdt pp: ppMDT) {
            ppMap.put(pp.Program_Name__c, pp.ParticipantPercentage__c);
        }
        programToParticipantPercentMap = ppMap;        
    }
    
    @InvocableMethod(label='Calculate Program Participant')
    public static List<List<OpportunityLineItem>> calculateProgramParticipants(List<List<OpportunityLineItem>> oliList) {
        //Get the OpportunityLineItem Information
        List<OpportunityLineItem> OppLineItemlist=new List<OpportunityLineItem>();
        List<List<OpportunityLineItem>> finalOppLineItemList = new List<List<OpportunityLineItem>>();
        OppLineItemlist=oliList[0];         
        Set<Id> oliIds = new Set<Id>();
        for (OpportunityLineItem l : OppLineItemlist) {
            oliIds.add(l.Id);
        }
        
        List<OpportunityLineItem> lineItemList = [SELECT Id, Program_ID__c, OpportunityProductName__c, Opportunity.Opportunity_Covered_Lives__c, Product_Participants__c,
                                                  Price_Book_ID__r.Name, Pricing_Structure__c, Quantity, Product2.Whole_Person_Solution__c, OpportunityId FROM OpportunityLineItem WHERE Id IN :oliIds];
        //Add Unique Programs to Set
        Set<String> programNameSet = new Set<String>();
        for (OpportunityLineItem lineItem: lineItemList) {
            programNameSet.add(lineItem.OpportunityProductName__c);
        }
        
        for (OpportunityLineItem oli: lineItemList) {
            if (oli.Opportunity.Opportunity_Covered_Lives__c != null) {                
                if (oli.OpportunityProductName__c  == CV_SOLUTION) {
                    if (programNameSet.contains(DM_SOLUTION) && programNameSet.contains(DP_SOLUTION)) {
                        oli.Product_Participants__c = programToParticipantPercentMap.get('CV + DM + DP') * oli.Opportunity.Opportunity_Covered_Lives__c;                        
                    }
                    else if (programNameSet.contains(DM_SOLUTION)) {
                        oli.Product_Participants__c = programToParticipantPercentMap.get('CV + DM') * oli.Opportunity.Opportunity_Covered_Lives__c; 
                    }
                    else if (programNameSet.contains(DP_SOLUTION)) {
                        oli.Product_Participants__c =programToParticipantPercentMap.get('CV + DP') * oli.Opportunity.Opportunity_Covered_Lives__c; 
                    }
                    else {
                        oli.Product_Participants__c = programToParticipantPercentMap.get(oli.OpportunityProductName__c) * oli.Opportunity.Opportunity_Covered_Lives__c;
                    }
                }
                else if (programToParticipantPercentMap.get(oli.OpportunityProductName__c) != null) {
                    oli.Product_Participants__c = programToParticipantPercentMap.get(oli.OpportunityProductName__c) * oli.Opportunity.Opportunity_Covered_Lives__c;
                }
                if(oli.Product_Participants__c != null){
                   oli.Product_Participants__c = oli.Product_Participants__c.round();                   
                }
            }            
        }
        finalOppLineItemList.add(lineItemList);          
        return finalOppLineItemList;
    }      
}
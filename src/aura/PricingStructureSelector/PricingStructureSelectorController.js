({
    init : function(component, event, helper) {
        helper.populatePricingStructureOptions(component, event, helper);
        helper.isCmpValid(component, event, helper);
    },

    handleSelect : function(component, event, helper) {
        helper.selectPricingStructure(component, event, helper);
    },
})
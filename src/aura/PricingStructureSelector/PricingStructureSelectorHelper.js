({
    populatePricingStructureOptions : function(component, event, helper) {
        let options = [];
        options.push({
            Name : component.get('v.placeholder')
        });
        let pricingStructures = component.get('v.pricingStructures');
        for (let i = 0; i < pricingStructures.length; i++) {
            options.push(pricingStructures[i]);
        }
        component.set('v.pricingStructureOptions', options);
    },

    isCmpValid : function(component, event, helper) {
        component.set('v.validate', function() { 
            let pricingStructure = component.get('v.selectedPricingStructure');
            if (pricingStructure && pricingStructure.Id) {
                return {
                    isValid: true 
                }; 
            } 
            else {
                return { 
                    isValid: false, 
                    errorMessage: 'Please select a valid Pricing Structure before continuing.' 
                }; 
            }
        });
    },

    selectPricingStructure : function(component, event, helper) {
        let selected = component.find('pricingStructureDropdown').get('v.value');
        let options = component.get('v.pricingStructureOptions');
        let pricingStructure;
        for (let i = 0; i < options.length; i++) {
            if (selected === options[i].Name) {
                pricingStructure = options[i];
                break;
            }
        }
        component.set('v.selectedPricingStructure', pricingStructure);
    }
})
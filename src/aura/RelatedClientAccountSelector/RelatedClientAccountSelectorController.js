({
    init : function(component, event, helper) {
        helper.init(component, event, helper);
    },

    handleSelection : function(component, event, helper) {
        helper.updateSelectedRows(component, event, helper);
    },

    updateColumnSorting : function(component, event, helper) {
        let fieldName = event.getParam('fieldName');
        let sortDirection = event.getParam('sortDirection');
		component.set('v.sortedBy', fieldName);
		component.set('v.sortedDirection', sortDirection);
        helper.sortData(component, fieldName, sortDirection);
	},
})
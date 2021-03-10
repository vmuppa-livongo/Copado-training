({
    init : function(component, event, helper) {
        component.set('v.columns', [
            {   
                label: 'Account Name', 
                fieldName: 'Master_Client_Account_Name__c', 
                type: 'text'
            },
            {
                label: 'Relationship Type',
                fieldName: 'RelationshipType__c',
                type: 'text',
                sortable: true
            }
        ]);
        component.set('v.data', component.get('v.InputRelationshipsCollection'));
    },

    updateSelectedRows : function(component, event, helper) {
        var selectedRows = event.getParam('selectedRows');
        var count = selectedRows.length;
        var relationships = [];
        for (var i = 0; i < count; i++) {
            relationships.push(selectedRows[i]);
        }
        component.set('v.selectedRowsCount', count);
        component.set('v.OutputRelationshipsCollection', relationships);
    },

    sortData: function (cmp, fieldName, sortDirection) {
        let data = cmp.get('v.data');
        let reverse = sortDirection !== 'asc';
        data.sort(this.sortBy(fieldName, reverse))
        cmp.set('v.data', data);
    },

    sortBy: function (field, reverse, primer) {
        let key = primer ?
            function (x) {
                return primer(x[field])
            } :
            function (x) {
                return x[field]
            };
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },
})
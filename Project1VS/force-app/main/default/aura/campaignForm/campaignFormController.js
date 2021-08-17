({
    
    fetchCurrent : function(component, event, helper){
        helper.fetchCurrentHelper(component,event,helper)
    },
    
    fetchCC: function(component, event, helper){
        helper.fetchCCHelper(component,event,helper)
    },
    
    getSelectedName:function(event) {
        const selectedRows = event.detail.selectedRows;
        // Display that fieldName of the selected rows
        for (let i = 0; i < selectedRows.length; i++){
            alert("You selected a row ");
        }
    },
    handleRowAction: function (cmp, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        switch (action.name) {
            case 'view_details':
                helper.showRowDetails(row);
                break;
                
            case 'join':
               // alert("Clicked on join");
                helper.addNewCampaign(row,cmp,event,helper);
                break;
                
            case 'unjoin':
               // alert("Clicked on delete");
                helper.deleteCampaign(row,cmp,event,helper);
                break;
                
            default:
                helper.showRowDetails(row);
                break;
        }
    }
})
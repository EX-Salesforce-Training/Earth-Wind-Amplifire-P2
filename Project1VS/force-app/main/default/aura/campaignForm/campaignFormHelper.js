({
    fetchCCHelper : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Campaign Name', fieldName: 'Campaign_Name__c', type: 'text'},
                {label: 'Status', fieldName: 'Status__c', type: 'text'},
                 {label: 'Images', fieldName: 'Status__c', type: 'Image'},
                {label: 'Summary', fieldName: 'Summary__C', type: 'text'},
                {label: 'Dungeon Master', fieldName: 'Dungeon_Master__c', type: 'text '},
            {label: 'View', type: 'button', initialWidth: 135, typeAttributes: { label: 'View Details', name: 'view_details', title: 'Click to View Details'}},
            {label: 'Add Campaign', type: 'button', initialWidth: 135, typeAttributes: { label: 'Join', name: 'join', title: 'Join'}}
            
            ]);
        var action = component.get("c.fetchCampaigns");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.ccList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    
    fetchCurrentHelper: function(component, event, helper){
       component.set('v.myCurrentcolumns', [
            {label: 'Campaign Name', fieldName: 'Campaign_Name__c', type: 'text'},
                {label: 'Status', fieldName: 'Status__c', type: 'text'},
                {label: 'Summary', fieldName: 'Summary__C', type: 'text'},
                {label: 'Dungeon Master', fieldName: 'Dungeon_Master__c', type: 'text '},
               {label: 'View', type: 'button', initialWidth: 135, typeAttributes: { label: 'View Details', name: 'view_details', title: 'Click to View Details'}},
             {label: 'Exit', type: 'button', initialWidth: 135, typeAttributes: { label: 'Exit', name: 'unjoin', title: 'exit'}}
            ]);
          var currentCampaigns = component.get("c.fetchCurrentCampaigns") ;
       currentCampaigns.setParams({
        });
        currentCampaigns.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.currentCampaignList", response.getReturnValue());
            }
        });
        $A.enqueueAction(currentCampaigns);
        
    },
    
    showRowDetails : function(row) {
        // eslint-disable-next-line no-alert
       // alert("Showing opportunity " + row.opportunityName + " closing on " + row.closeDate);
       alert("Clicked on Campaign number "+row.Name);
    },
    
    deleteCampaign : function(row,component, event, helper){
        var action = component.get("c.deleteCampaign");
    
        var newRecord= row.Campaign_Name__c;
         alert(newRecord);
        action.setParams({
            "recordName":newRecord
        });
        
        action.setCallback(this,function(response){
            var state= response.getState();
            if(state=="SUCCESS"){
               // alert("Delete succesfull");
            }
        })
        $A.enqueueAction(action);
        location.reload();
    },
    
    addNewCampaign: function(row,component,event,helper){
        var newRecord= row.Campaign_Name__c;
        alert(newRecord);
        var action = component.get("c.insertNewCampaign");
        action.setParams({
           // "The Insane Adventure";
            "recordName":newRecord
        })
        
        action.setCallback(this,function(a){
            var state = a.getState();
            
            if(state==="SUCCESS"){
               
               // alert("Submit succesful");
            }
            
        });
        $A.enqueueAction(action);
        location.reload();
    }
})
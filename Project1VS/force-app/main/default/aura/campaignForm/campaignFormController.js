({
    setColumnFields: function(component, event, helper) {
        helper.setColumnFields(component);
    },
    
    fetchCampaignsFromCurrentCharacter: function(component, event, helper) {
        helper.fetchCampaignsFromCurrentCharacter(component);
    },
    
    fetchJoinableCampaigns: function(component, event, helper) {
        helper.fetchJoinableCampaigns(component);
    },
    
    fetchOtherCampaigns: function(component, event, helper) {
        helper.fetchOtherCampaigns(component);
    },
            
    fetchCharacter: function(component, event, helper) {
		helper.fetchCharacter(component);
    },
            
    update: function(component, event, helper) {
		helper.update(component);
    },
    
    handleRowAction: function (component, event, helper) {
		helper.handleRowAction(component, event);
    }
})
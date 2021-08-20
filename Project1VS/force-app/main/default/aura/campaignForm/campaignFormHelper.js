({
    fetchCampaignsFromCurrentCharacter: function(component, event) {
        const fetchAction = component.get('c.fetchCurrentCharacterCampaigns');
        const self = this;
        
        fetchAction.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                const DnDCampaignWrappers = response.getReturnValue();
                const DnDCampaignColumnData = self.toColumnData(DnDCampaignWrappers);
                console.log(DnDCampaignColumnData);
                component.set('v.currentCampaigns', DnDCampaignColumnData);
            } else {
                console.error('failed');
            }
        });
        
        $A.enqueueAction(fetchAction);
    },
    
    setColumnFields: function(component) {
        const currentCampaignFields = [
            { label: 'Campaign Name', fieldName: 'campaignName', type: 'text' },
            { label: 'Status', fieldName: 'campaignStatus', type: 'text' },
            { label: 'Party', fieldName: 'partyName', type: 'text' },
            { label: 'Summary', fieldName: 'campaignSummary', type: 'text' },
            { label: 'Exit', type: 'button', initialWidth: 135, typeAttributes: { label: 'Exit', name: 'unjoin', title: 'exit'} }
        ];
        
        const joinableCampaignFields = [
            { label: 'Campaign Name', fieldName: 'campaignName', type: 'text' },
            { label: 'Status', fieldName: 'campaignStatus', type: 'text' },
            { label: 'Summary', fieldName: 'campaignSummary', type: 'text' },
            { label: 'Add Campaign', type: 'button', initialWidth: 135, typeAttributes: { label: 'Join', name: 'join', title: 'Join' } }            
        ];
        
        const unjoinableCampaignFields = [
            { label: 'Campaign Name', fieldName: 'campaignName', type: 'text' },
            { label: 'Status', fieldName: 'campaignStatus', type: 'text' },
            { label: 'Party', fieldName: 'partyName', type: 'text' },
            { label: 'Summary', fieldName: 'campaignSummary', type: 'text' }
        ];
        
        component.set('v.currentColumns', currentCampaignFields);
        component.set('v.joinableColumns', joinableCampaignFields);
        component.set('v.regularColumns', unjoinableCampaignFields);
    },
    
    
    fetchCurrentHelper: function(component, event, helper) {
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
    
    fetchJoinableCampaigns: function(component) {
        const fetchAction = component.get('c.fetchPartylessCampaigns');
        const self = this;
        fetchAction.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                const DnDCampaignWrappers = response.getReturnValue();
                const DnDCampaignColumnData = self.toColumnData(DnDCampaignWrappers);
                component.set('v.joinableCampaigns', DnDCampaignColumnData);
            }
        });
        $A.enqueueAction(fetchAction);        
    },
    
    fetchOtherCampaigns: function(component) {
        const fetchAction = component.get('c.fetchUnjoinableCampaigns');
        const self = this;
        fetchAction.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                const DnDCampaignWrappers = response.getReturnValue();
                const DnDCampaignColumnData = self.toColumnData(DnDCampaignWrappers);
                component.set('v.otherCampaigns', DnDCampaignColumnData);
            }
        });
        $A.enqueueAction(fetchAction);        
    },
    
    fetchCharacter: function(component) {
        const fetchAction = component.get('c.fetchCurrentUserCharacter');
        fetchAction.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                const character = response.getReturnValue();
                component.set('v.currentCharacter', character);
            } else {
                component.set('v.errorMessage', 'Failed to fetch default character');
            }
        });
        $A.enqueueAction(fetchAction);
    },
    
    deleteCampaign : function(row,component, event, helper){
        var action = component.get("c.removeUserPartyFromCampaign");
        
        var newRecord= row.campaignName;
        action.setParams({
            recordName: newRecord
        });
        
        action.setCallback(this,function(response){

            if(response.getState() === "SUCCESS") {
                const e = $A.get('e.c:updateCampaignFormEvent');
                e.fire();
            } else {
                component.set('v.errorMessage', 'Failed to remove user\'s party from campaign.');
            }
        })
        $A.enqueueAction(action);
    },
    
    addNewCampaign: function(row, component, event){
        const recordName = row.campaignName;
        const action = component.get("c.addUserPartyToCampaign");
        
        action.setParams({
            recordName: recordName
        });
        
        action.setCallback(this, function(response) {
            
            if(response.getState() === "SUCCESS") {
                // fire update event
                const e = $A.get('e.c:updateCampaignFormEvent');
                e.fire();
            } else {
                component.set('v.errorMessage', 'User must be in a party in order to add them to a campaign');
                console.error('failed');
            }
            
        });
        $A.enqueueAction(action);
    },
    
    toColumnData: function(DnDCampaignWrappers) {
        function wrapperToData(data) {
            return {
                campaignName: data.campaign.Campaign_Name__c,
                campaignStatus: data.campaign.Status__c,
                partyName: data.party.Name,
                campaignSummary: data.campaign.Summary__c,
            }
        }
        return DnDCampaignWrappers.map(wrapperToData);
    },
    
    update: function(component) {
        const fetchJoinableAction = component.get('c.fetchJoinableCampaigns');
        $A.enqueueAction(fetchJoinableAction);
        const fetchCurrentAction = component.get('c.fetchCampaignsFromCurrentCharacter');
        $A.enqueueAction(fetchCurrentAction);
        const fetchOtherAction = component.get('c.fetchOtherCampaigns');
        $A.enqueueAction(fetchOtherAction);
        const fetchCharacterAction = component.get('c.fetchCharacter');
        $A.enqueueAction(fetchCharacterAction);
    },
    
    handleRowAction: function(component, event) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        switch (action.name) {
            case 'view_details':
                this.showRowDetails(row);
                break;
                
            case 'join':
                this.addNewCampaign(row, component, event);
                break;
                
            case 'unjoin':
                this.deleteCampaign(row, component, event);
                break;
                
            default:
                // console.error('improper action attribute "name" [name=' + action.name ']');
                break;
        }
    }
})
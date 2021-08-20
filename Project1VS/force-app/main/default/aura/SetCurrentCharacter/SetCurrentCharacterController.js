({
	retrieveCurrentUserCharacters : function(component, event, helper) {
		const retrieveAction = component.get('c.retrieveCharacters');
        retrieveAction.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                component.set('v.userCharacters', response.getReturnValue());
            } else {
                component.set('v.userCharacters', [{Name: 'Failed to load characters', Id: null}]);
            }
        });
        $A.enqueueAction(retrieveAction);
	},
    setDefault: function(component, event, helper) {
        event.preventDefault();
        const charId = component.find("Character").get('v.value');
        
        const setAction = component.get('c.setCurrentCharacter');
        setAction.setParams({ 
            charId: charId
        });
        setAction.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                if(response.getReturnValue()) {
  					component.set('v.submittedSuccessfully', true);
                    // if this component is a sibling of the campaign form, update it
                    // if not - firing this event does nothing
                    const e = $A.get("e.c:updateCampaignFormEvent");
                    e.fire();
                } else {
                    component.set('v.errorMessage', 'Unable to update your default user at this time.');
                }
            } else {
                component.set('v.errorMessage', 'Unable to update your default user at this time.');
            }
        });
        $A.enqueueAction(setAction);
    }
})
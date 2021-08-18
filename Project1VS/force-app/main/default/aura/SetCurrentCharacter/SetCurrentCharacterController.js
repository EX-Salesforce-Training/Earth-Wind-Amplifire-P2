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
                } else {
                    component.set('v.errorMessage', 'Unable to update your default user at this time.');
                }
            } else {
                console.log('failure');
            }
        });
        $A.enqueueAction(setAction);
    }
})
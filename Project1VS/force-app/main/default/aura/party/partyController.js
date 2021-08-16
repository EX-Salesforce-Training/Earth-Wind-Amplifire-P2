({
	fillParties : function(component, event, helper) {
		let parties = component.get("c.getParties");
        parties.setCallback(this, function(response) {
            if (response.getState() === 'SUCCESS') {
                component.set("v.parties", response.getReturnValue());
            }
        })
        $A.enqueueAction(parties);
	},
    displayParty : function(cmp, event, helper) {
        let party = event.getSource().get("v.value");
        cmp.set("v.currentParty", party);
        let characters = cmp.get("c.getCharacters");
        characters.setParam("partyId", party.Id);
        characters.setCallback(this, function(response) {
            if (response.getState() === 'SUCCESS') {
                cmp.set("v.characters", response.getReturnValue());
            }
        })
        $A.enqueueAction(characters);
        let campaign = cmp.get("c.getCampaign");
        campaign.setParam("partyId", party.Id);
        campaign.setCallback(this, function(response) {
            if (response.getState() === 'SUCCESS') {
                cmp.set("v.campaigns", response.getReturnValue());
            }
        })
        $A.enqueueAction(campaign);
    },
    showRecord : function(cmp, event, helper) {
        let user = event.getSource().get("v.value");
        console.log('Value: ' + user);
        let navEvt = $A.get("e.force:navigateToSObject");
        console.log('nav: ' + navEvt);
        navEvt.setParams({
            "recordId": user
        });
        navEvt.fire();
    }
})
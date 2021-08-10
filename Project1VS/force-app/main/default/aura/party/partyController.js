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
                cmp.set("v.campaign", response.getReturnValue());
            }
        })
        $A.enqueueAction(campaign);
    }
})
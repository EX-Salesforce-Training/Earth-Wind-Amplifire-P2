({
	fetchCCHelper: function(component, event, helper) {
	   var action = component.get("c.fetchCurrentCampaigns");
        action.setParams({});
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.ccList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);	
	}
})
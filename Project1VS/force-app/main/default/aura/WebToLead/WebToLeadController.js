({
	submitForm : function(component, event, helper) {
        event.preventDefault();
        const data = helper.extractFormData(event.target);
        
        // set these values to defaults if needed
        if(data['state'] === undefined) data['state'] = 'N/A';
        if(data['city'] === undefined) data['city'] = 'N/A';
        if(data['company'] === undefined) data['company'] = 'N/A';
        
        let createLeadAction = component.get('c.createLead');
        createLeadAction.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
            	console.log(response.getReturnValue());
        	} else {
            	console.log('failed?', response.getReturnValue());                           
            }
                                       
        });
        createLeadAction.setParams(data);
        $A.enqueueAction(createLeadAction);
    },
    toggleLocation: function(component, event, helper) {
    	const showLocation = component.get("v.showLocation");
        component.set('v.showLocation', !showLocation);
	},
    toggleCompany: function(component, event, helper) {
    	const showCompany = component.get("v.showCompany");
        component.set('v.showCompany', !showCompany);
	}
})
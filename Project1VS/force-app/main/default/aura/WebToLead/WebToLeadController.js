({
	submitForm : function(component, event, helper) {
        event.preventDefault();
        const data = helper.extractFormData(event.target);
        
        // set these values to defaults if needed
        if(data['company'] === undefined) data['company'] = 'N/A';
        
        let createLeadAction = component.get('c.createLead');
        createLeadAction.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS") {
                let wasCreated = response.getReturnValue();
                component.set('v.submittedSuccessfully', wasCreated);
                if(!wasCreated) {
                    if(!/@.+\.(.+)/.test(data['email'])) {
                        component.set('v.errorMessage', 'Failed, invalid email address');
                    } else {
                        component.set('v.errorMessage', 'Failed, double-check your form submission');
                    }
                }
        	} else {
                component.set('v.errorMessage', 'Failed, unexpected server error')
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
	},
    closeModal: function(component, event, helper) {
        component.set('v.isOpen', false);
        component.set('v.errorMessage', '');
    }
})
({
    createSub: function(component, event, helper) {
        event.preventDefault();
        const createAction = component.get('c.createSubscriptionPlanForCurrentUser');

        const data = Array.from(new FormData(event.target).entries())
        .reduce((acc, [key, value]) => [acc[key] = value, acc][1], {});
        const params = { subscriptionName: data['createSubName'].split(' (')[0] };
        
        createAction.setParams(params);
        createAction.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                if(response.getReturnValue()) {
                	helper.toggleSuccessMessage(component, 'Success! You have created a new subscription.');
                } else {
                    helper.toggleErrorMessage(component, 'Error! Something went wrong.');
                }
            } else {
                helper.toggleErrorMessage(component, 'Error! Something went wrong.');
            }
        });
        
        $A.enqueueAction(createAction);
    },
    editSub: function(component, event, helper) {
        event.preventDefault();
        
        
        const createAction = component.get('c.editSubscriptionPlanForCurrentUser');
      	let subPlan = component.get('v.subPlan')
        const isCancelling = !subPlan.Cancelled_Subscription__c;
        const params = { isCancelling };
        
        createAction.setParams(params);
        createAction.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                if(response.getReturnValue()) {
                    helper.toggleSuccessMessage(component, 'Success! You have edited your subscription.');
                    subPlan.Cancelled_Subscription__c = isCancelling;
                    component.set('v.subPlan', subPlan);
                    
                } else {
					helper.toggleErrorMessage(component, 'Error! Something went wrong.');                    
                }
            } else {
                helper.toggleErrorMessage(component, 'Error! Something went wrong.');
            }
        });
        
        $A.enqueueAction(createAction);
    },
    // @desc : when a user first navigates to this page, retrieve their subscription info
    retrieveSubscriptionPlan: function(component, event, helper) {
    	const retrievalAction = component.get('c.retrieveCurrentUserSubPlan');
        retrievalAction.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                component.set('v.subPlan', response.getReturnValue());
            }
        });
        $A.enqueueAction(retrievalAction);
    },
    highlight: function(component, event, helper) {
        const btnElement = component.find(event.target.id);
        $A.util.addClass(btnElement, 'slds-button_brand');
        
        ['edit', 'create']
        .filter(id => id !== event.target.id)
        .forEach(id => $A.util.addClass(
            component.find(id), 
            $A.util.removeClass(
                component.find(id), 
                'slds-button_brand')));
        
        const tabElement = component.find(event.target.id + '-form');
        $A.util.removeClass(tabElement, 'is-hidden');
        ['edit-form', 'create-form']
        .filter(id => id !== event.target.id + '-form')
        .forEach(id => $A.util.addClass(
            component.find(id), 
            $A.util.addClass(
                component.find(id), 
                'is-hidden'))); 
    },
    closeErrorNotification: function(component, event, helper) {
        $A.util.addClass(component.find('error-notification'), 'is-hidden-notification');
    },
    closeSuccessNotification: function(component, event, helper) {
        $A.util.addClass(component.find('success-notification'), 'is-hidden-notification');
    },
})
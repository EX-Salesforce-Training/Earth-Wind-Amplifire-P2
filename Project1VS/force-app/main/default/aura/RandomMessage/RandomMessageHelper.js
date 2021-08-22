({
	setMessage : function(component) {
		const getMessageAction = component.get('c.getRandomMessage');
        getMessageAction.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS') {
                component.set('v.message', response.getReturnValue());
            }
        });
        $A.enqueueAction(getMessageAction);
	}
})
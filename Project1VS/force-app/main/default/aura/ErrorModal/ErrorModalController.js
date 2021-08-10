({
	closeModal : function(component, event, helper) {
        component.set('v.isOpen', false);
		component.getEvent('closeModal').fire();
	}
})
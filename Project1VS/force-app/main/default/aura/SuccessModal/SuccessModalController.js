({
	closeModal : function(component, event, helper) {
		const e = component.getEvent('closeModal');
        component.set('v.isOpen', false);
        e.fire();
	}
})
({
    toggleErrorMessage: function(component, message) {
        component.set('v.successMessage', message);
        const successElement = component.find('success-notification');
        $A.util.addClass(successElement, 'is-hidden-notification');
        
        component.set('v.errorMessage', message);
        const errorElement = component.find('error-notification');
        $A.util.removeClass(errorElement, 'is-hidden-notification');
    },
 
    toggleSuccessMessage: function(component, message) {
        component.set('v.errorMessage', message);
        const errorElement = component.find('error-notification');
        $A.util.addClass(errorElement, 'is-hidden-notification');
        
        component.set('v.successMessage', message);
        const successElement = component.find('success-notification');
        $A.util.removeClass(successElement, 'is-hidden-notification');
    }
})
({
    onChange: function (cmp, evt, helper) {
        alert(cmp.find('select').get('v.value') + ' pie is good.');
    },
    
    fetchUser : function(component, event, helper) {
        helper.fetchUsersHelper(component, event, helper);
    },
    
    handleClick : function (cmp, event, helper) {
		alert("button clicked");
       let user= cmp.find('select').get('v.value');
        
       helper.freezeUser(cmp,event,helper,user)
    }
    
});
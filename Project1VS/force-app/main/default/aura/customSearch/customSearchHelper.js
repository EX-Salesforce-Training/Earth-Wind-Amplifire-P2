({
	fetchUsersHelper : function(component, event, helper) {
	   var action = component.get("c.fetchUsers");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                
                console.log(response.getReturnValue());
                component.set("v.users", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);	
	},
    
    freezeUser : function(component, event, helper,user){
        var action = component.get("c.freezeUser");
        
        action.setParams({
            "user": user
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            
            if(state == "SUCCESS"){
                alert("Succesful");
            }
        });
			        
    $A.enqueueAction(action);	
  
    }
})
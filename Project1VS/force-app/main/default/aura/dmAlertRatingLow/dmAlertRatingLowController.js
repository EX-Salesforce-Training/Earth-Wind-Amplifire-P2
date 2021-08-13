({
    User: function(component, event, helper) {
        console.log("User");
        let userList = component.get("c.Users");
        userList.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                component.set("v.userList", response.getReturnValue());
                console.log(response.getReturnValue());
            }
            
        })
        $A.enqueueAction(userList);
    },
    
})
({
    PlayerUser: function(component, event, helper) {
        console.log("User");
        let PlayerList = component.get("c.usersPlayer");
        PlayerList.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                component.set("v.PlayerList", response.getReturnValue());
                console.log(response.getReturnValue());
            }
          
        })
        $A.enqueueAction(PlayerList);
    },
     DMUser: function(component, event, helper) {
        console.log("Userdm");
        let DMList = component.get("c.UsersDM");
        DMList.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                component.set("v.DMList", response.getReturnValue());
                console.log(response.getReturnValue());
            }
            
        })
        $A.enqueueAction(DMList);
    },
    userinfo: function(component, event, helper) {
        console.log("userinfo");
        let userinfo = component.get("c.UserInfo");
        userinfo.setCallback(this, function(response){
            let respMap = response.getReturnValue();
            if(response.getState() === "SUCCESS"){
                component.set("v.userinfo", response.getReturnValue());
            }
            console.log(respMap.User_Type__c +' here');
            if(respMap.User_Type__c != 'Player'){
                component.set("v.ishiddendm", false);
                component.set("v.isPlayer", false);
            }
            
        })
        $A.enqueueAction(userinfo);
    },
    	handleSuccess: function(component, event, helper) {
            console.log("fire");
        $A.get('e.force:refreshView').fire();
    },

})
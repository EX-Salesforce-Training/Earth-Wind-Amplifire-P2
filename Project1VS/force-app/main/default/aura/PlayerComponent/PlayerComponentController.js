({
    Party : function(component, event, helper) {
        console.log("party");
        let partyList = component.get("c.GetCharactersParty");
        partyList.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                component.set("v.partyList", response.getReturnValue());
            }
            
        })
        $A.enqueueAction(partyList);
    },
       User : function(component, event, helper) {
        console.log("user");
        let User = component.get("c.UserInfo");
        User.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                component.set("v.User", response.getReturnValue());
            }
            
        })
        $A.enqueueAction(User);
    },
     Race : function(component, event, helper) {
        console.log("Race");
        let rList = component.get("c.getRaceOptions");
         console.log(rList);
        rList.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                component.set("v.Race", response.getReturnValue());
                console.log(response.getReturnValue());
            }
            
        })
        $A.enqueueAction(rList);
    },
    toggleRaceTooltip : function(cmp, evt, hlp) {
        const tooltip = cmp.find('race-tooltip');
		$A.util.toggleClass(tooltip, "ishidden");
	},
    toggleAttributesTooltip : function(cmp, evt, hlp) {
        hlp.toggleTooltip(cmp, "attributes-tooltip");
	},
    toggleClassTooltip : function(cmp, evt, hlp) {
        hlp.toggleTooltip(cmp, "class-tooltip");
	},
    	save : function(component,event,helper){
        
        var action = component.get("c.apexSave"); 
        action.setCallback(this, function(action) {                
           $A.get('e.force:refreshView').fire(); 
        }); 
        $A.enqueueAction(action); 
    },

    /*page refresh after data save*/    
    isRefreshed: function(component, event, helper) {
        location.reload();
    },
    
    toggleCreateForm: function(component, event, helper) {
        const elem = component.find('create-form');
        $A.util.toggleClass(elem, 'ishidden');
    }
 })
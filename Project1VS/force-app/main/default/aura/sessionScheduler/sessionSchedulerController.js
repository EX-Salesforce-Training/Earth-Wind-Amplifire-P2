/*******************************************************************************
 *
 * Name: sessionSchedulerController
 * Author: Gregory Mannerberg (gregory.mannerberg@revature.net)
 * Created: 08/11/2021
 * Updated: 08/17/2021
 * Description: Client side controller for session scheduler
 *
 *******************************************************************************
 */
({
    // Get the list of the current user's d&d campaigns
	listCampaigns : function(component, event, helper) {
		let campaigns = component.get("c.getDnDCampaigns");
        campaigns.setCallback(this, function(response) {
            if (response.getState() === 'SUCCESS') {
                component.set("v.campaigns", response.getReturnValue());
            }
        })
        $A.enqueueAction(campaigns);
	},
    // Display the scheduling wizard
    showWizard : function(component, event, helper) {
        component.set("v.showList", false);
        component.set("v.showWizard", true);
        component.set("v.campaignId", event.getSource().get("v.value"));
    },
    // Return to the campaign list
    goBack : function(component, event, helper) {
        component.set("v.showList", true);
        component.set("v.showWizard", false);
    },
    // Submit the input data to the server to create the session event(s)
    submitSession : function(component, event, helper) {
        let session = component.get("c.addSession");
        session.setParams({whatId: component.get("v.campaignId"),
                           startTime: component.get("v.startTime"),
                           endTime: component.get("v.endTime"),
                           repeat: component.get("v.repeat"),
                           endRepeatDate: component.get("v.endRepeatDate"),
                           repeatType: component.get("v.repeatType"),
                           frequency: component.get("v.frequency"),
                           repeatDayOfWeek:component.get("v.repeatDayOfWeek"),
                           endType: component.get("v.endType"),
                           numRepeats: component.get("v.numRepeats"),
                           monthlyWhich: component.get("v.monthlyWhich"),
                           monthlyWhichDay: component.get("v.monthlyWhichDay"),
                           monthDay: component.get("v.monthDay")});
        session.setCallback(this, function(response) {
            if (response.getState() === 'SUCCESS') {
                component.set("v.showList", true);
                component.set("v.showWizard", false);
                let refresh = $A.get('e.force:navigateToURL');
                refresh.setParams({
                    "url": "/s/calendar"
                });
                refresh.fire();
                //$A.get('e.force:refreshView').fire();
            }
        })
        $A.enqueueAction(session);
    },
    // Display the repeat options on the wizard
    showRepeat : function(component, event, helper) {
        component.set("v.repeat",!component.get("v.repeat"));
        component.set("v.dailySelected", true);
        component.set("v.repeatType", "daily");
        component.set("v.frequency", 1);
        component.set("v.endType", "none");
    },
    // Display the daily repeat options
    showDailyOptions : function(component, event, helper) {
        component.set("v.dailySelected", true);
        component.set("v.weeklySelected", false);
        component.set("v.monthlySelected", false);
        component.set("v.yearlySelected", false);
        component.set("v.repeatType", "daily");
        component.set("v.frequency", 1);
        component.set("v.dailyExtra", false);
        component.set("v.endType", "none");
    },
    // Display the weekly repeat options
    showWeeklyOptions : function(component, event, helper) {
        component.set("v.dailySelected", false);
        component.set("v.weeklySelected", true);
        component.set("v.monthlySelected", false);
        component.set("v.yearlySelected", false);
        component.set("v.repeatType", "weekly");
        component.set("v.frequency", 1);
        component.set("v.weeklyExtra", false);
        component.set("v.endType", "none");
    },
    // Display the monthly repeat options
    showMonthlyOptions : function(component, event, helper) {
        component.set("v.dailySelected", false);
        component.set("v.weeklySelected", false);
        component.set("v.monthlySelected", true);
        component.set("v.yearlySelected", false);
        component.set("v.repeatType", "monthly");
        component.set("v.frequency", 1);
        component.set("v.monthlyExtra", false);
        component.set("v.monthlySpecific", true);
        component.set("v.monthlyWhich", "none");
        component.set("v.endType", "none");
    },
    // Display the yearly repeat options (Not added to component atm)
    showYearlyOptions : function(component, event, helper) {
        component.set("v.dailySelected", false);
        component.set("v.weeklySelected", false);
        component.set("v.monthlySelected", false);
        component.set("v.yearlySelected", true);
        component.set("v.repeatType", "yearly");
        component.set("v.frequency", 1);
        component.set("v.yearlyExtra", false);
        component.set("v.endType", "none");
    },
    // Handle a change in the daily dropdown menu
    dailyDropdown : function(component, event, helper) {
        let choice = event.getSource().get("v.value");
        if (choice == 3) {
            component.set("v.dailyExtra", true);
			component.set("v.frequency", 1);
        }
        else {
            component.set("v.dailyExtra", false);
            component.set("v.frequency", choice);
        }
    },
    // Handle a change in the daily extra dropdown menu
    dailyExtraDropdown : function(component, event, helper) {
        let choice = event.getSource().get("v.value");
        component.set("v.frequency", choice);
    },
    // Handle a change in the weekly dropdown menu
    weeklyDropdown : function(component, event, helper) {
        let choice = event.getSource().get("v.value");
        if (choice == 3) {
            component.set("v.weeklyExtra", true);
			component.set("v.frequency", 1);
        }
        else {
            component.set("v.weeklyExtra", false);
            component.set("v.frequency", choice);
        }
    },
    // Handle a change in the weekly extra dropdown menu
    weeklyExtraDropdown : function(component, event, helper) {
        let choice = event.getSource().get("v.value");
        component.set("v.frequency", choice);
    },
    addDay : function(component, event, helper) {
        let day = event.getSource().get("v.label");
        if (day == 'Su') {
            component.set("v.repeatDayOfWeek[0]", true);
        }
        else if (day == 'M') {
            component.set("v.repeatDayOfWeek[1]", true);
        }
        else if (day == 'Tu') {
            component.set("v.repeatDayOfWeek[2]", true);
        }
        else if (day == 'W') {
            component.set("v.repeatDayOfWeek[3]", true);
        }
        else if (day == 'Th') {
            component.set("v.repeatDayOfWeek[4]", true);
        }
        else if (day == 'F') {
            component.set("v.repeatDayOfWeek[5]", true);
        }
        else if (day == 'Sa') {
            component.set("v.repeatDayOfWeek[6]", true);
        }
    },
    removeDay : function(component, event, helper) {
		let day = event.getSource().get("v.label");
        if (day == 'Su') {
            component.set("v.repeatDayOfWeek[0]", false);
        }
        else if (day == 'M') {
            component.set("v.repeatDayOfWeek[1]", false);
        }
        else if (day == 'Tu') {
            component.set("v.repeatDayOfWeek[2]", false);
        }
        else if (day == 'W') {
            component.set("v.repeatDayOfWeek[3]", false);
        }
        else if (day == 'Th') {
            component.set("v.repeatDayOfWeek[4]", false);
        }
        else if (day == 'F') {
            component.set("v.repeatDayOfWeek[5]", false);
        }
        else if (day == 'Sa') {
            component.set("v.repeatDayOfWeek[6]", false);
        }    
    },
    // Handle a change in the monthly dropdown menu
    monthlyDropdown : function(component, event, helper) {
        let choice = event.getSource().get("v.value");
        if (choice == 3) {
            component.set("v.monthlyExtra", true);
			component.set("v.frequency", 1);
        }
        else {
            component.set("v.monthlyExtra", false);
            component.set("v.frequency", choice);
        }
    },
    // For selecting a specific day (1-31) of the month to repeat.
    // (Not used atm)
    monthlySpecific : function(component, event, helper) {
        let choice = event.getSource().get("v.value");
        if (choice == 1) {
            component.set("v.monthlySpecific", true);
            component.set("v.monthlyWhich", "none");
        }
        else {
            component.set("v.monthlySpecific", false);
            component.set("v.monthlyWhich", "first");
        }
    },
    // For selecting a specific day (1-31) of the month to repeat.
    // (Not used atm)
    monthlySpecificDropdown : function(component, event, helper) {
        let choice = event.getSource().get("v.value");
        component.set("v.monthDay", choice);
    },
    // Select a week (first, second, ..., last) to repeat on monthly
    // (Not used at the moment; monthlyWhich component value always
    // defaulting to none for right now)
    monthlyWhich : function(component, event, helper) {
        let choice = event.getSource().get("v.value");
        component.set("v.monthlyWhich", choice);
    },
    // Select a day of the week to repeat on monthly (Not used atm)
    monthlyWhichDay : function(component, event, helper) {
        let choice = event.getSource().get("v.value");
        component.set("v.monthlyWhichDay", choice);
    },
    // Handle a change in the monthly extra dropdown menu
    monthlyExtraDropdown : function(component, event, helper) {
        let choice = event.getSource().get("v.value");
        component.set("v.frequency", choice);
    }
})
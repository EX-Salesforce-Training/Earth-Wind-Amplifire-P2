/*
Author: Zackary Frazier
Last Modified Project: Project 2
Created Project: Project 2 
Desc:
  controller for the webtolead page
*/

public class WebToLeadController {
	
    // @desc : create a new lead for a customer
    @AuraEnabled
    public static Boolean createLead(String first_name, String last_name, String email, String city, String state, String company) {
        
        Lead ld = new Lead(
            FirstName=first_name,
            LastName=last_name,
            Email=email,
            City=city,
            State=state,
            Company=company
        );
        
        try {
            insert ld;
            return true;
        } catch(DMLException e) {
            System.debug(e);
        	return false;
        } catch(Exception e) {
            System.debug(e);
            return false;
        }
    }
}
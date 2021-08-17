/*******************************************************************************
 *
 * Name: partyController 
 * Author: Gregory Mannerberg (gregory.mannerberg@revature.net)
 * Created: 08/9/2021
 * Updated: 08/17/2021
 * Description: Retrieve party, character, and campaign information for the
 * 				party page.
 *
 *******************************************************************************
 */
public with sharing class partyController {

    // Return a list of parties for which the user has record level access
    @AuraEnabled
    public static List<Party__c> getParties() {
        return [SELECT Id, Name FROM Party__c];
    }
    
    // Get the characters and users associated with a given party
    @AuraEnabled
    public static List<Character__c> getCharacters(Id partyId) {
        return [SELECT User__r.Name, Name FROM Character__c WHERE Party__c = :partyId];
    }
    
    // Get the dungeon master and d&d campaign associated with a given party
    @AuraEnabled
    public static List<DnDCampaign__c> getCampaign(Id partyId) {
        return [SELECT Dungeon_Master__r.Name, Campaign_Name__c FROM DnDCampaign__c WHERE Party__c = :partyId];
    }
}
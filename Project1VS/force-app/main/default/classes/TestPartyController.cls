/*
Author: Zackary Frazier
Last Modified Project: Project 2
Created Project: Project 2 
Desc:
  test the party controller
*/

@isTest
public class TestPartyController {
	@testSetup
    public static void setup() {
        Party__c party = new Party__c();
        insert party;
    }
    
    @isTest
    public static void testGetParties() {
        System.assertEquals(1, partyController.getParties().size());
    }
    
    @isTest
    public static void testGetCharacters() {
        Party__c party = [SELECT Id FROM Party__c];
        try {
            List<Character__c> chars = partyController.getCharacters(party.Id);
            System.assertEquals(0, chars.size());
        } catch(Exception e) {
            System.assert(false);
        }
    }
    
    @isTest
    public static void testGetCampaign() {
        Party__c party = [SELECT Id FROM Party__c];
        try {
            List<DnDCampaign__c> campaigns = partyController.getCampaign(party.Id);
            System.assertEquals(0, campaigns.size());
        } catch(Exception e) {
            System.assert(false);
        }
    }
    
}
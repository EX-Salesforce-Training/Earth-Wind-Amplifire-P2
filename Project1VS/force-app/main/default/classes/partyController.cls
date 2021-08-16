public with sharing class partyController {

    @AuraEnabled
    public static List<Party__c> getParties() {
        return [SELECT Id, Name FROM Party__c];
    }
    
    @AuraEnabled
    public static List<Character__c> getCharacters(Id partyId) {
        return [SELECT User__r.Name, Name FROM Character__c WHERE Party__c = :partyId];
    }
    
    @AuraEnabled
    public static List<DnDCampaign__c> getCampaign(Id partyId) {
        return [SELECT Dungeon_Master__r.Name, Campaign_Name__c FROM DnDCampaign__c WHERE Party__c = :partyId];
    }
}
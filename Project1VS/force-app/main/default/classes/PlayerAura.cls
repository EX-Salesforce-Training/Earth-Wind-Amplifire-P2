// apex class for getting the info needed to display on the lwc from player page
public class PlayerAura {
    
    //grab user info
    @AuraEnabled
    public static User UserInfo(){
        User info = [SELECT Id, Name, Username, Email, ContactId, Contact.Region__c FROM User WHERE Id=:userinfo.getuserId()];
        return info;
    }
    
    // grab character list and relatedparty
    @AuraEnabled
    public static List<Character__c> GetCharactersParty() {
        List<character__c> characterList = [SELECT Id, Name, Party__r.Name FROM Character__c WHERE OwnerID =:userinfo.getuserId() ];
        system.debug(characterList);
        return characterList;
    }
    // get race options for character creation
    @AuraEnabled
    public static List<String> getRaceOptions(){
        List<String> raceList = restingDragonController.indexList('races/');
        system.debug(raceList);
        return raceList;
    }
}
// Author: Zackary Frazier
// Desc:
//   controller for the SetCurrentCharacter Lightning component

public class SetCurrentCharacterController {
	
    // @desc : set the current character of the current user
    @AuraEnabled
    public static Boolean setCurrentCharacter(String charId) {
        
        List<Character__c> chars =	[SELECT Id FROM Character__c WHERE Id = :charId];
        if(chars.size() == 0) {
            return false;
        } else if(chars.size() != 1) {
            System.debug('Failed charId: ' + charId);
            System.debug('Failed chars: ' + chars);
            return false;
        }
        
        User u;
        try {
        	u = [SELECT Current_Character_ID__c FROM User WHERE Id = :UserInfo.getUserId()];
        	u.Current_Character_Id__c = charId;
        } catch(Exception e) {
            System.debug('Failed to retrieve user');
            return false;
        }
        
        try {
            update u;
            return true;
        } catch(Exception e) {
            System.debug('Failed to update charId: ' + charId);
            return false;
        }
    }
    
    // @desc : set the current character of the current user
    @AuraEnabled
    public static List<Character__c> retrieveCharacters() {
        List<Character__c> userChars = [SELECT Id, Name FROM Character__c WHERE User__c = :UserInfo.getUserId()];
    	System.debug(userChars);
        return userChars;
    }
}
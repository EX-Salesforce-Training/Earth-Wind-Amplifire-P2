public class playerAlertAura {
	
    // take users to get displayed
    @AuraEnabled
    public static List<User> usersPlayer(){
        List<User> userListPlayer = [SELECT Id, name, User_Rating__c, User_Type__c FROM USER WHERE User_Rating__c != null AND User_Type__c = 'Player'];
        system.debug(userListPlayer);
        return userListPlayer;
    }
    // take users to get displayed
    @AuraEnabled
    public static List<User> UsersDM(){
        List<User> userListDM = [SELECT Id, name, User_Rating__c, User_Type__c FROM USER WHERE User_Rating__c != null AND User_Type__c = 'DM' ];
        system.debug(userListDM);
        return userListDM;
    }
    //grab user info
    @AuraEnabled
    public static User UserInfo(){
        User info = [SELECT Id, Name, User_Type__c FROM User WHERE Id=:userinfo.getuserId()];
        return info;
    }
}
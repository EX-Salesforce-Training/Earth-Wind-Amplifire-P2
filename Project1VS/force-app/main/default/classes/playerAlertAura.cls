public class playerAlertAura {
	
    // take users to get displayed
    @AuraEnabled
    public static List<User> Users(){
        List<User> userList = [SELECT Id, name, User_Rating__c FROM USER WHERE User_Rating__c != null];
        system.debug(userList);
        return userList;
    }
}
public class AccountController{
    @AuraEnabled
    public static List <DndCampaign__c> fetchCampaigns() {
        //Qyery 10 accounts
        Character__c userChar = [SELECT Party__c FROM Character__c WHERE User__c = :UserInfo.getUserId()];
        List<DndCampaign__c> ccList = [SELECT  Name,Status__c,Party__c,Dungeon_Master__c,Campaign_Name__c,Summary__C from DndCampaign__c WHERE Party__c != :userChar.Party__c];
        //return list of accounts
        return ccList;
    }
    
    @AuraEnabled
    public static List <User> fetchUsers(){
        List<User> usersList = [SELECT Name from User];
        system.debug(usersList);
        return usersList;
    } 
    
    
   
    @AuraEnabled
     public static List <DndCampaign__c> fetchCurrentCampaigns() {
         //Qyery 10 accounts
         String id= UserInfo.getUserId();
         Character__c userChar = [SELECT Party__c FROM Character__c WHERE User__c = :UserInfo.getUserId()];
         List<DndCampaign__c> currentList = [SELECT  Name,Status__c,Party__c,Dungeon_Master__c,Campaign_Name__c,Summary__C FROM DndCampaign__c WHERE Party__c=:userChar.Party__c];
         //return list of accounts
         return currentList;
    }
    
    
    @AuraEnabled
    public static void insertNewCampaign(String recordName) {
        Character__c userChar = [SELECT Party__c FROM Character__c WHERE User__c = :UserInfo.getUserId()];
        DndCampaign__c newRecord= [SELECT Party__c FROM DndCampaign__c where campaign_Name__C=:recordName];
        newRecord.Party__c = userChar.Party__c;
        
        // UPDATE 
        update newRecord;
    }
    
    
    
    
    @AuraEnabled 
    public static void deleteCampaign(String recordName){
        Character__c userChar = [SELECT Party__c FROM Character__c WHERE User__c = :UserInfo.getUserId()];
        DndCampaign__c newRecord =[SELECT Party__c FROM DndCampaign__C where campaign_Name__c=:recordName AND Party__c=:userChar.Party__c];
        newRecord.Party__c = null;
       
        
        update newRecord;
    }
}
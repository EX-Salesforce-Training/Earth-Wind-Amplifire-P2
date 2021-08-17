public class AccountController{
    @AuraEnabled
    public static List <DndCampaign__c> fetchCampaigns() {
        //Qyery 10 accounts
        List<DndCampaign__c> ccList = [SELECT  Name,Status__c,Party__c,Dungeon_Master__c,Campaign_Name__c,Summary__C from DndCampaign__c WHERE Status__C='New'];
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
    public static void freezeUser(String userName){
        
        User userObject = [SELECT Name, Rating__c from User where Name=:userName];
        userObject.Rating__c='Low';
        
        insert userObject;
    }
    
    
    @AuraEnabled
     public static List <DndCampaign__c> fetchCurrentCampaigns() {
        //Qyery 10 accounts
        String id= UserInfo.getUserId();
        List<DndCampaign__c> currentList = [SELECT  Name,Status__c,Party__c,Dungeon_Master__c,Campaign_Name__c,Summary__C FROM DndCampaign__c WHERE Status__c='In Progress'];
        //return list of accounts
        return currentList;
    }
    
    
    @AuraEnabled
    public static void insertNewCampaign(String recordName){
        DndCampaign__c newRecord= [SELECT Status__c, Name FROM DndCampaign__c where campaign_Name__C=:recordName];
        
        newRecord.Status__c='In Progress';
       // newRecord.OwnerId=UserInfo.getUserId();
        
      // UPDATE 
      update newRecord;
    }
    
    
    
    
    @AuraEnabled 
    public static void deleteCampaign(String recordName){
       DndCampaign__c newRecord =[SELECT Name FROM DndCampaign__C where campaign_Name__C=:recordName];
       // Id id=0;
        newRecord.Status__c='New';
      //  newRecord.OwnerId='';
        
        update newRecord;
    }
}
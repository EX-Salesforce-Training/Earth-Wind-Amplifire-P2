public class AccountController{
    
    
    @AuraEnabled
    public static Character__c fetchCurrentUserCharacter() {
        User u = [SELECT Current_Character_Id__c 
                  FROM User 
                  WHERE Id = :UserInfo.getUserId()];
        Character__c userChar;
        try {
            userChar = [SELECT Name 
                        FROM Character__c 
                        WHERE Id = :u.Current_Character_Id__c];
        } catch(QueryException e) {
            userChar = null;
        }
        return userChar;
    }
    
    // @desc : this function add a user's default character's party to a campaign
    @AuraEnabled
    public static void addUserPartyToCampaign(String recordName) {
        User u = [SELECT Current_Character_Id__c FROM User WHERE Id = :UserInfo.getUserId()];
        Character__c userChar = [SELECT Party__c FROM Character__c WHERE Id = :u.Current_Character_Id__c];
        if(userChar.Party__c == null) {
        	throw new NullPartyException('Character must be in a party to add them to a campaign.');    
        }
        System.debug(recordName);
        DndCampaign__c campaign = [SELECT Party__c FROM DndCampaign__c WHERE campaign_Name__C = :recordName];
        campaign.Party__c = userChar.Party__c;

        // UPDATE 
        update campaign;
    }
    
    
    
    // @desc : this method removes a user's default character's party from a campaign
    @AuraEnabled 
    public static void removeUserPartyFromCampaign(String recordName){
        User u = [SELECT Current_Character_Id__c FROM User WHERE Id = :UserInfo.getUserId()];
        if(u.Current_Character_Id__c == '') {
            throw new DefaultCharacterException('User does not have a default character selected.');
        }
        
        Character__c userChar = [SELECT Party__c 
                                 FROM Character__c 
                                 WHERE Id = :u.Current_Character_Id__c];
 		
        if(userChar.Party__c == null) {
            throw new NullPartyException('Cannot remove a partyless character from a campaign.');
        }
        
        DndCampaign__c campaign = [SELECT Party__c 
                                   FROM DndCampaign__C 
                                   WHERE campaign_Name__c = :recordName 
                                   AND Party__c = :userChar.Party__c];
       	campaign.Party__c = null;
       
        update campaign;
    }
    
    @AuraEnabled
    public static List<AccountController.DnDCampaignWrapper> fetchUnjoinableCampaigns() {
        User u = [SELECT Current_Character_Id__c FROM User WHERE Id = :UserInfo.getUserId()];
        
        Character__c character = [SELECT Party__c FROM Character__c WHERE Id = :u.Current_Character_Id__c];
        
        String partyId = character.Party__c;

        List<AccountController.DnDCampaignWrapper> campaignWrappers = new List<AccountController.DnDCampaignWrapper>();
        for(DnDCampaign__c campaign: [SELECT Name, Status__c, Party__c, Party__r.Name, Dungeon_Master__c, Campaign_Name__c, Summary__C FROM DnDCampaign__c WHERE Party__c != NULL AND Party__c != :partyId]) {
            AccountController.DnDCampaignWrapper campaignWrapper = new AccountController.DnDCampaignWrapper(campaign);
            campaignWrappers.add(campaignWrapper);
        }
        return campaignWrappers;
    }
    
    @AuraEnabled
    public static List<AccountController.DnDCampaignWrapper> fetchCurrentCharacterCampaigns() {
        User u = [SELECT Current_Character_Id__c FROM User WHERE Id = :UserInfo.getUserId()];
        Character__c character = [SELECT Party__r.Name, Party__c FROM Character__c WHERE Id = :u.Current_Character_Id__c];
        
        String partyId = character.Party__c;
        
        // edge-case
        if(partyId == null) {
            return new List<AccountController.DnDCampaignWrapper>();
        }
        
        List<AccountController.DnDCampaignWrapper> campaignWrappers = new List<AccountController.DnDCampaignWrapper>();
        for(DnDCampaign__c campaign: [SELECT Name, Status__c, Party__r.Name, Party__c, Dungeon_Master__c, Campaign_Name__c, Summary__C FROM DnDCampaign__c WHERE Party__c = :partyId ]) {
            AccountController.DnDCampaignWrapper campaignWrapper = new AccountController.DnDCampaignWrapper(campaign);
            campaignWrappers.add(campaignWrapper);
        }
        return campaignWrappers;
    }
    
    // @desc: fetches all joinable campaigns, returns empty if user has no default character
    // 		  i.e. if the user has no default character, none are joinable 
    @AuraEnabled
    public static List<AccountController.DnDCampaignWrapper> fetchPartylessCampaigns() {
        User u = [SELECT Current_Character_Id__c FROM User WHERE Id = :UserInfo.getUserId()];
        
        if(u.Current_Character_Id__c == null) {
            return new List<AccountController.DnDCampaignWrapper>();
        }
        Character__c character = [SELECT Party__c 
                                  FROM Character__c 
                                  WHERE Id = :u.Current_Character_Id__c];
        if(character.Party__c == null) {
            return new List<AccountController.DnDCampaignWrapper>();
        }
        
        List<AccountController.DnDCampaignWrapper> campaignWrappers = new List<AccountController.DnDCampaignWrapper>();
        for(DndCampaign__c campaign: [SELECT Name, Status__c, Party__c, Dungeon_Master__c, Campaign_Name__c, Summary__C FROM DnDCampaign__c WHERE Party__c = NULL ]) {
            AccountController.DnDCampaignWrapper campaignWrapper = new AccountController.DnDCampaignWrapper(campaign);
            campaignWrappers.add(campaignWrapper);
        }
        return campaignWrappers;
    }
    
    public class DnDCampaignWrapper {
        @AuraEnabled
        public Party__c party;
        
        @AuraEnabled
        public DnDCampaign__c campaign;
        
        public DnDCampaignWrapper(DnDCampaign__c campaign) {
            this.Party = new Party__c();
            try {
                this.Party.Name = campaign.Party__r.Name;
            } catch(Exception e) {
                // do nothing, just means that the campaign has no party data
            }
            this.campaign = campaign;
        }
    }
}
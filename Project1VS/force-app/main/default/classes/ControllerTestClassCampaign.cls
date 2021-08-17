@isTest
private class ControllerTestClassCampaign {
	 
     @isTest
     static void fetchAllCampaignsTest() 
	 {
        
         
       
       DndCampaign__c[] campaigns = AccountController.fetchCampaigns();
       DnDCampaign__c[] testcampaigns = [select name from DnDCampaign__C where Status__c='New'];
         
         system.assertEquals(campaigns,testcampaigns);
         
     }
    
    @isTest
    static void fetchAllCurrentCampaigns()
    {
        DndCampaign__C[] campaigns = AccountController.fetchCurrentCampaigns();
        DndCampaign__c[] testCampaigns=[select name from DndCampaign__C where status__C='In Progress'];
        
        system.assertEquals(campaigns,testCampaigns);
        
    }
    
    @isTest
    static void addProgressToCampaign(){
        DndCampaign__C testcc = new DndCampaign__c(); 
        testcc.Campaign_Name__c='test';
        testcc.Status__c='New';
        
        insert testcc;
        
        Test.startTest();
        AccountController.insertNewCampaign(testcc.Campaign_Name__c);
        
        System.assertEquals(testcc.Status__c,'In Progress');
        Test.stopTest();
        
        
    }
    
}
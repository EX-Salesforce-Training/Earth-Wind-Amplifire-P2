public class DndCampaignController {
    public DndCampaignController(){}
    public List<DnDCampaign__c> campList {get;set;}
    public DnDCampaign__c curCamp{get; set;}
    public DndCampaignController(ApexPages.StandardController sc){
        campList = [SELECT Name, Id from DnDCampaign__c];
        try {
        	curCamp = [SELECT Id, Name, Dungeon_Master__c, Party__c, Status__c From DnDCampaign__c Where Status__c = 'In Progress'];
        } catch(Exception e) {
        	curCamp = new DnDCampaign__c();    
        }
    }
    
    public PageReference GoToParty(){
         PageReference p = new PageReference('/apex/partyPage');
       	 p.setRedirect(true);
        return p; 
    }
}
public class CreateCampaignController {
	
    @AuraEnabled
    public static void uploadImage(String recordId, String imgSrc) {
        DnDCampaign__c campaign = [SELECT Campaign_Image__c FROM DnDCampaign__c WHERE Id = :recordId];
        campaign.Campaign_Image__c = imgSrc;
        update campaign;
    }
}
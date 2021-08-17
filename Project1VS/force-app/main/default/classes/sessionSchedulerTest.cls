@isTest
private class sessionSchedulerTest {

    private static void setup() {
        Party__c party = new Party__c();
        insert party;
        party = [SELECT Id FROM Party__c LIMIT 1];
        DnDCampaign__c campaign = new DndCampaign__c();
        campaign.Dungeon_Master__c = System.UserInfo.getUserId();
        campaign.Party__c = party.Id;
        campaign.Campaign_Name__c = 'test campaign';
        insert campaign;
    }
    
    @isTest
    static void testGetDnDCampaignsSingle() {
        setup();
        List<DnDCampaign__c> campList = sessionScheduler.getDnDCampaigns();
        System.assertEquals(1, campList.size());
        System.assertEquals('test campaign', campList[0].Campaign_Name__c);
    }
    
    @isTest
    static void testaddSessionSingle() {
        setup();
        DnDCampaign__c campaign = [SELECT Id FROM DnDCampaign__c LIMIT 1];
        Datetime startTime = Datetime.now().addHours(1);
        Datetime endTime = startTime.addHours(2);
        sessionScheduler.addSession(campaign.Id, startTime, endTime, false, null, null, null, null, null, null, null, null, null);
        Event e = [SELECT WhatId, StartDateTime, EndDateTime FROM Event LIMIT 1];
        System.assert(e != null);
        System.assertEquals(campaign.Id, e.WhatId);
        System.assertEquals(startTime, e.StartDateTime);
        System.assertEquals(endTime, e.EndDateTime);
    }
    
    @isTest
    static void testRepeatingEvent() {
        setup();
        DnDCampaign__c campaign = [SELECT Id FROM DnDCampaign__c LIMIT 1];
        Datetime startTime = Datetime.now().addHours(1);
        Datetime endTime = startTime.addHours(2);
        Date endRepeatDate = startTime.date().addDays(14);
        sessionScheduler.addSession(campaign.Id, startTime, endTime, true, endRepeatDate, 'weekly', 1, new List<Boolean>{true, false, false, false, false, false, false}, 'on', null, null, null, null);
        List<Event> sessions = [SELECT WhatId, StartDateTime, EndDateTime FROM Event];
        System.assertEquals(3, sessions.size());
    }
}
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
    static void testRepeatingDayNoneEvent() {
        setup();
        DnDCampaign__c campaign = [SELECT Id FROM DnDCampaign__c LIMIT 1];
        Datetime startTime = Datetime.now().addHours(1);
        Datetime endTime = startTime.addHours(2);
        sessionScheduler.addSession(campaign.Id, startTime, endTime, true, null, 'daily', 1, null, 'none', null, null, null, null);
        List<Event> sessions = [SELECT WhatId, StartDateTime, EndDateTime FROM Event];
        System.assertEquals(366, sessions.size());
    }
    
    @isTest
    static void testRepeatingDayOnEvent() {
        setup();
        DnDCampaign__c campaign = [SELECT Id FROM DnDCampaign__c LIMIT 1];
        Datetime startTime = Datetime.now().addHours(1);
        Datetime endTime = startTime.addHours(2);
        Date endRepeatDate = startTime.date().addDays(14);
        sessionScheduler.addSession(campaign.Id, startTime, endTime, true, endRepeatDate, 'daily', 1, null, 'on', null, null, null, null);
        List<Event> sessions = [SELECT WhatId, StartDateTime, EndDateTime FROM Event];
        System.assertEquals(15, sessions.size());
    }
    
    @isTest
    static void testRepeatingDayAfterEvent() {
        setup();
        DnDCampaign__c campaign = [SELECT Id FROM DnDCampaign__c LIMIT 1];
        Datetime startTime = Datetime.now().addHours(1);
        Datetime endTime = startTime.addHours(2);
        Integer numRepeats = 10;
        sessionScheduler.addSession(campaign.Id, startTime, endTime, true, null, 'daily', 1, null, 'after', numRepeats, null, null, null);
        List<Event> sessions = [SELECT WhatId, StartDateTime, EndDateTime FROM Event];
        System.assertEquals(11, sessions.size());
    }
    
    @isTest
    static void testRepeatingWeekNoneEvent() {
        setup();
        DnDCampaign__c campaign = [SELECT Id FROM DnDCampaign__c LIMIT 1];
        Datetime startTime = Datetime.now().addHours(1);
        Datetime endTime = startTime.addHours(2);
        sessionScheduler.addSession(campaign.Id, startTime, endTime, true, null, 'weekly', 1, new List<Boolean>{true, false, false, false, false, false, false}, 'none', null, null, null, null);
        List<Event> sessions = [SELECT WhatId, StartDateTime, EndDateTime FROM Event];
        System.assertEquals(53, sessions.size());
    }
    
    @isTest
    static void testRepeatingWeekAfterEvent() {
        setup();
        DnDCampaign__c campaign = [SELECT Id FROM DnDCampaign__c LIMIT 1];
        Datetime startTime = Datetime.now().addHours(1);
        Datetime endTime = startTime.addHours(2);
        sessionScheduler.addSession(campaign.Id, startTime, endTime, true, null, 'weekly', 1, new List<Boolean>{true, false, false, false, false, false, false}, 'after', 3, null, null, null);
        List<Event> sessions = [SELECT WhatId, StartDateTime, EndDateTime FROM Event];
        System.assertEquals(4, sessions.size());
    }
    
    @isTest
    static void testRepeatingWeekOnEvent() {
        setup();
        DnDCampaign__c campaign = [SELECT Id FROM DnDCampaign__c LIMIT 1];
        Datetime startTime = Datetime.now().addHours(1);
        Datetime endTime = startTime.addHours(2);
        Date endRepeatDate = startTime.date().addDays(14);
        sessionScheduler.addSession(campaign.Id, startTime, endTime, true, endRepeatDate, 'weekly', 1, new List<Boolean>{true, false, false, false, false, false, false}, 'on', null, null, null, null);
        List<Event> sessions = [SELECT WhatId, StartDateTime, EndDateTime FROM Event];
        System.assertEquals(3, sessions.size());
    }
    
    @isTest
    static void testRepeatingMonthNoneEvent() {
        setup();
        DnDCampaign__c campaign = [SELECT Id FROM DnDCampaign__c LIMIT 1];
        Datetime startTime = Datetime.now().addHours(1);
        Datetime endTime = startTime.addHours(2);
        sessionScheduler.addSession(campaign.Id, startTime, endTime, true, null, 'monthly', 1, null, 'none', null, 'none', null, null);
        List<Event> sessions = [SELECT WhatId, StartDateTime, EndDateTime FROM Event];
        System.assertEquals(13, sessions.size());
    }
    
    @isTest
    static void testRepeatingMonthAfterEvent() {
        setup();
        DnDCampaign__c campaign = [SELECT Id FROM DnDCampaign__c LIMIT 1];
        Datetime startTime = Datetime.now().addHours(1);
        Datetime endTime = startTime.addHours(2);
        sessionScheduler.addSession(campaign.Id, startTime, endTime, true, null, 'monthly', 1, null, 'after', 4, 'none', null, null);
        List<Event> sessions = [SELECT WhatId, StartDateTime, EndDateTime FROM Event];
        System.assertEquals(5, sessions.size());
    }
    
    @isTest
    static void testRepeatingMonthOnEvent() {
        setup();
        DnDCampaign__c campaign = [SELECT Id FROM DnDCampaign__c LIMIT 1];
        Datetime startTime = Datetime.now().addHours(1);
        Datetime endTime = startTime.addHours(2);
        Date endRepeatDate = startTime.date().addMonths(4);
        sessionScheduler.addSession(campaign.Id, startTime, endTime, true, endRepeatDate, 'monthly', 1, null, 'on', null, 'none', null, null);
        List<Event> sessions = [SELECT WhatId, StartDateTime, EndDateTime FROM Event];
        System.assertEquals(5, sessions.size());
    }
}
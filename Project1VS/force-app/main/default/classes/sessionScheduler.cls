/**************************************************************************
 *
 * Name: sessionScheduler
 * Author: Gregory Mannerberg (gregory.mannerberg@revature.net)
 * Created: 8/11/2021
 * Updated: 08/17/2021
 * Description: Handles scheduling a session for a DnDCampaign
 *
 **************************************************************************
 */
public with sharing class sessionScheduler {

    // Gets all of the current user's d&d campaigns
    @AuraEnabled
    public static List<DnDCampaign__c> getDnDCampaigns() {
        Id userId = System.UserInfo.getUserId();
        List<DnDCampaign__c> campaigns = [SELECT Id, Campaign_Name__c FROM DnDCampaign__c WHERE Dungeon_Master__c = :userId];
        return campaigns;
    }
    
    // Creates calendar events for a d&d sessions
    @AuraEnabled
    public static String addSession(Id whatId, Datetime startTime, Datetime endTime, Boolean repeat, Date endRepeatDate, String repeatType, Integer frequency,
                                    List<Boolean> repeatDayOfWeek, String endType, Integer numRepeats, String monthlyWhich, String monthlyWhichDay, Integer monthDay) {
        List<Event> sessions = new List<Event>();
        Event e = new Event();
        e.OwnerId = System.UserInfo.getUserId();
        e.WhatId = whatId;
        e.StartDateTime = startTime;
        e.EndDateTime = endTime;
        sessions.add(e);
        if (repeat) {
            if (repeatType == 'daily') {
                if (endType == 'none') {
                    endRepeatDate = startTime.date().addYears(1);
                    for (Date scheduleDate = startTime.date().addDays(frequency); scheduleDate <= endRepeatDate; scheduleDate = scheduleDate.addDays(frequency)) {
                        Event session = new Event();
                        session.OwnerId = System.UserInfo.getUserId();
                        session.WhatId = whatId;
                        Datetime scheduledStart = Datetime.newInstance(scheduleDate, startTime.time());
                        session.StartDateTime = scheduledStart;
                        session.EndDateTime = scheduledStart.addSeconds((Integer)((endTime.getTime() - startTime.getTime())/1000));
                        sessions.add(session);
                    }
                }
                else if (endType == 'after') {
                    Date scheduleDate = startTime.date();
                    for (Integer i=0; i<numRepeats; i++) {
                        scheduleDate = scheduleDate.addDays(frequency);
                        Event session = new Event();
                        session.OwnerId = System.UserInfo.getUserId();
                        session.WhatId = whatId;
                        Datetime scheduledStart = Datetime.newInstance(scheduleDate, startTime.time());
                        session.StartDateTime = scheduledStart;
                        session.EndDateTime = scheduledStart.addSeconds((Integer)((endTime.getTime() - startTime.getTime())/1000));
                        sessions.add(session);
                    }
                }
                else if (endType == 'on') {
                    for (Date scheduleDate = startTime.date().addDays(frequency); scheduleDate <= endRepeatDate; scheduleDate = scheduleDate.addDays(frequency)) {
                        Event session = new Event();
                        session.OwnerId = System.UserInfo.getUserId();
                        session.WhatId = whatId;
                        Datetime scheduledStart = Datetime.newInstance(scheduleDate, startTime.time());
                        session.StartDateTime = scheduledStart;
                        session.EndDateTime = scheduledStart.addSeconds((Integer)((endTime.getTime() - startTime.getTime())/1000));
                        sessions.add(session);
                    }                    
                }
            }
            else if (repeatType == 'weekly') {
                if (endType == 'none') {
                    endRepeatDate = startTime.date().addYears(1);
                    Date scheduleDate = startTime.date().addDays(1);
                    Integer i = 1;
                    while (scheduleDate <= endRepeatDate) {
                        Datetime scheduledStart = Datetime.newInstance(scheduleDate, startTime.time());
                        if (repeatDayOfWeek[Math.mod(Integer.valueOf(scheduledStart.format('u')),7)]) {
                            Event session = new Event();
                            session.OwnerId = System.UserInfo.getUserId();
                            session.WhatId = whatId;                           
                            session.StartDateTime = scheduledStart;
                            session.EndDateTime = scheduledStart.addSeconds((Integer)((endTime.getTime() - startTime.getTime())/1000));
                            sessions.add(session);
                        }
                        i++;
                        scheduleDate = scheduleDate.addDays(1);
                        if (i == 7) {
                            i = 0;
                            scheduleDate = scheduleDate.addDays(7*(frequency-1));
                        }                                               
                    }
                }
                else if (endType == 'after') {
                    Date scheduleDate = startTime.date().addDays(1);
                    Integer i = 1;
                    Integer repeats = 0;
                    while (repeats<numRepeats) {
                        Datetime scheduledStart = Datetime.newInstance(scheduleDate, startTime.time());
                        if (repeatDayOfWeek[Math.mod(Integer.valueOf(scheduledStart.format('u')),7)]) {
                            Event session = new Event();
                            session.OwnerId = System.UserInfo.getUserId();
                            session.WhatId = whatId;                           
                            session.StartDateTime = scheduledStart;
                            session.EndDateTime = scheduledStart.addSeconds((Integer)((endTime.getTime() - startTime.getTime())/1000));
                            sessions.add(session);
                            repeats++;
                        }
                        i++;
                        scheduleDate = scheduleDate.addDays(1);
                        if (i == 7) {
                            i = 0;
                            scheduleDate = scheduleDate.addDays(7*(frequency-1));
                        } 
                    }
                }
                else if (endType == 'on') {
                    Date scheduleDate = startTime.date().addDays(1);
                    Integer i = 1;
                    while (scheduleDate <= endRepeatDate) {
                        Datetime scheduledStart = Datetime.newInstance(scheduleDate, startTime.time());
                        if (repeatDayOfWeek[Math.mod(Integer.valueOf(scheduledStart.format('u')),7)]) {
                            Event session = new Event();
                            session.OwnerId = System.UserInfo.getUserId();
                            session.WhatId = whatId;                           
                            session.StartDateTime = scheduledStart;
                            session.EndDateTime = scheduledStart.addSeconds((Integer)((endTime.getTime() - startTime.getTime())/1000));
                            sessions.add(session);
                        }
                        i++;
                        scheduleDate = scheduleDate.addDays(1);
                        if (i == 7) {
                            i = 0;
                            scheduleDate = scheduleDate.addDays(7*(frequency-1));
                        }                                               
                    }
                }
            }
            else if (repeatType == 'monthly') {
                if (endType == 'none') {
                    endRepeatDate = startTime.date().addYears(1);
                    if (monthlyWhich == 'none') {
                        for (Date scheduleDate = startTime.date().addMonths(frequency); scheduleDate <= endRepeatDate; scheduleDate = scheduleDate.addMonths(frequency)) {
                            Event session = new Event();
                            session.OwnerId = System.UserInfo.getUserId();
                            session.WhatId = whatId;
                            Datetime scheduledStart = Datetime.newInstance(scheduleDate, startTime.time());
                            session.StartDateTime = scheduledStart;
                            session.EndDateTime = scheduledStart.addSeconds((Integer)((endTime.getTime() - startTime.getTime())/1000));
                            sessions.add(session);
                        }
                    }
                }
                else if (endType == 'after') {
                    if (monthlyWhich == 'none') {
                        Date scheduleDate = startTime.date();
                        for (Integer i=0; i<numRepeats; i++) {
                            scheduleDate = scheduleDate.addMonths(frequency);
                            Event session = new Event();
                            session.OwnerId = System.UserInfo.getUserId();
                            session.WhatId = whatId;
                            Datetime scheduledStart = Datetime.newInstance(scheduleDate, startTime.time());
                            session.StartDateTime = scheduledStart;
                            session.EndDateTime = scheduledStart.addSeconds((Integer)((endTime.getTime() - startTime.getTime())/1000));
                            sessions.add(session);
                        }
                    }   
                }
                else if (endType == 'on') {
                    if (monthlyWhich == 'none') {
                        for (Date scheduleDate = startTime.date().addMonths(frequency); scheduleDate <= endRepeatDate; scheduleDate = scheduleDate.addMonths(frequency)) {
                            Event session = new Event();
                            session.OwnerId = System.UserInfo.getUserId();
                            session.WhatId = whatId;
                            Datetime scheduledStart = Datetime.newInstance(scheduleDate, startTime.time());
                            session.StartDateTime = scheduledStart;
                            session.EndDateTime = scheduledStart.addSeconds((Integer)((endTime.getTime() - startTime.getTime())/1000));
                            sessions.add(session);
                        }
                    }
                }
            }
        }
        Database.insert(sessions);
        return null;
    }
}
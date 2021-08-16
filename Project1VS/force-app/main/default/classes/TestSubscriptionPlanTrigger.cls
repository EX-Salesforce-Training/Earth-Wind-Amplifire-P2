/*
Author: Zackary Frazier
Last Modified Project: Project 2
Created Project: Project 2 
Desc:
  unit tests for the subscription plan trigger
*/

@isTest
public class TestSubscriptionPlanTrigger {
	
    private static void insertProducts() {
        Product2 annual = new Product2(
        	Name = 'Annual Subscription'
        );
        insert annual;
        
        Product2 monthly = new Product2(
        	Name='Monthly Subscription'
        );
        insert monthly;
    }
    
    @testSetup
    public static void setup() {
        List<User> users = new List<User>();
        String profileId = [SELECT Id FROM Profile WHERE Name = 'D&DU - Player'].Id;
        String userRoleId = [SELECT Id FROM UserRole WHERE Name='Player'].Id;
        for(Integer i = 0; i < 50; i++) {
            User u = new User(
                ProfileId = profileId,
                LastName = 'last ' + i,
                Email = 'puser00' + i + '@amamama.com',
                Username = 'puser00' + i + '@amamama.com' + System.currentTimeMillis(),
                CompanyName = 'TEST',
                Title = 'title',
                Alias = 'alias',
                TimeZoneSidKey = 'America/Los_Angeles',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US',
                LocaleSidKey = 'en_US',
                UserRoleId = userRoleId
            );
            users.add(u);
        }
        insert users;
    }
    
    // single positive test insert
    @isTest
    public static void testInsert01() {
        insertProducts();
        
        Subscription_Plan__c plan0 = new Subscription_Plan__c(
        	User__c = [SELECT Id FROM User WHERE LastName = 'last 0'].Id,
            Product__c = [SELECT Id FROM Product2 WHERE Name = 'Monthly Subscription'].Id
        );
        try {
        	insert plan0;
            System.assert(true);
        } catch(Exception e) {
            System.assert(false);
        }
        
        Subscription_Plan__c plan1 = new Subscription_Plan__c(
        	User__c = [SELECT Id FROM User WHERE LastName = 'last 1'].Id,
            Product__c = [SELECT Id FROM Product2 WHERE Name = 'Monthly Subscription'].Id
        );
        try {
        	insert plan1;
            System.assert(true);
        } catch(Exception e) {
            System.assert(false);
        }
    }
    
    // single negative test insert
    @isTest
    public static void testInsert02() {
        insertProducts();
        
        Subscription_Plan__c plan0 = new Subscription_Plan__c(
            User__c = [SELECT Id FROM User WHERE LastName = 'last 0'].Id,
            Product__c = [SELECT Id FROM Product2 WHERE Name = 'Monthly Subscription'].Id
        );
        try {
            insert plan0;
            System.assert(true);
        } catch(Exception e) {
            System.assert(false);
        }
        
        Subscription_Plan__c plan1 = new Subscription_Plan__c(
            User__c = [SELECT Id FROM User WHERE LastName = 'last 0'].Id,
            Product__c = [SELECT Id FROM Product2 WHERE Name = 'Monthly Subscription'].Id
        );
        try {
            insert plan1;
            System.assert(false);
        } catch(Exception e) {
            System.assert(true);
        }	
    }
    
    // bulk positive test insert
    @isTest
    public static void testInsert03() {
        insertProducts();
        
        List<Subscription_Plan__c> planList = new List<Subscription_Plan__c>();
        List<User> users = [SELECT Id FROM User];
        String productId = [SELECT Id FROM Product2 WHERE Name = 'Monthly Subscription'].Id;
        for(Integer i = 0; i < 50; i++) {
            Subscription_Plan__c p = new Subscription_Plan__c(
                User__c = users[i].Id,
                Product__c = productId
            );
            planList.add(p);
        }
        try {
            insert planList;
            System.assert(true);
        } catch(Exception e) {
            System.assert(false);
        }
    }
    
    // bulk negative test insert
    @isTest
    public static void testInsert04() {
        insertProducts();
        
        List<Subscription_Plan__c> planList = new List<Subscription_Plan__c>();
        List<User> users = [SELECT Id FROM User];
        String productId = [SELECT Id FROM Product2 WHERE Name = 'Monthly Subscription'].Id;
        for(Integer i = 0; i < 50; i++) {
            // each entry will have a duplicate
            Subscription_Plan__c p = new Subscription_Plan__c(
                User__c = users[Math.mod(i, 25)].Id,
                Product__c = productId
            );
            planList.add(p);
        }
        try {
            insert planList;
            System.assert(false);
        } catch(Exception e) {
            System.assert(true);
        }
    }
    
    // single positive test update
    @isTest
    public static void testUpdate01() {
        insertProducts();
        
        Subscription_Plan__c plan0 = new Subscription_Plan__c(
        	User__c = [SELECT Id FROM User WHERE LastName = 'last 0'].Id,
            Product__c = [SELECT Id FROM Product2 WHERE Name = 'Monthly Subscription'].Id
        );
        
        try {
        	insert plan0;
            System.assert(true);
        } catch(Exception e) {
            System.assert(false);
        }
        
        Subscription_Plan__c plan1 = [SELECT User__c FROM Subscription_Plan__c WHERE Id = :plan0.Id];
        plan1.User__c = [SELECT Id FROM User WHERE LastName = 'last 1'].Id;
        
        try {
        	update plan1;
            System.assert(true);
        } catch(Exception e) {
            System.assert(false);
        }
    }
    
    // single negative test update
    @isTest
    public static void testUpdate02() {
        insertProducts();
        
        Subscription_Plan__c plan0 = new Subscription_Plan__c(
        	User__c = [SELECT Id FROM User WHERE LastName = 'last 0'].Id,
            Product__c = [SELECT Id FROM Product2 WHERE Name = 'Monthly Subscription'].Id
        );
        
        Subscription_Plan__c plan1 = new Subscription_Plan__c(
        	User__c = [SELECT Id FROM User WHERE LastName = 'last 1'].Id,
            Product__c = [SELECT Id FROM Product2 WHERE Name = 'Monthly Subscription'].Id
        );
        
        try {
        	insert plan0;
            insert plan1;
            System.assert(true);
        } catch(Exception e) {
            System.assert(false);
        }
        
        Subscription_Plan__c plan2 = [SELECT User__c FROM Subscription_Plan__c WHERE Id = :plan0.Id];
        plan2.User__c = [SELECT Id FROM User WHERE LastName = 'last 1'].Id;
        
        try {
        	update plan2;
            System.assert(false);
        } catch(Exception e) {
            System.assert(true);
        }
    }
    
    // bulk positive test update
    @isTest
    public static void testUpdate03() {
        insertProducts();
        
        List<Subscription_Plan__c> planList = new List<Subscription_Plan__c>();
        List<User> userList = [SELECT Id FROM User];
        ID productId = [SELECT Id FROM Product2 WHERE Name = 'Monthly Subscription'].Id;
        for(Integer i = 0; i < 25; i++) {
            Subscription_Plan__c p = new Subscription_Plan__c(
                User__c = userList[i].Id,
                Product__c = productId
            );
            planList.add(p);
        }
        insert planList;
        planList = [SELECT User__c FROM Subscription_Plan__c];
        for(Integer i = 25; i < 50; i++) {
        	planList[Math.mod(i, 25)].User__c = userList[i].Id;  
        } 
        try {
            update planList;
            System.assert(true);
        } catch(Exception e) {
            System.assert(false);
        }
    }
    
    // bulk negative test update
    @isTest
    public static void testUpdate04() {
        insertProducts();
        
        List<Subscription_Plan__c> planList = new List<Subscription_Plan__c>();
        List<User> userList = [SELECT Id FROM User];
        ID productId = [SELECT Id FROM Product2 WHERE Name = 'Monthly Subscription'].Id;
        for(Integer i = 0; i < 25; i++) {
            Subscription_Plan__c p = new Subscription_Plan__c(
                User__c = userList[i].Id,
                Product__c = productId
            );
            planList.add(p);
        }
        insert planList;
        planList = [SELECT User__c FROM Subscription_Plan__c];
        for(Integer i = 0; i < 25; i++) {
            planList[i].User__c = userList[0].Id;  
        } 
        try {
            update planList;
            System.assert(false);
        } catch(Exception e) {
            System.assert(true);
        }
    }
    
}
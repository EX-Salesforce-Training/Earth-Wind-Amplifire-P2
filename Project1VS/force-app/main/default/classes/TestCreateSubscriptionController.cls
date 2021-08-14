@isTest
public class TestCreateSubscriptionController {
    
	@testSetup
    public static void setup() {
        Product2 subProdAnnual = new Product2(
        	Name='Annual Subscription',
            IsActive=true
        );
        insert subProdAnnual;
        
        Product2 subProdMonthly = new Product2(
            Name='Monthly Subscription',
            IsActive=true
        );
        insert subProdMonthly;
    }
    
    // positive single test create
    @isTest
    public static void testCreate01() {
        Boolean createdPlan = CreateSubscriptionController.createSubscriptionPlanForCurrentUser('Annual Subscription');
        System.assert(createdPlan);
    }
    
    // positive single test create
    @isTest
    public static void testCreate02() {
        Boolean createdPlan = CreateSubscriptionController.createSubscriptionPlanForCurrentUser('Monthly Subscription');
        System.assert(createdPlan);
    }
    
    // negative single test create
    @isTest
    public static void testCreate03() {
        CreateSubscriptionController.createSubscriptionPlanForCurrentUser('Annual Subscription');
        Boolean createdPlan = CreateSubscriptionController.createSubscriptionPlanForCurrentUser('Monthly Subscription');
        System.assert(!createdPlan);
    }
    
    // negative single test create
    @isTest
    public static void testCreate04() {
        Boolean createdPlan = CreateSubscriptionController.createSubscriptionPlanForCurrentUser('not a plan');
        System.assert(!createdPlan);
    }
    
    // positive single test edit
    @isTest
    public static void testEdit01() {
        Boolean createdPlan = CreateSubscriptionController.createSubscriptionPlanForCurrentUser('Annual Subscription');
        System.assert(createdPlan);
        Boolean editedPlan = CreateSubscriptionController.editSubscriptionPlanForCurrentUser(true);
        System.assert(editedPlan);
        editedPlan = CreateSubscriptionController.editSubscriptionPlanForCurrentUser(false);
        System.assert(editedPlan);
    }
    
    // negative single test edit
    @isTest
    public static void testEdit02() {
        Boolean editedPlan = CreateSubscriptionController.editSubscriptionPlanForCurrentUser(true);
        System.assert(!editedPlan);
    }
    
    // negative single test edit, plan with no product
    @isTest
    public static void testEdit03() {
        Boolean createdPlan = CreateSubscriptionController.createSubscriptionPlanForCurrentUser('Annual Subscription');
        Subscription_Plan__c plan = [SELECT Product__c FROM Subscription_Plan__c WHERE User__c = :UserInfo.getUserId()];
        plan.Product__c = null;
        update plan;
        Boolean editedPlan = CreateSubscriptionController.editSubscriptionPlanForCurrentUser(true);
        System.assert(!editedPlan);
    }
    
    // test retrieve current user subplan
    @isTest
    public static void testRetrieve01() {
        CreateSubscriptionController.createSubscriptionPlanForCurrentUser('Annual Subscription');
        Subscription_Plan__c plan = CreateSubscriptionController.retrieveCurrentUserSubPlan();
        System.assertNotEquals(null, plan);
    }
    
    // negative test retrieve current user subplan
    @isTest
    public static void testRetrieve02() {
        Subscription_Plan__c plan = CreateSubscriptionController.retrieveCurrentUserSubPlan();
        System.assertEquals(null, plan);
    }
}
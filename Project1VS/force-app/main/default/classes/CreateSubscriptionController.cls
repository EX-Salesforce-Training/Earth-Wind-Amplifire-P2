public class CreateSubscriptionController {
	
    // @desc: create a new subscription plan for the current user
    @AuraEnabled
    public static Boolean createSubscriptionPlanForCurrentUser(String subscriptionName) {
        ID userId = UserInfo.getUserId();
        ID subId;
        try {
        	subId = [SELECT Id FROM Product2 WHERE Name = :subscriptionName].id;
        } catch(QueryException e) {
            System.debug('A subscription of that name does not exist');
            return false;
        }
        
        Subscription_Plan__c plan = new Subscription_Plan__c(
        	user__c = userId,
            Product__c = subId
        );
        
        try {
            insert plan;
            return true;
        } catch(Exception e) {
            System.debug(e);
            return false;
        }
    }
    
    // @desc: create a new subscription plan for the current user
    @AuraEnabled
    public static Boolean editSubscriptionPlanForCurrentUser(String subscriptionName) {
        ID userId = UserInfo.getUserId();
        Subscription_Plan__c userSubPlan;
        ID subId;
        try {
        	userSubPlan = [SELECT Product__c FROM Subscription_Plan__c WHERE User__c = :userId];
        } catch(QueryException e) {
            System.debug('User does not have a subscription');
            return false;
        }
        
        try {
            subId = [SELECT Id FROM Product2 WHERE Name = :subscriptionName].Id;
        } catch(QueryException e) {
            System.debug('A subscription of that name does not exist');
            return false;
        }
        
        userSubPlan.Product__c = subId;
        
        try {
            update userSubPlan;
            return true;
        } catch(Exception e) {
            System.debug(e);
            return false;
        }
    }
}
public class SubscriptionPlanTriggerHandler {
    
    // @desc : set an error on all duplicates on insert
    public static void ensureUniqueUserOnInsert(List <Subscription_Plan__c> subPlanList) {
        
        // retrieve the user ids
        List<ID> idList = new List<ID>();
        Set<ID> idSet = new Set<ID>();
        for(Subscription_Plan__c plan: subPlanList) {
            idList.add(plan.User__c);
            idSet.add(plan.User__c);
        }
        
        // if there's a duplicate being added, reject all
        if(idSet.size() != idList.size()) {
            for(Subscription_Plan__c plan: subPlanList) {
                plan.addError('Duplicate plan being added');
            }
        }
        
        // for any subscription plan whose user already exists, add an error
        for(Subscription_Plan__c currentSubscriber: [SELECT User__c FROM Subscription_Plan__c WHERE User__c in :IdSet]) {
            for(Subscription_Plan__c newSubscriber: subPlanList) {
                if(newSubscriber.User__c == currentSubscriber.User__c) {
                    newSubscriber.addError('This user already has a subscription');
                }
            }
        } 
    }
    
    // @desc : set an error on all duplicates on insert
    public static void ensureUniqueUserOnUpdate(List <Subscription_Plan__c> subPlanList) {
        
        // retrieve the user ids
        List<ID> idList = new List<ID>();
        Set<ID> idSet = new Set<ID>();
        for(Subscription_Plan__c plan: subPlanList) {
            idList.add(plan.User__c);
            idSet.add(plan.User__c);
        }
        
        // if there's a duplicate being added, reject all
        if(idSet.size() != idList.size()) {
            for(Subscription_Plan__c plan: subPlanList) {
                plan.addError('Duplicate plan being added');
            }
        }
        
        // for any subscription plan whose user already exists, add an error
        for(Subscription_Plan__c currentSubscriber: [SELECT User__c FROM Subscription_Plan__c WHERE User__c in :IdSet]) {
            for(Subscription_Plan__c newSubscriber: subPlanList) {
                if(newSubscriber.User__c == currentSubscriber.User__c && newSubscriber.Id != currentSubscriber.Id) {
                    newSubscriber.addError('This user already has a subscription');
                }
            }
        } 
    }
}
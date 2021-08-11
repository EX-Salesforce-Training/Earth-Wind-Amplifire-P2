trigger SubscriptionPlanTrigger on Subscription_Plan__c (before insert, before update) {
    switch on Trigger.OperationType {
        when BEFORE_INSERT {
			SubscriptionPlanTriggerHandler.ensureUniqueUserOnInsert(Trigger.new);
        }
        
        when BEFORE_UPDATE {
            SubscriptionPlanTriggerHandler.ensureUniqueUserOnUpdate(Trigger.new);
        }
    }
}
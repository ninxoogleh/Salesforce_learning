trigger HomeWorkDealTrigger on Deal__c (after update) {
    new DealTriggerHandler().go();
}
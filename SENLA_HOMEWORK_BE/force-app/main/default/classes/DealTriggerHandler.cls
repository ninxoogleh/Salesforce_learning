public inherited sharing class DealTriggerHandler extends TriggerHandler {
    public void go() {
        super.run();
    }

    Override
    protected virtual void afterUpdate() {
        List<Id> propertyIds = new List<Id>();
        for(Id dealId : Trigger.newMap.keySet()) {
            Deal__c newDeal = (Deal__c) Trigger.newMap.get(dealId);
       	        if (newDeal.RecordTypeId != DealManager.SALE_RECORD_TYPE_ID || newDeal.Status__c != 'Closed Won') continue;
                if (newDeal.Status__c != Trigger.oldMap.get(dealId).get(Deal__c.Status__c)) propertyIds.add(newDeal.Deal_Object__c);
        }
        if (!propertyIds.isEmpty()) {
            List<Deal__c> dealToChange = DealManager.getNotClosedSaleDealsByProperties(propertyIds);
       	    for (Deal__c dl : dealToChange) {
           		dl.Status__c = 'Closed Lost';
       	    }
            Database.SaveResult[] results = Database.update(dealToChange, false);
            Utils.checkDatabaseSaveResults(results, dealToChange, 'DealTriggerHandler');
        }
    }
}
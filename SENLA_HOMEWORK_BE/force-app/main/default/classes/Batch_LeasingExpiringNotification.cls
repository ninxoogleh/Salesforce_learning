public class Batch_LeasingExpiringNotification implements Database.Batchable<sObject> {
    public static final String FIELDS = 'CreatedDate, Contact__r.Id, Contact__r.FirstName, Contact__r.LastName, Contact__r.Email, ' +
        								'Deal_Object__r.Id, Deal_Object__r.Buyer__r.Id, Deal_Object__r.Buyer__r.FirstName, ' + 
        								'Deal_Object__r.Buyer__r.LastName, Deal_Object__r.Buyer__r.Email, Deal_Object__r.Country__c, ' + 
        								'Deal_Object__r.City__c, Deal_Object__r.Address__c, Deal_Object__r.Latitude__c, Deal_Object__r.Longitude__c, ' +
        								'Leasing_Begins_From__c, Leasing_Ends_To__c';
    
	public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator ([SELECT id FROM Deal__c WHERE Leasing_Ends_To__c = TOMORROW]);
    }

    public void execute(Database.BatchableContext bc, List<Deal__c> locatorData){
        List<Deal__c> targetDeals = [SELECT FIELDS FROM locatorData];
        List<NotifyClientRentEnding__e> leaseExpiredEventList = new List<NotifyClientRentEnding__e>();
        for (Deal__c deal : targetDeals) {
            leaseExpiredEventList.add(new NotifyClientRentEnding__e(DealId__c = deal.Id,
                                                                    Info__c = JSON.serialize(new InfoSpecificationCreate.Info(deal), true)
                                                                   )
                                     );
        }
    
        List<Database.SaveResult> results = EventBus.publish(leaseExpiredEventList);
        for (Database.SaveResult sr : results) {
           if (sr.isSuccess()) {
               System.debug('Successfully published event.');
           } else {
               for(Database.Error err : sr.getErrors()) {
                   System.debug('Error returned: ' + err.getStatusCode() + ' - ' + err.getMessage());
               }
           }
        }
    }
    
    public void finish(Database.BatchableContext bc){ }
}
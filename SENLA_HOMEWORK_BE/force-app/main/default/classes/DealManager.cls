public inherited sharing class DealManager {

    public static final Id SALE_RECORD_TYPE_ID = Utils.getRecordTypeIdbyName('Deal__c', 'Selling');

    public static List<Deal__c> getNotClosedSaleDealsByProperties(List<Id> propertyIds) {
    return [SELECT Id
            FROM Deal__c
            WHERE Deal_Object__c IN :propertyIds
            AND Status__c NOT IN ('Closed Won', 'Closed', 'Closed Lost')
            AND RecordTypeId = :SALE_RECORD_TYPE_ID
            ];
    }

    public class DealPreparer {
        public String seller {get; set;}
        public String buyer {get; set;}
        public String dealType {get; set;}

        public DealPreparer (String seller, String buyer, String dealType) {
            this.seller = seller;
            this.buyer = buyer;
            if (dealType == 'Leasing') {
                this.dealType = dealType; 
            } else if (dealType == 'Selling') {
                this.dealType = dealType; 
            } else {
                System.debug('/* очень вежливое сообщение о том что у объекта Deal может быть только 2 Record Type */');
            }
        }
    }
    
    public static Deal__c createDealShort(DealPreparer dp, Boolean serialize) {
        Deal__c dl = new Deal__c();
        dl.Seller__c = dp.seller;
        dl.Buyer__c = dp.buyer;
        dl.RecordTypeId = Utils.getRecordTypeIdbyName('dl', dp.dealType);
        
        if (serialize) insert dl;
        
        return dl;
    }

    public static List<Deal__c> getDealsBySeller(String inputPhone) {
        return [SELECT Id FROM Deal__c WHERE Seller__r.Phone = :inputPhone];
    }

    public static void deleteDealByName(String name) {
        delete [SELECT Id FROM Deal__c WHERE Deal__c.Name = :name];
    }
}
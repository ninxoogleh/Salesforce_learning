public inherited sharing class DealManager {

    public class DealPreparer {

        public class InvalidTypeException extends Exception {}    

        public String seller {get; set;}
        public String buyer {get; set;}
        public String dealType {get; set;}

        public static Id getRecordTypeIdbyName(String objectName, String strRecordTypeName) {
            return  Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosByName().get(strRecordTypeName).getRecordTypeId();
        }

        public DealPreparer (String seller, String buyer, String dealType) {
            this.seller = seller;
            this.buyer = buyer;
            try {
                this.dealType = (dealType.equals('Leasing') || dealType.equals('Selling')) ? dealType : new InvalidTypeException();
            } catch (InvalidTypeException e) {
                System.debug(/* очень вежливое сообщение о том что у объекта Deal может быть только 2 Record Type */);
            }    
        }
    }
    
    public static Deal__c createDealShort(DealPreparer dp, Boolean serialize) {
        Deal__c dl = new Deal__c();
        dl.Seller__c = dp.seller;
        dl.Buyer__c = dp.buyer;
        dl.RecordTypeId = getRecordTypeIdbyName(Deal__c, dp.dealType);
        
        if (serialize) insert dl;
        
        return dl;
    }

    public static List<Deal__c> getDealsBySeller(List<Deal__c> deals, Contact seller) {
        return Database.query('SELECT ' + seller.Name + ' FROM Deal WHERE Deal__r.Name IN : deals');
    }

    public static void deleteDealByName(List<Deal> deals, String name) {
        delete [SELECT name FROM Deal__c WHERE Deal.Name IN : deals];
    }
}
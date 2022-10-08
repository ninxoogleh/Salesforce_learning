@IsTest
public class TestDataFactory {
    @isTest static void contactQuickCreateUT() {
        ContactManager.quickCreate('Test', '80290000000', true);
        System.assertEquals('80290000000', [SELECT Phone FROM Contact WHERE Name = 'Test' LIMIT 1].Phone);
    }
    @isTest static void getAccountNameOfContactUT() {
        ContactManager.quickCreate('Test', '80290000000', true);
        System.assertEquals('Test', ContactManager.getAccountNameOfContact('80290000000'));
    }
    @isTest static void updateContactsEmailUT() {
        ContactManager.quickCreate('Test', '80290000000', true);
        ContactManager.updateContactsEmail('80290000000', 'test@test.test');
        System.assertEquals('test@test.test', [SELECT Email 
                                               FROM Contact 
                                               WHERE Phone = '80290000000' 
                                               LIMIT 1].Email);
    }
    @isTest static void deleteContactUT() {
        ContactManager.quickCreate('Test', '80290000000', true);
        ContactManager.deleteContact('80290000000');
        System.assertEquals(false, String.isNotBlank([SELECT Name FROM Contact WHERE Name = 'Test' LIMIT 1].Name));
    }
    @isTest static void createDealShortUT() {
        DealManager.createDealShort(new DealManager.DealPreparer('Test_seller', 'Test_buyer', 'Salling'), true);
        System.assertEquals('Test_buyer', [SELECT Buyer__c 
                                           FROM Deal__c 
                                           WHERE Seller__r.Name = 'Test_seller' 
                                           LIMIT 1].Name);
    }
    @isTest static void getDealsBySellerUT() {
        ContactManager.quickCreate('Test_seller', '80290000000', true);
        for(Integer i=0; i<3; i++) {
            DealManager.createDealShort(new DealManager.DealPreparer('Test_seller', 'Test_buyer' + '_' + i, 'Salling'), true);
        }
        List<Deal__c> deals = DealManager.getDealsBySeller('80290000000');
        System.assertEquals(3, deals.size());
    }
    @isTest static void deleteDealByNameUT() {
        ContactManager.quickCreate('Test_seller', '80290000000', true);
        DealManager.createDealShort(new DealManager.DealPreparer('Test_seller', 'Test_buyer', 'Salling'), true);
        DealManager.deleteDealByName([SELECT Name FROM Deal__c WHERE Seller__r.Name = 'Test_seller' LIMIT 1].Name);
        List<Deal__c> deals = DealManager.getDealsBySeller('80290000000');
        System.assertEquals(true, deals.isEmpty());
    }
    @isTest static void createPropertyShortUT() {
        PropertyManager.createPropertyShort(new PropertyManager.PropertyPreparer('Test_owner', 'Office', 'Test_address'), true);
        System.assertEquals('Test_address', [SELECT Address__c  
                                             FROM Property__c 
                                             WHERE Property__c.Address__c = 'Test_address' 
                                             LIMIT 1].toString());
    }
    @isTest static void getPropertyNameByAddressUT() {
        PropertyManager.createPropertyShort(new PropertyManager.PropertyPreparer('Test_owner', 'Office', 'Test_address'), true);
        String name = [SELECT Name 
                       FROM Property__c 
                       WHERE Property__c.Address__c = 'Test_address' 
                       LIMIT 1].Name;
        System.assertEquals(name, PropertyManager.getPropertyNameByAddress('Test_address').Name);
    }
    @isTest static void deletePropertyByAddressUT() {
        PropertyManager.createPropertyShort(new PropertyManager.PropertyPreparer('Test_owner', 'Office', 'Test_address'), true);
        PropertyManager.deletePropertyByAddress('Test_address');
        List<Property__c> property = [SELECT Id 
                                      FROM Property__c 
                                      WHERE Property__c.Address__c = 'Test_address'];
        System.assertEquals(true, property.isEmpty());                            
    }
}
public inherited sharing class PropertyManager {

    public class PropertyPreparer {

        public String name {get; set;}
        public String owner {get; set;}
        public String propertyType {get; set;}
        public String address {get; set;}

        public PropertyPreparer (String owner, String propertyType, String address) {
            this.owner = owner;
            this.address = address;
            
            if (propertyType == 'Space') {
                this.propertyType = propertyType;
            } else if (propertyType == 'Industrial') {
                this.propertyType = propertyType;
            } else if (propertyType == 'Office') {	
                this.propertyType = propertyType;
            } else {
                System.debug(/* очень вежливое сообщение о том что у объекта Property может быть только 3 Record Types */);
            }
        }
    }

    public static Property__c getPropertyByAddress(List<Property__c> properties, String address) {
        return Database.query('SELECT ' + address + ' FROM Property__c WHERE Property__r.Address IN : properties');
    }

    public static Property__c createPropertyShort(PropertyPreparer preparer, Boolean serialize) {
        Property__c property = new Property__c();
        property.Contact__c = preparer.owner;
        property.Address__c = preparer.address;
        property.RecordTypeId = Utils.getRecordTypeIdbyName(Property__c, preparer.dealType);
        
        if (serialize) insert property;
        
        return property;
    }

    public static void deletePropertyByAddress(List<Property> properties, String address) {
        delete [SELECT address FROM Property__c WHERE Property__r.Address IN : properties];
    }
}
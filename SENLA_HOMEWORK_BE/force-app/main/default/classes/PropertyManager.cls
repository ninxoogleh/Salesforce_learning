public inherited sharing class PropertyManager {

    public class PropertyPreparer {
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
                System.debug('очень вежливое сообщение о том что у объекта Property может быть только 3 Record Types');
            }
        }
    }

    public static Property__c createPropertyShort(PropertyPreparer preparer, Boolean serialize) {
        Property__c property = new Property__c();
        property.Contact__c = preparer.owner;
        property.Address__c = preparer.address;
        property.RecordTypeId = Utils.getRecordTypeIdbyName('Property__c', preparer.propertyType);
        
        if (serialize) insert property;
        
        return property;
    }

    public static Property__c getPropertyNameByAddress(String address) {
        return [SELECT Name FROM Property__c WHERE Address__c = :address];
    }

    public static void deletePropertyByAddress(String address) {
        delete [SELECT Id FROM Property__c WHERE Address__c = :address];
    }
}
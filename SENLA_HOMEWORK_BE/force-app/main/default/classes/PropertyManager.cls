public inherited sharing class PropertyManager {

    public class PropertyPreparer {

        public class InvalidTypeException extends Exception {}    

        public String name {get; set;}
        public String owner {get; set;}
        public String propertyType {get; set;}
        public String address {get; set;}

        public static Id getRecordTypeIdbyName(String objectName, String strRecordTypeName) {
            return  Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosByName().get(strRecordTypeName).getRecordTypeId();
        }

        public PropertyPreparer (String owner, String propertyType, String address) {
            this.owner = owner;
            this.address = address;
            try {
                switch on propertyType {
                    when 'Space' {
                        this.propertyType = propertyType;
                    }	
                    when 'Industrial' {
                        this.propertyType = propertyType;
                    }
                    when 'Office' {	
                        this.propertyType = propertyType;
                    }
                    when else {
                        new InvalidTypeException();
                    }
                }
            } catch (InvalidTypeException e) {
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
        property.RecordTypeId = getRecordTypeIdbyName(Property__c, preparer.dealType);
        
        if (serialize) insert property;
        
        return property;
    }

    public static void deletePropertyByAddress(List<Property> properties, String address) {
        delete [SELECT address FROM Property__c WHERE Property__r.Address IN : properties];
    }
}
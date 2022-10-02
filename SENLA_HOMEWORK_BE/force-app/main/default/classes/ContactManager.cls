public inherited sharing class ContactManager {
    
    public static Contact quickCreate (String name, String inputPhone, Boolean serialize) {
        Contact cnt = new Contact();
        cnt.Name = name;
        cnt.Phone = inputPhone.replaceAll('\\D','');

        if (serialize) insert cnt;

        return cnt;
    }

    public static String getAccountNameOfContact(String inputPhone) {
        Contact contact = [SELECT Account.Name 
                         FROM Contact 
                         WHERE Phone = :inputPhone
                         LIMIT 1];
        return contact.Account.Name;
    }

    public static void updateContactsEmail (String inputPhone, String email) {
        Contact contact = [SELECT Email FROM Contacts WHERE Phone = :inputPhone LIMIT 1];
        contact.Email = email;
    }

    public static void deleteContact(String inputPhone) {
        delete [SELECT Id FROM Contact WHERE Phone = :inputPhone];
    }
}
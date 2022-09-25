@IsTest
public class TestDataFactory {
    public static Id getRecordTypeIdbyName(String objectName, String strRecordTypeName) {
        return  Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosByName().get(strRecordTypeName).getRecordTypeId();
    }

    public static Contact createContact (Account account, String lastName, String phone, String email) {
        Contact contact = new Contact(
            Account = account, 
            AccountId = account.Id, 
            LastName = lastName, Phone = phone,
            Email = email);
        insert contact;
        return contact;
    }
    //Contact Test
    public static List<Contact> createContacts(Integer num) {
        List<Contact> contacts = new List<Contact>(num);
        for (Integer i = 0; i < num; i++) {
            contacts[i] = new Contact(LastName = 'Test' + i, Phone = '+375-29-1234567');
        }
        insert contacts;
        return contacts;
    }

    
}

/**
 * если честно, ни разу не писал тестовый код и
 * исли можно сделать этот таск, после того как 
 * увижу работу с настоящим примером. Сложно делать
 * что-то, не понимая что хочешь увидеть в итоге)))
 */
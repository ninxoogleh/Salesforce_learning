public inherited sharing class ContactManager {
    
    public static Contact quickCreate (String name, String inputPhone, String note, Boolean serialize) {
        Contact cnt = new Contact();
        cnt.Name = name;
        cnt.Phone = inputPhone.replaceAll('\\D','');
        cnt.Note = note + '. This record has been created in' + System.Now().format() + 'by' + UserInfo.getUserId();

        if (serialize) insert cnt;

        return cnt;
    }

    public static Contact getContactByPhone(List<Contact> contacts, String phone) {
        return Database.query('SELECT ' + phone + ' FROM Contact WHERE Contact.Name IN : contacts');
    }
}
/**
 * Сильно не хватает знаний по синтаксису SOQL, поэтому связанные с ними 
 * команды это тупо копипаст с примера)))
 * Усиленно заполняю пробелы в знаниях
 */
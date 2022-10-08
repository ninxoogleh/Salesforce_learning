public inherited sharing class LogManager {
    
    public static List<Log__c> getLogsByTypes(List<String> types, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Log__c WHERE Type__c IN :types');
    }

    public static Log__c log(String type, String message, Boolean serialize) {

        Log__c createdLog = new Log__c();

        createdLog.Type__c = type;
        createdLog.Message__c = message;

        if (serialize) insert createdLog;
        
        return createdLog;
    }
    
    public static List<Log__c> updateLogs(List<Id> ids, String newType, Boolean serialize) {
        List<Log__c> logs = [SELECT Type__c FROM Log__c WHERE Id IN :ids];
        for (Log__c log : logs) {
            log.Type__c = newType;
        }

        if (serialize) update logs;
        
        return logs;
    }

    public static void deleteLog(String name) {
        delete [SELECT Id FROM Log__c WHERE Log__c.Name = :name];
    }
}

public with sharing class Utils {
    
    // получаем RecordTypeID объекта по его имени
    public static Id getRecordTypeIdbyName(String objectName, String strRecordTypeName) {
        return  Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosByName().get(strRecordTypeName).getRecordTypeId();
    }

    // получаем название RecordType объекта по его ID
    public static String getRecordTypeNameById(String objectName, Id strRecordTypeId) {
        return Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosById().get(strRecordTypeId).getName();
    } 

    //проверяем работу триггер-хендлера
    public static void checkDatabaseSaveResults(List<Database.SaveResult> saveResults,
       				                            List<SObject> records, String errorSource) {
        String logMsg = '';
   	    for (Integer i = 0; i < saveResults.size(); i++) {
       		if (saveResults[i].isSuccess()) continue;
       		logMsg += 'DML operation failed for record: ' + records[i].Id + '\ncause:\n';
       		for (Database.Error err: saveResults[i].getErrors()) {
           			logMsg += err.getMessage() + '\n';
       		}
   	    }
   	    if (String.isBlank(logMsg)) LogManager.log(errorSource, logMsg, true);
    }
}

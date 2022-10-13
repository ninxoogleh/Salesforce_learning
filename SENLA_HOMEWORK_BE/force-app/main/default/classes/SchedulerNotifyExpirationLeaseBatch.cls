global class SchedulerNotifyExpirationLeaseBatch implements Schedulable {
    global void execute(SchedulableContext sc) {
          Database.execute(new Batch_LeasingExpiringNotification());
     }   
}
/**
  * To run schedule uncomment this row:
  * System.Schedule('Notification of leasing expiration', 
                    '0 0 6 * * ? *', 
                    new SchedulerNotifyExpirationLeaseBatch());
*/

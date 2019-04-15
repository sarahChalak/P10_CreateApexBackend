/**
* @author XXXXX XXXXX
* @date XX/XX/XXXX
* @description schedule for Batch_Reminder
*/
global class scheduledReminder implements Schedulable {
    /** The first Monday Of every Month **/
   public static String CRON_EXP ='0 0 12 ? 1/1 MON#1 *';
   public static String name ='scheduledReminder';
   global void execute(SchedulableContext sc) {
      Batch_Reminder b = new Batch_Reminder(); 
      database.executebatch(b);
   }
}
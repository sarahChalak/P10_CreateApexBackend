/**
* @author XXXXX XXXXX
* @date XX/XX/XXXX
* @description Test Class for scheduledReminder, Coverage : 100%
*/ 
@istest
private class scheduledReminder_Test {
    
    static testmethod void test() {
        Test.startTest();
        
        List<Account> lstAccount= new List<Account>();
        for(Integer i=0 ;i <200;i++)
        {
            Account acc = new Account();
            acc.Name ='Name'+i;
            lstAccount.add(acc);
        }
        
        insert lstAccount;
        
        // Schedule the test job 
        String jobId = System.schedule(scheduledReminder.name,
                                       scheduledReminder.CRON_EXP, 
                                       new scheduledReminder());
        
        // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
                          NextFireTime
                          FROM CronTrigger WHERE id = :jobId];
        
        // Verify the expressions are the same
        System.assertEquals(scheduledReminder.CRON_EXP, 
                            ct.CronExpression);
        
        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);
        
        
        Test.stopTest(); 
        
    }
}
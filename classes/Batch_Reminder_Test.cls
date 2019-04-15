/**
* @author XXXXX XXXXX
* @date XX/XX/XXXX
* @description Test Class for Batch_Reminder, Coverage : 100%
*/
@isTest 
private class Batch_Reminder_Test 
{
    static testMethod void TestData() 
    {
        List<Account> lstAccount= new List<Account>();
        for(Integer i=0 ;i <200;i++)
        {
            Account acc = new Account();
            acc.Name ='Name'+i;
            lstAccount.add(acc);
        }
        
        insert lstAccount;
        
        Task temp_Task = new Task();
        temp_Task.Subject ='Call';                 
        temp_Task.WhatId = lstAccount[0].Id;  
        temp_Task.Status='New';
        temp_Task.Priority='Normal';
        temp_Task.CallType='Outbound';
        temp_Task.ReminderDateTime = Datetime.now().addDays(5);
        insert temp_Task;
        
        Test.startTest();
        
        Batch_Reminder obj = new Batch_Reminder();
        DataBase.executeBatch(obj); 
        
        Test.stopTest();
    }
}
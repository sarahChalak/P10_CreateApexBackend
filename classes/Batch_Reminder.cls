/**
* @author XXXXX XXXXX
* @date XX/XX/XXXX
* @description Batch to create tasks for an account that does not have and order and a task in the future
*/
global class Batch_Reminder implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        /** get the account that does not have an order **/
        return Database.getQueryLocator('select id from account where id not in (select accountid from order)');
    }
    
    global void execute(Database.BatchableContext bc, List<Account> scope) {
        /** Check if a Task Already exist in future **/
        Set<Id> TasAlreadyExist = new Set<Id>();
        for(Task t:  [select Whatid from task where what.type = 'Account' and ReminderDateTime > TODAY  And Whatid in : scope ] ){
            TasAlreadyExist.add(t.WhatId);
        }
        List<Task> ListTask =  new List<Task>(); 
        for(Account ObjAcc : scope){
            If(!TasAlreadyExist.contains(ObjAcc.Id)){
                /** Create Task If not exist **/
                Task temp_Task = new Task();
                temp_Task.Subject ='Call';                 
                temp_Task.WhatId = ObjAcc.Id;  
                temp_Task.Status='New';
                temp_Task.Priority='Normal';
                temp_Task.CallType='Outbound';
                temp_Task.ReminderDateTime = Datetime.now().addDays(5);
                ListTask.add(temp_Task); 
            }
        }
        if(ListTask.size()>0){
            Insert ListTask;
        }
    }
    global void finish(Database.BatchableContext bc) {
        // Send an email  
    }
    
    
}
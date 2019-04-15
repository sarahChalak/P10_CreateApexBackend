/**
* @author XXXXX XXXXX
* @date XX/XX/XXXX
* @description Test Class for ManageOrder, Coverage : 100%
*/
@isTest 
private class ManageOrder_Test {
    
    static testMethod void OrderTrigger_Coverage() {
        
        /** Create Account **/
        Account acc = new Account();
        acc.Name='XXXXX';
        acc.Active__c = false;
        insert acc; 
        /** Create Contract **/
        Contract ctra = new Contract(Name='XXXXX',
                                     StartDate=Date.Today(),
                                     Status = 'Draft', AccountId = acc.Id );
        /** Test Bulk Data **/
        Order[] OrdersToCreate = new Order[]{};
            for(Integer x=0; x<200;x++){
                Order TempOrder = new Order(Name = 'XXXXX'+x,AccountId = acc.Id,ContractId = ctra.Id,
                                            EffectiveDate = Date.Today(),Status = 'Draft');
                OrdersToCreate.add(TempOrder);
            }
        
        insert OrdersToCreate;
        
        Test.startTest();
        try{
            
            for(Order objorder : OrdersToCreate){
                objorder.Status = 'Activated';
            }
            /** Test the AddError **/
            update OrdersToCreate;  
            
            
        }catch(Exception ex){ 
            /** Test the AddError **/
            System.Assert(ex.getMessage().contains(ManageOrder.ErrorMessage)); 
        }
        delete OrdersToCreate[0];
        /** Test the Active__c Field on Account **/
        Account GetAccount = [select Active__c from Account where Id = : acc.Id];
        System.assert(GetAccount.Active__c==true);
        
        List<Order> OrdersToDelete = [Select id from order];
        delete OrdersToDelete;
        GetAccount = [select Active__c from Account where Id = : acc.Id];
        System.assert(GetAccount.Active__c==false);
        
        Test.stopTest();  
    }
    
}
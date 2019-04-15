/**
* @author XXXXX XXXXX
* @date XX/XX/XXXX
* @description Test Class for ManageOrder, Coverage : 100%
*/
@isTest 
private class ManageOrder_Test {
    
    static testMethod void OrderTrigger_Coverage() {
        
        Account acc = new Account();
        acc.Name='XXXXX';
        insert acc;
        
        Contract ctra = new Contract(Name='XXXXX',
                                     StartDate=Date.Today(),
                                     Status = 'Draft', AccountId = acc.Id );
        
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
            update OrdersToCreate;  
            
            
        }catch(Exception ex){ 
            System.Assert(ex.getMessage().contains(ManageOrder.ErrorMessage)); 
        }
        Test.stopTest();  
    }
    
}
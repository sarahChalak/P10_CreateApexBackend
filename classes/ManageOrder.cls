/**
* @author XXXXX XXXXX
* @date XX/XX/XXXX
* @description Helper Methods for Order Trigger Handling
*/
public class ManageOrder {
    
    /** Error Message, Should be a label **/
    Public static String ErrorMessage = 'This Error Message Should be a Label';
    
    /**
    * @author XXXXX XXXXX
    * @date XX/XX/XXXX
    * @description This fucntion check the Orders to update a field on account. 
    * @param ListOrder A List of orders 
    * @return Void
    */
    public static void CheckAccountActivation(List<Order> ListOrder ){
        
        List<Account> AccountToUpdate = new List<Account>();
        Set<Id> SetFilterAccount= new Set<Id>();
        for(Order ObjOrder :ListOrder){
            /** Check if the Order is related to an account **/
            if(String.isNotBlank(ObjOrder.AccountId)){
                SetFilterAccount.add(ObjOrder.AccountId);
            }
        }
        System.debug('SetFilterAccount.size()' + SetFilterAccount.size());
        if(SetFilterAccount.size()>0){
            /** Get All related Order for an account **/
            for(Account objAcc  :[select Id,Active__c,(select Id from orders) 
                   from account 
                   where Id in : SetFilterAccount]){
                       /** If no order related to an account and the field Active__c on the account is true change it to false **/
                       /** to avoid unnecessary update **/
                       if(objAcc.orders == null || objAcc.orders.size()==0){
                           if(objAcc.Active__c == true){ 
                               objAcc.Active__c = false;
                               AccountToUpdate.add(objAcc);
                           }
                       }else{
                           /** If one or many order related to an account and the field Active__c on the account is false change it to false **/
                           /** to avoid unnecessary update **/
                           if(objAcc.Active__c== false){
                               objAcc.Active__c = true;
                               AccountToUpdate.add(objAcc);
                           }
                       }
                   }// End For Loop
            if(AccountToUpdate.size()>0){
                Update AccountToUpdate;
            }
        }
        
    }
    
    /**
    * @author XXXXX XXXXX
    * @date XX/XX/XXXX
    * @description This fucntion check if an orderItem existe on an order. 
    * @param MapNewOrder A map of new orders
    * @param MapOldOrder A map of old orders
    * @return Void
    */
    public static void CheckOrderItems(Map<id,Order> MapNewOrder,Map<id,Order> MapOldOrder){
        /** Check if the map is empty **/
        if( MapNewOrder != null && MapNewOrder.size()>0){
            
            Set<Id> SetOrderIdToActivate = new Set<Id>(); 
            
             /** Filter the records To get only the changed Status to Activated data **/
            for(Order ObjOrder :MapNewOrder.values() ){
                Order Oldorder = MapOldOrder.get(ObjOrder.Id);
                if(Oldorder.Status != ObjOrder.Status &&  ObjOrder.Status == 'Activated' /** Should be a Label **/){
                    SetOrderIdToActivate.add(ObjOrder.Id);
                }
            }
            if(SetOrderIdToActivate!= null && SetOrderIdToActivate.size()>0){
                /** get existing Order And Order Items **/ 
                for(Order ObjOrder :[select Id,(select Id from orderitems) 
                                         from order
                                         where Id in :SetOrderIdToActivate]){
                    if(ObjOrder.OrderItems==null || ObjOrder.OrderItems.size()==0){
                        /** Add Error when no Items on the activated order was found**/
                        MapNewOrder.get(ObjOrder.Id).addError(ErrorMessage); 
                    }
                }
            }
        }
        
    }
}
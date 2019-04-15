/**
* @author XXXXX XXXXX
* @date XX/XX/XXXX
* @description Helper Methods for Order Trigger Handling
*/
public class ManageOrder {
    
    /**
    * @author XXXXX XXXXX
    * @date XX/XX/XXXX
    * @description This fucntion check if an orderItem existe on an order. 
    * @param MapNewOrder A map of new orders
    * @param MapOldOrder A map of old orders
    * @return Void
    */
    Public static String ErrorMessage = 'This Error Message Should be a Label';
    
    public static void CheckOrderItems(Map<id,Order> MapNewOrder,Map<id,Order> MapOldOrder){
        /** Check if the map is empty **/
        if( MapNewOrder != null && MapNewOrder.size()>0){
            
            Set<Id> SetOrderIdToActivate = new Set<Id>(); 
            
             /** Filter the records  **/
            for(Order ObjectOrder :MapNewOrder.values() ){
                Order Oldorder = MapOldOrder.get(ObjectOrder.Id);
                if(Oldorder.Status != ObjectOrder.Status &&  ObjectOrder.Status == 'Activated' /** Should be a Label **/){
                    SetOrderIdToActivate.add(ObjectOrder.Id);
                }
            }
            if(SetOrderIdToActivate!= null && SetOrderIdToActivate.size()>0){
                /** get existing Order Items **/ 
                for(Order ObjectOrder :[select Id,(select Id from orderitems) 
                                         from order
                                         where Id in :SetOrderIdToActivate]){
                    if(ObjectOrder.OrderItems==null || ObjectOrder.OrderItems.size()==0){
                        /** Add Error when no Items on the activated order **/
                        MapNewOrder.get(ObjectOrder.Id).addError(ErrorMessage); 
                    }
                }
            }
        }
        
    }
}
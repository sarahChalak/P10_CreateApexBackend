/**
* @author XXXXX XXXXX
* @date XX/XX/XXXX
* @description Order before update Trigger
*/
trigger OrderBeforeUpdate on Order (before update) { 
    
    ManageOrder.CheckOrderItems(Trigger.newmap,Trigger.oldmap);    
}
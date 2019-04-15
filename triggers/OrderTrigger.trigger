/**
* @author XXXXX XXXXX
* @date XX/XX/XXXX
* @description Order Trigger
*/
trigger OrderTrigger on Order (before update,After delete) { 
    
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            ManageOrder.CheckOrderItems(Trigger.newmap,Trigger.oldmap);  
        }
    }else if(Trigger.isAfter){  
        if(Trigger.isDelete){ 
            ManageOrder.CheckAccountActivation(Trigger.old);  
        }
    }
}
trigger MaintenanceRequest on Case (before update, after update) {
    // call MaintenanceRequestHelper.updateWorkOrders  
    
    if(trigger.isAfter){
        if(trigger.isUpdate){
            MaintenanceRequestHelper.updateWorkOrders();
        }
    }
    
}
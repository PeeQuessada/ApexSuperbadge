public class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(){
        List<Case> ListmaintenanceRequest = [SELECT id, case.Vehicle__c, Equipment__c, Equipment__r.Maintenance_Cycle__c, 
                                             Type, Status, Origin FROM Case WHERE id IN :Trigger.New];
        
        if(ListmaintenanceRequest != null && ListmaintenanceRequest.size() > 0){
            List<Case> insertMaintenance = listaNewCases(ListmaintenanceRequest);
            insert insertMaintenance;
        }
    }        
    
    public static List<Case> listaNewCases(List<Case> ListmaintenanceRequest){
        List<Case> newList = new List<Case>();
        
        for(Case cas: ListmaintenanceRequest){
            if((cas.Type == 'Routine Maintenance' || cas.Type == 'Repair') &&  cas.Status=='Closed'){
                case newMaintenance = new Case();
                newMaintenance.Type = 'Routine Maintenance';
                newMaintenance.Vehicle__c = cas.Vehicle__c;
                newMaintenance.Equipment__c = cas.Equipment__c;
                newMaintenance.Date_Reported__c = date.Today();
                newMaintenance.Date_Due__c = Date.today().addDays(Integer.valueOf(cas.Equipment__r.Maintenance_Cycle__c));
                newMaintenance.Origin = cas.Origin;
                newMaintenance.Subject = 'Routine Maintenance in vehicle ' + cas.Vehicle__c;
                newList.add(newMaintenance);
            }
        }
        return newList;
    }
        
     
}
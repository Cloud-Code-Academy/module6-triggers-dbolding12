trigger Opportunity_Trigger on Opportunity (before insert, before update, after update, after insert, after delete, before delete) {
    System.debug(Trigger.operationType);
        if (Trigger.isUpdate) {           
            if(Trigger.isBefore){
               
                OpportunityTriggerHandler.updateOpportunity(Trigger.new);            

        }

        }else {
            if (Trigger.isDelete) {
               
                OpportunityTriggerHandler.deleteOppotunity(Trigger.old);
                          
                
            }
      }
}
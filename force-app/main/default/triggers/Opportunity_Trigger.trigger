trigger Opportunity_Trigger on Opportunity (before insert, before update, after update, after insert, after delete, before delete) {
    System.debug(Trigger.operationType);
        if (Trigger.isBefore) {
           

        }else {
            if(Trigger.isUpdate){
                OpportunityTriggerHandler.updateOpportunity(Trigger.new);
                OpportunityTriggerHandler.afterOpportunity(Trigger.new);
                
                System.debug(Trigger.new +' ');
                System.debug(Trigger.old); 

            }if (Trigger.isInsert) {
                                

            }if (Trigger.isDelete) {
               OpportunityTriggerHandler.deleteOppotunity(Trigger.old);
                
            }if (Trigger.isAfter) {
                
                
            }
        }
}
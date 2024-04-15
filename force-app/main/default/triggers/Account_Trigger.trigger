trigger Account_Trigger on Account (after insert) {
    
    System.debug(Trigger.operationType);
    
    AccountTriggerHandler.updateAccountFileds(Trigger.new);  
         

   }




}
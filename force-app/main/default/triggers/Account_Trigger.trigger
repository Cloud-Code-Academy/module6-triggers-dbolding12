trigger Account_Trigger on Account (before insert, after insert) {
    
   if(Trigger.isBefore) {
    AccountTriggerHandler.updateAccountFileds(Trigger.new);  

   }else {
    if(Trigger.isAfter) {
        AccountTriggerHandler.afterAccount(Trigger.new);

    }
  }    

}
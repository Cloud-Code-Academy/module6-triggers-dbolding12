public with sharing class OpportunityTriggerHandler {
    public static void updateOpportunity(List<Opportunity> opps) {
       
        for (Opportunity opp: opps) {
            if(opp.amount < 5000)  {
               opp.adderror('Opportunity amount must be greater than 5000'); 
                      
            }
        }

        List<Id> accountIds = new List<Id>();
        for(Opportunity o : opps) {
            if(accountIds.size() != null) {
                accountIds.add(o.AccountId);
            }
            
        }

        System.debug(opps);                                                         
        if(accountIds.size() > 0) {
            List<Contact> contacts = [SELECT Id, AccountId, Title FROM Contact WHERE AccountId IN :accountIds AND Title = 'CEO'];
            Map<Id, Contact> acctConMap = new Map<Id, Contact>();

            for(Contact con : contacts) {
                acctConMap.put(con.AccountId, con);
                System.debug(acctConMap);
            
            for (Opportunity op : opps) {                
                if(acctConMap.containsKey(op.AccountId)) {
                    op.Primary_Contact__c = acctConMap.get(op.AccountId).Id;  

                }  
                                  
                                       
        
                  }   

                }      
             }     
                       
    }
    public static void deleteOppotunity(List<Opportunity> opps) {
        //When an opportunity is deleted prevent the deletion of a closed won opportunity if the account industry is 'Banking'.
        Set<Id> accountIds = new Set<Id>();
       
        for(Opportunity opp : opps) {
            if(opp.StageName == 'Closed Won') {
                accountIds.add(opp.AccountId);
                

            }

        }

        Map<Id, Account> accountIdMap = new Map<Id, Account>([SELECT Id FROM Account WHERE ID IN :AccountIds AND Industry = 'Banking']);
        for(Opportunity o: opps) {
            if(o.StageName == 'Closed Won' && accountIdMap.containsKey(o.accountId)) {
                o.adderror('Cannot delete closed opportunity for a banking account that is won');
                  

          }

        }
    }
}
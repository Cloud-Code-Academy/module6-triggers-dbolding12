public with sharing class OpportunityTriggerHandler {
    public static void updateOpportunity(List<Opportunity> opps) {
       
        for (Opportunity opp: opps) {
            if(opp.amount < 5000)  {
               opp.adderror('Opportunity amount must be greater than 5000'); 
                      
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

    public static void afterOpportunity(List<Opportunity> opps) {
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity o : opps) {
            accountIds.add(o.AccountId);
        }

        System.debug(opps);                                                         
        Map<Id, Id> acctConMap = new Map<Id, Id>();

        for(Contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds AND Title = 'CEO']) {
            acctConMap.put(con.AccountId, con.Id);

        }
        System.debug(acctConMap);
            /*When an opportunity is updated set the primary contact...
            on the opportunity to the contact on the same account with the title of 'CEO'.*/
            //Need the contacts with the Title of CEO associated with the Account. If the CEO is blank do nothing...
            //Set the Primary Contact on the Opportunity to the CEO contact on the account associated with the opportunity...
        List<Opportunity> updateOpportunities = new List<Opportunity>();

        for (Opportunity opp :opps) {
            if(acctConMap.containsKey(opp.AccountId)){
                opp.Primary_Contact__c = acctConMap.get(opp.AccountId);
                updateOpportunities.add(opp);

            }               

        }
        
        if(!updateOpportunities.isEmpty()) {
            System.debug(updateOpportunities);
            update updateOpportunities;
        }
                  
    }  
}

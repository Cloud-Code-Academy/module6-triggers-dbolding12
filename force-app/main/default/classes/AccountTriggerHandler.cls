public with sharing class AccountTriggerHandler {
  
    public static void updateAccountFileds(List<Account> newAccounts) {
        List<Contact> contacts = new List<Contact>();

        for (Account acc : newAccounts){

            //Set the account type to prospect.
            //When an account is inserted change the account type to 'Prospect' if there is no value in the type field.
            if(String.isBlank(acc.Type)) {
                acc.Type = 'Prospect';
            }            
            

            //Set the account rating to hot.
            //When an account is inserted set the rating to 'Hot' if the Phone, Website, and Fax ALL have a value.
            if(String.isNotBlank(acc.Phone) && String.isNotBlank(acc.Fax) && String.isNotBlank(acc.Fax)) {
                acc.Rating = 'Hot';
            }
            

            //2. Copy the shipping address to the billing address.
            //When an account is inserted copy the shipping address to the billing address.
            //BONUS: Check if the shipping fields are empty before copying.
            if(String.isBlank(acc.BillingStreet) && String.isNotBlank(acc.ShippingStreet)) {
                acc.BillingCity = acc.ShippingCity;
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingState = acc.ShippingState;
                acc.BillingCountry = acc.ShippingCountry;
            }
            
            Contact con = new Contact();
            con.FirstName = 'New';
            con.LastName = 'Contact';
            con.AccountId = acc.Id; 
            contacts.add(con);
            
        }       
        
        insert contacts;         
                 
               

    }
    
    
}
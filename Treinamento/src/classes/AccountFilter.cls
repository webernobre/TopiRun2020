/**
 * @author walmeida
 */
public class AccountFilter {

    public List<Account> filterByChangedDocumentNumber ( List<Account> newAccounts
                                                        , Map<Id,Account> oldAccounts ) {
        
        List<Account> filteredAccounts = new List<Account> ();
        
        for ( Account account : newAccounts ) {

            if ( String.isEmpty(account.DocumentNumber__c) ) {
                continue;
            } 

            if ( oldAccounts == null 
                || oldAccounts.isEmpty() ) {

                filteredAccounts.add(account);
                continue;
            
            }

            if ( account.DocumentNumber__c == oldAccounts.get(account.Id).DocumentNumber__c ) {
                continue;
            }
            
            filteredAccounts.add( account );
        }
        return filteredAccounts;
    }

    public List<Account> filterByCategoryAndAnualRevenue (List<Account> newAccounts, 
                                                          String category, 
                                                          Double annualRevenue) {
        
        List<Account> filteredAccounts = new List<Account> ();
        
        for ( Account account : newAccounts ) {

            if (account.Category__c == category && account.AnnualRevenue > annualRevenue){
                filteredAccounts.add( account );
            }

        }

        return filteredAccounts;
    }

}
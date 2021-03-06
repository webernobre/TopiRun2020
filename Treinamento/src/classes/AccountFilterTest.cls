@isTest
public class AccountFilterTest {

    // BDD given When Then
    @isTest
    static void filterAccountsByDocumentNumberTest () {

        Map<String, SObject> records = AccountFixtureFactory.createIntegratedScenario();

        List<Account> accounts = new List<Account> { 
            (Account) records.get('account') 
        };

        AccountFilter filter = new AccountFilter();

        List<Account> filteredAccounts = filter.filterByChangedDocumentNumber(accounts, null);
   
        System.assertEquals(accounts.size(), filteredAccounts.size());
        
        filteredAccounts = filter.filterByChangedDocumentNumber(accounts, new Map<Id,Account>());
        
        System.assertEquals(accounts.size(), filteredAccounts.size());

        Map<Id,Account> oldAccounts = new Map<Id,Account> (accounts);

        Account changedAccount = accounts.get(0).clone(true, true, true, true);
        changedAccount.DocumentNumber__c = 'X';
        oldAccounts.put(changedAccount.Id, changedAccount);
        
        filteredAccounts = filter.filterByChangedDocumentNumber(accounts, oldAccounts);
        System.assert( filteredAccounts.size() == 1 );

        changedAccount = accounts.get(0).clone(true, true, true, true);
        oldAccounts.clear();
        oldAccounts.put(changedAccount.Id, changedAccount);
        filteredAccounts = filter.filterByChangedDocumentNumber(accounts, oldAccounts);

        System.assert( filteredAccounts.size() == 0 );


        accounts = new List<Account>();
        accounts.add (new Account (Name = 'Teste 01' ) );
        accounts.add (new Account (Name = 'Teste 02' ) );
        
        filteredAccounts = filter.filterByChangedDocumentNumber(accounts, null );
        
        System.assert( filteredAccounts.isEmpty() );

    }

    @isTest
    static void filterByCategoryAndAnualRevenueTest(){

        List<Account> account = new List<Account>();
        AccountFilter filter = new AccountFilter();
        EventRepository eventRepository = new EventRepository();

        account.add(AccountFixtureFactory.createAccount('Weber 01','Standard', 2000000));
        account.add(AccountFixtureFactory.createAccount('Weber 02','Premium', 2000000));
        account.add(AccountFixtureFactory.createAccount('Weber 03','Premium', 1000000));
        account.add(AccountFixtureFactory.createAccount('Weber 04','Premium', 100000));
        account.add(AccountFixtureFactory.createAccount('Weber 04','Premium',null));
        List<Account> filteredAccounts = filter.filterByCategoryAndAnualRevenue(account,'Premium',1000000);
        System.assertNotEquals(account.size(), filteredAccounts.size());

        List<Event> resultEvents = eventRepository.findByAccount(account);
        System.assertEquals(resultEvents.size(), filteredAccounts.size());


    }


}
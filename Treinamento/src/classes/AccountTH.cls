/**
 * @author walmeida
 */
public virtual with sharing class AccountTH extends TriggerHandler {

    List<Account> newAccounts;
    
    Map<Id,Account> oldAccounts;

    AccountFilter filter;

    AccountValidator validator;
    
    AccountEnricher enricher;

    public AccountTH () {
        this ( (List<Account>) Trigger.new, (Map<Id,Account>) Trigger.oldMap );
    }

    public AccountTH (List<Account> newAccounts , Map<Id,Account> oldAccounts) {
        
        this.newAccounts = newAccounts;
        this.oldAccounts = oldAccounts;

        this.filter = new AccountFilter();
        this.validator = new AccountValidator();
        this.enricher = new AccountEnricher();
    
    }

    override
    public void beforeInsert() {
        validateDocumentNumber ();
    }
    
    
    override
    public void beforeUpdate() {
        validateDocumentNumber ();
    }

    override
    public void afterInsert() {
       validateCategoryAndAnualRevenue ();
    }

    virtual
    public void validateDocumentNumber () {

        List<Account> filteredAccounts = this.filter.filterByChangedDocumentNumber(newAccounts,oldAccounts);
        this.validator.validateDocumentNumber(filteredAccounts);

    }

    virtual
    public void validateCategoryAndAnualRevenue () {

        List<Account> filteredAccounts = this.filter.filterByCategoryAndAnualRevenue(newAccounts);
        this.enricher.createEventOnAccount(filteredAccounts);

    }


}
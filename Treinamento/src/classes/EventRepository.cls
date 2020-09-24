/**
 * @author walmeida
 */

public class EventRepository {
    
    virtual
    public List<Event> findByAccount (List<Account> account) {
        return [SELECT Description, Subject, StartDateTime
                                    ,EndDateTime, WhatId, ContactType__c FROM Event WHERE WhatId IN :account];
    }

    virtual
    public List<Event> create (List<Event> events) {
        insert events;
        return events;
    }

}
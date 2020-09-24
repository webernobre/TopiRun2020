public class AccountEnricher {

    EventRepository eventRepository = new EventRepository();

    public void createEventOnAccount(List<Account> newAccounts){
        List<Event> event = new List<Event>();
        for (Account account: newAccounts){
            event.add(new Event(
                                Description = 'Apresentar o portifolio de Produtos para o novo cliente com enfoque em nossa carteira Premium',
                                Subject = 'Apresentação instucional dos produtos Premium',
                                StartDateTime = account.CreatedDate.addHours(1) ,
                                EndDateTime = account.CreatedDate.addHours(2),
                                WhatId = account.Id,
                                ContactType__c = 'Telefônico'
                                ));
        }

        eventRepository.create(event);

        
    }

}
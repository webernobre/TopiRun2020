/**
 * @author walmeida
 */
public virtual class Customer {

    //
    public Decimal amount;
    protected Double descount;
    
    String name;
    String status;
    
    CustomerType type;

    //
    List<Contact> contacts = new List<Contact>();

    Set<Contact> createdContacts;

    // index
    Map<String, Contact> regionContacts = new Map<String, Contact> {
        'SP' => new Contact ( FirstName = 'Weber' )
        , 'SP' => new Contact ( FirstName = 'WeberNobre' )
    };
    
    // agrupando
    Map<String, List<Contact>> contactsByRegion = new Map<String, List<Contact>> {
        'SP' => new List<Contact> { new Contact ( FirstName = 'Weber' ) }
        , 'SP' => new List<Contact> { new Contact ( FirstName = 'WeberNobre' ) }
    };
    
    public List<Contact> filterContactsByRegion () {
        
        List<Contact> contacts = new List<Contact>();

        for (Contact contact : this.contacts) {

            if ( contact.Name == 'XXXX' ) {
                contacts.add(contact);
            }

        }

        return contacts;
        
    }





    // [modificadores] <Tipo de Retorno> nomeDoMetodo ([Parametros...])  {}
    //    
    // [public | protected | private | default ]
    virtual
    public void save () {

        String value = '';

    }

    enum CustomerType {        
        PRIME, STANDARD, PREMIUM
    }

}
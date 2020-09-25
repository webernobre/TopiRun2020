/**
 * @author walmeida
 */
import { LightningElement } from 'lwc';
 
export default class AccountBillingAddress extends LightningElement {
    
    billingAddress;

    constructor () {
        super();
        console.log('AccountBillingAddress constructor');
        this.billingAddress = {
            street :'Rua de casa',
            streetNumber : '456',
            streetAditionalInfo :'apto 984',
            city : 'Joinville',
            state : 'SC',
            zipcode :'12252700'
        }
    }

    connectedCallback(){
        console.log('connectedCallback ');
    }

    renderedCallback(){
        console.log('renderedCallback');
    }

}
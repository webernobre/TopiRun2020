/**
 * @author walmeida
 */
import { api, LightningElement } from 'lwc';
 
export default class EditAddress extends LightningElement {

    @api
    address;

    constructor () {
        super();
        console.log('EditAddress constructor');
        this.address = {
            street :'Rua XYZ',
            streetNumber : '123',
            streetAditionalInfo :'apto 102',
            city : 'Joinville',
            state : 'SC',
            zipcode :'12222000'
        }
    }

    connectedCallback(){
        console.log('connectedCallback ');
    }

    renderedCallback(){
        console.log('renderedCallback');
    }
    
    handleSearchedAddress(event){

        console.log(JSON.stringify(event.detail));
        this.address = event.detail;

    }
}
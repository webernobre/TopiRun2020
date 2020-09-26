/**
 * @author walmeida
 */
import { api, LightningElement } from 'lwc';
 
export default class EditAddress extends LightningElement {

    @api
    address;
    
    set localAddress(address){

        this._address=Object.assign(address);
        this.dispatchChangedAddress();
    
    }

    get localAddress(){
        return this._address;
    }

    constructor () {
        super();
        console.log('EditAddress constructor');
        this.address = {
            street :'Rua XYZ',
            streetNumber : '123',
            streetAditionalInfo :'apto 102',
            city : 'Joinville',
            state : 'SC',
            zipCode :'12222-000'
        }
    }

    connectedCallback(){
        console.log('connectedCallback ');
        this.localAddress=this.address;
    }

    renderedCallback(){
        console.log('renderedCallback');
    }
    
    handleSearchedAddress(event){

        console.log(JSON.stringify(event.detail));
        this.address = event.detail;
        this.localAddress=event.detail;

    }

    dispatchChangedAddress(){
        let changedAddressEvent = new CustomEvent('addresschanged', {detail : this.localAddress});
        this.dispatchEvent(changedAddressEvent);
    }

    handleChange(event){
        console.log(event);
        this.localAddress = Object.assign(this.localAddress, {
            [event.target.name]: event.target.value
        });
    }
}
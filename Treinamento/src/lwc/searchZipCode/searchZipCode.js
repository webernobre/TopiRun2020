/**
 * @author walmeida
 */
import { api, LightningElement } from 'lwc';
import searchAddress from '@salesforce/apex/SearchAddressCtrl.searchAddress';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 
export default class SearchZipCode extends LightningElement {

    @api
    zipCode;

    constructor () {
        super();
        console.log('SearchZipCode constructor');
    }

    connectedCallback(){
        console.log('connectedCallback ');
    }

    renderedCallback(){
        console.log('renderedCallback');
    }

    handleBlur(event){
        
        if (!event.target.value
            || event.target.value == this.zipCode) return;
        
        let _zipCode = Object.assign(event.target.value.replace('-',''));

        searchAddress({ zipCode : _zipCode}).then(response =>{
            let address = response;
            this.publishAddressChanged(address);
  
        }).catch (response => {
            let component = this.template.querySelector("[data-name='zipCode']");
            component.setCustomValidity(response.body.message);
            component.reportValidity();
            /*const toast = new ShowToastEvent({
                variant: 'error',
                title: 'Erro no serviço',
                message: 'Serviço indisponível)',
            });
            this.dispatchEvent(toast);*/
        });
        console.log('final do blur');
        
    }

    publishAddressChanged(address){

        let searchedAddressEvent = new CustomEvent('searchedaddress',{ 
            detail : address
        });
        this.dispatchEvent(searchedAddressEvent);

    }
}
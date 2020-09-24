/**
 * @author walmeida
 */


import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class NewCase extends LightningElement {

    handleSucess(event) {
        const toast = new ShowToastEvent({
            variant: 'success',
            title: 'Case Success Created',
            message: 'Caso criado com sucesso!!! ;)',
        });
        this.dispatchEvent(toast);
    }


}
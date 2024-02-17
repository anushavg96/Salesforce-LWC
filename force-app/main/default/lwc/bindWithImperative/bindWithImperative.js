import { LightningElement,wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccController.getAccList';

export default class BindWithImperative extends LightningElement {
    accounts;
    error;
    // imperative way method
    handleClick() {
        getAccountList()
            .then((result) => {
               this.accounts = result;
               this.error = undefined;
            })
            .catch((error) => {
                this.error = error;
                this.accounts = undefined;
            });
    }
}
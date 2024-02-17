import { LightningElement, track } from 'lwc';
import findAccounts from '@salesforce/apex/AccController.findAccounts';
const DELAY = 350;
export default class SearchPage extends LightningElement {
    @track accounts;
    @track error;
    handleKeyChange(event) {
        //Debouncing this method: Do not actually invoke  the apex  call as long as this function is
        // being called within a DELAY. this is to avoid a very large number of apex method calls
        window.clearTimeout(this.delayTimeout);
        const keyword = event.target.value;
        //eslint-disable-next-line @lwc/lwc/no-async-operation
        this.delayTimeout = setTimeout(() => {
            findAccounts({ keyword })
            .then(result => {
                this.accounts = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.accounts = undefined;
            });
        },DELAY);
    }
}
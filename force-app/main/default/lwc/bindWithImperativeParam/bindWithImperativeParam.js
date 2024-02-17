import { LightningElement } from 'lwc';
import findAccountList from '@salesforce/apex/AccController.findAccList';
export default class BindWithImperativeParam extends LightningElement {
    searchKey = '';
    accounts;
    error;
    //imperative with param
    handleOnChange(event){
        this.searchKey = event.target.value;
    }
     // imperative way method
     handleClick() {
        findAccountList({keyword:this.searchKey})
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
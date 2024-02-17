import { LightningElement, wire } from 'lwc';
import getAccList from "@salesforce/apex/AccountController.getAccList";
export default class GetAccountList extends LightningElement {
    @wire(getAccList) accounts;
    handleSelect(event) {
        console.log('###Id:'+event.currentTarget.dataset.accountId);
        console.log('###Name:'+event.currentTarget.dataset.accountName);

        const selectEvent = new CustomEvent("accountselect", {
            detail: {
                accountId: event.currentTarget.dataset.accountId,
                accountName: event.currentTarget.dataset.accountName
            }
        });
        this.dispatchEvent(selectEvent);
    }
}
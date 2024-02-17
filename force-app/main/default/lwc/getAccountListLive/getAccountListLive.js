import { LightningElement, wire} from 'lwc';
import GetAccountList from "@salesforce/apex/AccountListController.getAccList";
export default class GetAccountListLive extends LightningElement {
    @wire(GetAccountList) accounts;
}
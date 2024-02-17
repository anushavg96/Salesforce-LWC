import { LightningElement, wire } from 'lwc';
import getAccList from '@salesforce/apex/AccController.getAccList';
export default class BindWireWithProperty extends LightningElement {
    @wire(getAccList) accounts;
}
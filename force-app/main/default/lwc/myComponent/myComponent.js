import { LightningElement, api } from 'lwc';

export default class MyComponent extends LightningElement {
    @api firstName = 'Anusha';
    @api strTitle = 'Welcome in Salesforce';
    @api showImage = false;
    @api imageURL = '';
}
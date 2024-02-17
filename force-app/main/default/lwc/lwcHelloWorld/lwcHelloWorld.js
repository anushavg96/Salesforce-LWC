import { LightningElement, api } from 'lwc';

export default class LwcHelloWorld extends LightningElement {
    //name="Salesforce Bolt";
    @api name;
    // call function from aura cmp
    @api
    callMe() {
        console.log("####Hello World!");
    }

}
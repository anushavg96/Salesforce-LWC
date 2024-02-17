import { LightningElement } from 'lwc';

export default class AnotherChild extends LightningElement {
    constructor() {
        super();
        console.log("####Constructor of 2nd Child");
    }
    connectedCallback() {
        console.log("####ConnectedCallBack of 2nd Child"); 
    }
    renderedCallback() {
        console.log("####RenderedCallBack of 2nd Child");  
    }
}
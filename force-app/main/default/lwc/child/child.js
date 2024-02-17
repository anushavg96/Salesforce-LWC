import { LightningElement } from 'lwc';

export default class Child extends LightningElement {
    constructor() {
        super();
        console.log("####Constructor of Child");
    }
    connectedCallback() {
        console.log("####ConnectedCallBack of Child"); 
    }
    renderedCallback() {
        console.log("####RenderedCallBack of Child");  
    }
}
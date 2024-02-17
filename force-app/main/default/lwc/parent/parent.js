import { LightningElement } from 'lwc';

export default class Parent extends LightningElement {
    constructor() {
        super();
        console.log("####Constructor of Parent");
    }
    connectedCallback() {
        console.log("####ConnectedCallBack of Parent"); 
    }
    renderedCallback() {
        console.log("####RenderedCallBack of Parent");  
    }
}
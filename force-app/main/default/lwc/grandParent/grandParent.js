import { LightningElement } from 'lwc';

export default class GrandParent extends LightningElement {
    constructor() {
        super();
        console.log("####Constructor of GrandParent");
    }
    connectedCallback() {
        console.log("####ConnectedCallBack of GrandParent"); 
    }
    renderedCallback() {
        console.log("####RenderedCallBack of GrandParent");  
    }
}
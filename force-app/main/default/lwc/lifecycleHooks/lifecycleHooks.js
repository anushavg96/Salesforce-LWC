import { LightningElement } from 'lwc';

export default class LifecycleHooks extends LightningElement {
    myList = [];
    constructor() {
        super();
        console.log('constructor');
    }
    connectedCallback() {
        this.myList.push("Salesforce Bolt");
        console.log('ConnectedCallBack');
    }
    disconnectedCallback() {
        this.myList = [];
        console.log('DisConnetedCallBack');
    }
    renderedCallback() {
        console.log("RenderedCallBack");
    }
    errorCallback(error, stack) {
console.log("Error Call Back: "+error);
    }
}
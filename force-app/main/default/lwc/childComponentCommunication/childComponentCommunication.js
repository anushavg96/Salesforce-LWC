import { LightningElement } from 'lwc';

export default class ChildComponentCommunication extends LightningElement {
    endValue = 5;

    handleOnClick() {
       // this.dispatchEvent(new CustomEvent('increasecount'));
       const myEventWithValue = new CustomEvent('increasecount',{
        detail: {
            endValue:this.endValue,
            msg: "Hello from Saleforce Bolt"
        }
       });
       this.dispatchEvent(myEventWithValue);
    }
}
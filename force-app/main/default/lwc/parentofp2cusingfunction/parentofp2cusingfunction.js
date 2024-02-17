import { LightningElement } from 'lwc';

export default class Parentofp2cusingfunction extends LightningElement {
    handleClick() {
        this.template.querySelector('c-childofp2cusingfunction').refresh();
    }
}
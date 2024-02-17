import { LightningElement, api } from 'lwc';

export default class Childofp2cusingfunction extends LightningElement {
    timestamp = new Date();
    @api
    refresh() {
        this.timestamp = new Date();
    }
}
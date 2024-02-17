import { LightningElement, api } from 'lwc';

export default class SampleHeadlessAction extends LightningElement {
    @api invoke() {
        console.log('####Hello World');
    }
}
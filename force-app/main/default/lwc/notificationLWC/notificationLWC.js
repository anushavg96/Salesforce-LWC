import { LightningElement } from 'lwc';
import LightningAlert from "lightning/alert";
import LightningPrompt from "lightning/prompt";
import LightningConfirm from "lightning/confirm";
export default class NotificationLWC extends LightningElement {
    async handleAlert(){
        await LightningAlert.open({
            message: "Sample Alert Message",
            theme: "error",
            label: "Alert Header"
        }).then(() => {
            console.log('###Alert Closed');
        });
    }
    async handleConfirm(){
        const result = await LightningConfirm.open({
            message: "Sample Confirm Message",
            theme: "Success",
            label: "Confirm Header"
        });
            console.log('###Result: ',result);
        
    }
    async handlePrompt(){
        await LightningPrompt.open({
            message: "Sample Prompt Message",
            theme: "error",
            label: "Prompt Header",
            defaultValue: "Test"
        }).then((result) => {
            console.log('###Result: ',result);
        });
    }
}
import { LightningElement } from 'lwc';

export default class MapLWC extends LightningElement {
    mapMarkers;
    connectedCallback() {
        this.mapMarkers = [{
            location: {
                city: "Berlin",
                country: "Germany",
                PostalCode: "10711",
                State: "Berlin",
                Street: "Hektorstraße 11"
            },
            title: "Saleforce Bolt",
            description: "I am here",
            icon: "standard:account"
        },
        {
            location: {
                city: "Berlin",
                country: "Germany",
                PostalCode: "10711",
                State: "Berlin",
                Street: "StuttgarterPlatz 6"
            },
            title: "Test Location",
            description: "Success!",
            icon: "standard:account"
        }];
    }
}
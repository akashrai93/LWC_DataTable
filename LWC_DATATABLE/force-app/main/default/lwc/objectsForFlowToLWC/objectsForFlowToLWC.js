import { api, LightningElement, track } from 'lwc';

export default class ObjectsForFlowToLWC extends LightningElement {
    @track _contacts = [];
    set(contacts = []) {
        this._contacts = [...contacts];
    }

    @api get contacts() {
        return this._contacts;
    }

    get items() {
        let contactEmailArray = this._contacts.map((curritem) => {
            return {
                type: 'icon',
                label: curritem.Email,
                name: curritem.Email,
                iconName: 'standard:contact',
                alternativeText: 'Contact Email',
            }
        });
        return contactEmailArray;
    }
}
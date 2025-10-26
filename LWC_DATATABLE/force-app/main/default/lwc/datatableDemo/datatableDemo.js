import { LightningElement, wire } from 'lwc';
//import fetchContact from '@salesforce/apex/ContactController.fetchContact';

const columns = [
    { label: 'Contact Name', fieldName: 'Name' },
    {
        label: 'accountLink', fieldName: 'accountLink', type: 'url',
        typeAttributes: {
            label: {
                fieldName: 'accountName'
            },
            target: "_blank"
        }
    },
    {
        label: 'Title', fieldName: 'Title', cellAttributes: {
            class: {         //"slds_theme_shade slds-theme_alert-texture"
                fieldName: "slds-text-color_success"
            }
        }
    },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' }
]

export default class DatatableDemo extends LightningElement {

    contacts;
    column = columns;
    @wire(fetchContact)
    contactdata({ data, error }) {
        if (data) {
            //console.log('data : ', data);
            this.contacts = data.map(record => {
                let accountLink = "/" + record.AccountId;
                let accountName = record.Account.Name;
                return {
                    ...record,
                    accountLink: accountLink,
                    accountName: accountName
                }
            })

        } else if (error) {
            console.error('error : ', error);
        }
    }
}
import { LightningElement, wire } from 'lwc';
import { subscribe, unsubscribe, MessageContext } from 'lightning/messageService';
import siblingData from '@salesforce/messageChannel/sendMessage__c';

export default class SubscriberOneComponent extends LightningElement {
    display = 'standard';

    @wire(MessageContext)
    messProp;

    connectedCallback() {
        subscribe(this.messProp, siblingData, (m) => {
            this.display = m.recordId;
        })
    }
}
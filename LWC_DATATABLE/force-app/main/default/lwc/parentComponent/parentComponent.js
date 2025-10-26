import { api, LightningElement, wire } from 'lwc';
import { subscribe, unsubscribe, MessageContext } from 'lightning/messageService';
import lmsdata from '@salesforce/messageChannel/sendMessage__c';

export default class ParentComponent extends LightningElement {

    childButton = 'Child Button';
    // clickHandler() {
    //     let eventCus = new CustomEvent('fire', {
    //         detail: 'data from child'
    //     });
    //     this.dispatchEvent(eventCus);
    // }

    // @api triggerFromParent() {
    //     this.clickHandler();
    // }

    @wire(MessageContext)
    messageProp;

    connectedCallback() {
        subscribe(this.messageProp, lmsdata, (message) => this.handleMessage(message));
    }

    handleMessage(m) {
        this.childButton = m.recordId;
    }
}
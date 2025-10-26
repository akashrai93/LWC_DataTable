import { LightningElement, wire } from 'lwc';
import { MessageContext, publish } from 'lightning/messageService';
import lmsdata from '@salesforce/messageChannel/sendMessage__c';

export default class ParComp extends LightningElement {
    message = 'Parent Component';
    htmessage = 'parent message';

    @wire(MessageContext)
    messageProp;


    // fireHandler(e) {
    //     this.htmessage = e.detail;
    // }
    parentButtonHandler() {
        // this.template.querySelector('c-parent-component').triggerFromParent();
        // console.log('parent trigger');

        const payload = { recordId: 'message prop sibling comp' }
        publish(this.messageProp, lmsdata, payload);
    }

}
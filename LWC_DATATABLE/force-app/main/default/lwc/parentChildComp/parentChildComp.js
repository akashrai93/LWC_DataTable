import { LightningElement } from 'lwc';

export default class ParentChildComp extends LightningElement {
    parentComponentTitle = 'parent comp';
    parentButtonLabel = 'parent button';

    handleChildEvent(e) {
        this.parentComponentTitle = e.detail.title;
        this.parentButtonLabel = e.detail.buttonlabel;
    }
    parentButtonClickHandler() {
        this.template.querySelector('c-child-parent-comp').childmessagetoparent();
        console.log('parent - child comp');
    }
}
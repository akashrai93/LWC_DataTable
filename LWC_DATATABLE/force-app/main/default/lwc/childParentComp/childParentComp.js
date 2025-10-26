import { api, LightningElement } from 'lwc';

export default class ChildParentComp extends LightningElement {

    title = 'childParentComponent - title receive from child';
    buttonlabel = 'button label from child';
    childClickHandler() {
        const customEv = new CustomEvent('childevent', {
            detail: {
                title: this.title,
                buttonlabel: this.buttonlabel
            }
        });
        this.dispatchEvent(customEv);
    }

    @api childmessagetoparent() {
        this.childClickHandler();
    }
}
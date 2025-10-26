import { api, LightningElement } from 'lwc';
import { FlowAttributeChangeEvent } from 'lightning/flowSupport';

export default class LwcFlowCalculator extends LightningElement {
    @api number1;
    @api number2;
    @api outputResult;

    clickHandler(e) {
        let name = e.target.name;
        if (name === 'add') {
            this.outputResult = this.number1 + this.number2;
        } else if (name === 'sub') {
            this.outputResult = this.number1 - this.number2;
        } else if (name === 'mul') {
            this.outputResult = this.number1 * this.number2;
        } else if (name === 'div') {
            this.outputResult = this.number1 / this.number2;
        }

        const attributeChangeEvent = new FlowAttributeChangeEvent('outputResult', this.outputResult);
        this.dispatchEvent(attributeChangeEvent);

    }
}
import { LightningElement, wire, api } from 'lwc';
import oppConRole from '@salesforce/apex/ContactController.fetchOppConRole';

export default class OpportunityContactRoleDatatable extends LightningElement {
    conroledata;
    @api recordId;
    @wire(oppConRole, {
        oppId: "$recordId"
    })
    conOppData({ data, error }) {
        if (data) {
            this.conroledata = data;
            console.log('data : ', data);
        } else if (error) {
            console.error('error : ', error);
        }
    }
}
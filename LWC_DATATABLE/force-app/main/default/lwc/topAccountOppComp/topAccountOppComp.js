import { api, LightningElement } from 'lwc';
const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Stage Name', fieldName: 'StageName' },
    { label: 'Amount', fieldName: 'Amount' },
    { label: 'Lead Source', fieldName: 'LeadSource' }
]
export default class TopAccountOppComp extends LightningElement {
    @api oppData = [];
    column = columns;
}
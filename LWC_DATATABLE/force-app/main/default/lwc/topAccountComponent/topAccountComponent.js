import { LightningElement, wire } from 'lwc';
import fetchTopAccount from '@salesforce/apex/ApexToLWC.fetchTopAccount';
const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Rating', fieldName: 'Rating' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
]
export default class TopAccountComponent extends LightningElement {
    data = [];
    column = columns;
    oppData;
    relatedOppData = [];
    componentTitle = 'Account Records';
    @wire(fetchTopAccount)
    getAccountRecords({ error, data }) {
        if (data) {
            this.data = data;
            console.log('data : ', data);
        } else if (error) {
            console.log(error.message.body);
        }
    }

    rowSelectionHandler(event) {
        this.oppData = true;
        const selectedRow = event.detail.selectedRows;
        const row = selectedRow;
        this.relatedOppData = row[0].Opportunities;
        console.log('selected row : ', row[0].Opportunities);
    }

}
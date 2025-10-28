import { LightningElement, wire } from 'lwc';
import fetchTopAccount from '@salesforce/apex/ApexToLWC.fetchTopAccount';
const columns = [
    {
        label: 'Name', fieldName: 'accountUrl', type: 'url',
        typeAttributes: {
            label: {
                fieldName: 'Name'
            },
            target: "_blank"
        }
    },
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Rating', fieldName: 'Rating' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
]
export default class TopAccountComponent extends LightningElement {
    data = [];
    column = columns;
    oppData;
    relatedOppData = [];
    selectedAccountName;
    @wire(fetchTopAccount)
    getAccountRecords({ error, data }) {
        if (data) {
            this.data = data.map(record => ({
                ...record,
                accountUrl: '/' + record.Id
            }))
        } else if (error) {
            console.log(error.message.body);
        }
    }


    rowSelectionHandler(event) {
        this.oppData = true;
        const selectedRow = event.detail.selectedRows;
        const row = selectedRow;
        this.selectedAccountName = row[0].Name + ' opportunities';
        console.log('Account Name : ', this.selectedAccountName);
        this.relatedOppData = row[0].Opportunities;
        console.log('selected row : ', row[0].Opportunities);
    }

}
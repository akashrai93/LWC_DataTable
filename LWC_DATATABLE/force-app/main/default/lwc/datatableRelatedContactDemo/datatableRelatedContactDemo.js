import { api, LightningElement, wire } from 'lwc';
import fetchRelatedContactAccount from '@salesforce/apex/ContactController.fetchRelatedContactAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { updateRecord } from 'lightning/uiRecordApi';
const columns = [
    { label: "First name", fieldName: "FirstName", editable: true },
    { label: "Last Name", fieldName: "LastName", editable: true },
    { label: "Phone", fieldName: "Phone", type: "Phone" },
    { label: "Email", fieldName: "Email", type: "url" }
]
export default class DatatableRelatedContactDemo extends LightningElement {

    @api recordId;
    columns = columns;
    contactListData = [];
    draftValue;

    @wire(fetchRelatedContactAccount,
        {
            accountId: "$recordId"
        }
    )
    contactData({ data, error }) {
        if (data) {
            this.contactListData = data;
            //console.log('data : ', data);
        } else if (error) {
            console.error('error : ', error);
        }
    }

    async saveHandler(event) {
        this.draftValue = event.detail.draftValues;
        let updateRecordArray = this.draftValue.map(curritem => {
            let fv = { ...curritem };
            return {
                fields: fv
            }
        });
        this.draftValue = [];
        updateRecordArray.map(curritem => {
            updateRecord(curritem).then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "records updated",
                        message: "updated successfully",
                        variant: "success"
                    })
                )
            }).catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "records error",
                        message: error.body.message,
                        variant: "error"
                    })
                )
            })
        });

    }

}
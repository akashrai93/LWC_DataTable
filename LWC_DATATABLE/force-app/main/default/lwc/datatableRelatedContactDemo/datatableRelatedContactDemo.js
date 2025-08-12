import { api, LightningElement, wire } from 'lwc';
import fetchRelatedContactAccount from '@salesforce/apex/ContactController.fetchRelatedContactAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from "@salesforce/apex";

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
    contactrefreshprop;
    @wire(fetchRelatedContactAccount,
        {
            accountId: "$recordId"
        }
    )
    contactData(result) {
        this.contactrefreshprop = result
        if (result.data) {
            this.contactListData = result.data;
            //console.log('data : ', data);
        } else if (result.error) {
            console.error('error : ', result.error);
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
        let updateRecordArrayPromise = updateRecordArray.map(curritem => {
            updateRecord(curritem);
        });

        await Promise.all(updateRecordArrayPromise);

        this.dispatchEvent(
            new ShowToastEvent({
                title: "record updated",
                message: "record updated successfully",
                variant: "success"
            })
        );

        await refreshApex(this.contactrefreshprop);
    }
}
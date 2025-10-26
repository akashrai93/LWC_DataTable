import { LightningElement, wire } from 'lwc';
import getallcases from '@salesforce/apex/CaseController.getOpenCase';
import updatecase from '@salesforce/apex/CaseController.updateCaseRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const columnss = [
    { label: "Case Number", fieldName: "CaseNumber" },
    { label: "Account Name", fieldName: "AccountName" },
    { label: "Contact Name", fieldName: "ContactName" },
    { label: "Status", fieldName: "Status" }
]

export default class CaseManagement extends LightningElement {
    casesProccessed = [];
    accountId = null;
    columns = columnss;
    selectedCaseRecord = [];
    noStaleData;
    @wire(getallcases, {
        accId: "$accountId"
    }) caseData(result) {
        this.noStaleData = result;
        if (result.data) {
            //console.log('main data : ', data);
            this.casesProccessed = result.data.map(item => ({
                ...item,
                "AccountName": item.Account?.Name || "N/A",
                "ContactName": item.Contact?.Name || "N/A"
            }));
            //console.log('data : ', this.casesProccessed);
        } else if (result.error) {
            console.error('error : ', result.error);
        }
    }
    //when a record is selected from a record picker
    changeHandler(event) {
        this.accountId = event.detail.recordId;
    }
    //when close button clicks
    clickHandler() {
        let caseIds = this.selectedCaseRecord.map(item => item.Id);
        //console.log('caseIds : ', caseIds);
        //console.log('caseIds : ', JSON.stringify(caseIds));

        updatecase({ caseId: caseIds }).then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Record Updated",
                    message: "Selected cases are closed",
                    variant: "success"
                })
            )
            refreshApex(this.noStaleData);
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Record updation failed",
                    message: error,
                    variant: "failed"
                })
            )
        })
        this.selectedCaseRecord = [];
    }
    //when case record are selected from data table
    handlerRowSelection(event) {
        this.selectedCaseRecord = event.detail.selectedRows;
        //console.log('selected data : ', JSON.stringify(this.selectedCaseRecord));
    }
    get totalOpenCases() {
        return this.casesProccessed.length;
    }
    get totalSelectedCases() {
        return this.selectedCaseRecord.length;
    }
    get isDataAvailable() {
        return this.casesProccessed.length > 0;
    }
    get isDisabled() {
        this.selectedCaseRecord.length != 0;
    }
}
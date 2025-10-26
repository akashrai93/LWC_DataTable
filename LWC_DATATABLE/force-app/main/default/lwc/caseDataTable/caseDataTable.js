import { LightningElement, wire } from 'lwc';
import getallcases from '@salesforce/apex/CaseController.getAllCases';

export default class CaseDataTable extends LightningElement {

    selectedUser = null;
    /*
    @wire(getallcases,
        {
            userId: "$selectedUser"
        }
    ) casedata;
*/
    changeHandler(e) {
        this.selectedUser = e.detail.recordId;
    }
}
import { LightningElement } from 'lwc';
import getAccountHierachy from '@salesforce/apex/CFEXDataService.getAccountHierachy';

export default class AccountHierachy extends LightningElement {
    items=[];
    connectedCallback(){
        getAccountHierachy()
        .then((result)=>{
            this.items = result;
        }).catch((error)=>{
            console.log('error: ',error);
        })
        
    }
}
public with sharing class platformEventTriggerHelper {
    
    public static void createAccountPlatformTriggerEvent(list<Order_Detail__e> orderlist){
        list<Account> acclist = new list<Account>();
        list<task> tasklist = new list<task>();
        for(Order_Detail__e od : orderlist){
            Account acc = new Account();
            acc.Name = od.Order_Number__c;
            acc.Description = String.valueOf(od.Invoice_Created__c);
            acclist.add(acc);

            task tt = new task();
            tt.subject = od.Order_Number__c;
            tt.Status = 'In Progress';
            tt.Priority = 'High';
            tasklist.add(tt);
        }

        //if(!acclist.isEmpty()){
        try {
            system.debug('account printed');
            insert acclist;
            insert tasklist;   
        } catch (Exception e) {
            system.debug('error'+e.getMessage());
        }
       // }
    }
}
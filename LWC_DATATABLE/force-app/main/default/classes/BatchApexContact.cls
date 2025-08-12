public class BatchApexContact implements Database.Batchable<sObject> {
	
    public map<Id, String> conAccId;
    public set<Id> ccId ;
    public BatchApexContact(map<Id, String> conmap){
         this.conAccId = conmap;
        this.ccId = conmap.Keyset();
    }
    public Database.queryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id, AccountId, Phone From Contact Where AccountId IN: ccId');
    }
    
    public void execute(Database.BatchableContext bc, list<Contact> conlist){
        if(!conlist.isEmpty()){
            
            list<Contact> newContactList = new list<Contact>();
            for(Contact con : conlist){
                if(conAccId.containsKey(con.AccountId)){
                    con.Phone = conAccId.get(con.AccountId);
                    newContactList.add(con);
                }
            }
            if(!newContactList.isEmpty()){
                update newContactList;
            }
        }
        
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('-----finish------Child Batch Apex');
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { 'akashrai93@live.in' });
        mail.setSubject('Batch Apex Job Complete');
        mail.setPlainTextBody('The batch job has completed successfully.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}
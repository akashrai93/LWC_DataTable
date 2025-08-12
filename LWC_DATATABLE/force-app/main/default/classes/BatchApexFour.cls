public class BatchApexFour implements Database.Batchable<sObject>, Database.Stateful{
    
    //public set<Id> accIds;
    public map<Id, String> accIds = new map<Id, String>();
    public Database.queryLocator start(Database.BatchableContext bc){
        DateTime now = DateTime.now();
        Datetime t = now.addDays(-1);
        return Database.getQuerylocator('Select Id, Name, Phone From Account Where Phone != null');
        //and createdDate <=: now and createdDate >=:t
    }
    public void execute(Database.BatchableContext bc, list<Account> acclist){
        if(!acclist.isEmpty()){
            system.debug('execute method');
            for(Account acc : acclist){
                if(acc.Phone != null){
                    acc.Name = acc.Name + 'Batch Apex';
                    accids.put(acc.Id, acc.Phone);
                }
            }
            If(!accIds.isEmpty()){
                update acclist;
            }
        }
    }
    public void finish(Database.BatchableContext bc){
        if(!accIds.isEmpty()){
            system.debug('finish method parent');
            BatchApexContact updateContactPhone = new BatchApexContact(accids);
            Database.executeBatch(updateContactPhone, 200);
            //Database.executeBatch(new BatchApexContact(accIds));
        }
    }
}
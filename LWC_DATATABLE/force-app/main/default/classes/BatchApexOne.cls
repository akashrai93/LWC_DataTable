public class BatchApexOne implements Database.Batchable<sObject>, Database.Stateful{
    
    public Integer countRec = 0;
    public Database.Querylocator start(Database.BatchableContext bc){
        String str = '%Batch%';
        return Database.getQuerylocator('Select Id, Name From Account Where Name like : str ');
    }
    public void execute(Database.BatchableContext bc, list<Account> acclist){
        if(!acclist.isEmpty()){
            countRec += acclist.size();
            for(Account acc : acclist){
                acc.Active__c = 'No';
            }
            try{
                update acclist;
            }catch(Exception e){
                system.debug(e);
            }
        }
    }
    public void finish(Database.BatchableContext bc){
        system.debug('Count of record------------------->'+countRec);
    }
}
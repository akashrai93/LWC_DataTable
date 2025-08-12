public class BatchApexQues implements Database.Batchable<sObject> {
    
    
    public Database.Querylocator start(Database.BatchableContext bc){
        DateTime now = DateTime.now();
        Datetime d = now.adddays(-2);
        return Database.getQuerylocator('Select Id From Case Where createdDate <=: now and createdDate >=: d');
    }
    
    public void execute(Database.BatchableContext bc, list<Case> scope){
        system.debug(scope);
        if(!scope.isEmpty()){
            try{
                delete scope;
            }catch(Exception e){
                system.debug('error---->'+e);
            }
        }
    }
    public void finish(Database.BatchableContext bc){
        system.debug('----finish method executed----');
    }
}
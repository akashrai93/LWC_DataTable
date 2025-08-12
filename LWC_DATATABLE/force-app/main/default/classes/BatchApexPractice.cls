public class BatchApexPractice implements Database.Batchable<sObject>, Database.stateful{
    
    public Integer countRec = 0;
    public Database.Querylocator start(Database.BatchableContext bc){
        //DateTime now = DateTime.now();
        //return Database.getQuerylocator('Select Id, Subject From Case Where createdDate <=: now and createdDate >=: now.addDays(-1)');
        String vr = 'Closed';
         String str = 'Select Id, Status, Description From Case Where Status !=: vr';
        return Database.getQuerylocator(str);
    }
    
    public void execute(Database.BatchableContext bc, list<Case> scope){
        if(!scope.isEmpty()){
            countRec = countRec + scope.size();
            for(Case cc : scope){
                if(cc.Status != 'Closed'){
                    cc.Description = 'Working on it';
                }
            }
            try{
                update scope;
            }catch(Exception e){
                system.debug(e);
            }
        }
        
    }
    public void finish(Database.BatchableContext bc){
        system.debug('-------Finish------countrec------->'+countRec);
    }
}
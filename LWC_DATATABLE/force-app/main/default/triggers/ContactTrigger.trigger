trigger ContactTrigger on Contact (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
	
    //ContactTriggerDispatcher.run(Trigger.OperationType);
    
    if(trigger.isBefore){
        if(trigger.isUpdate){
            DateTime dt = system.now().addHours(-1);
            DateTime crt = System.Now();
            for(Contact con : trigger.new){
                Contact cont = trigger.oldmap.get(con.Id);
                if(trigger.oldmap.get(con.Id).Id == con.Id && con.LastModifiedDate > dt && cont.Phone != con.Phone){
                    con.addError('contact was updated');
                }
            }
        }
    }
    
}
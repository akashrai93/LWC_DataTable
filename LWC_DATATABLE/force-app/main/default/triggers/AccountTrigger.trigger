trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete) {
	
   //AccountTriggerDispatcher.run(Trigger.OperationType);
    /*if(trigger.isBefore){
        if(trigger.isDelete){
            map<Id, Decimal> accmap = new map<Id, Decimal>();
            for(Account acc : trigger.old){
                accmap.put(acc.Id,0);
            }

            if(!accmap.isEmpty()){
                Decimal sum =0;
                for(Opportunity Opp : [Select Id, AccountId From Opportunity Where AccountId IN: accmap.keyset()]){
                    if(accmap.containsKey(opp.AccountId)){
                        sum += 1;
                        accmap.put(opp.AccountId, sum);
                    }
                }

                for(Account acc : trigger.old){
                    if(accmap.containsKey(acc.Id) && accmap.get(acc.Id)>2){
                        acc.addError('You cannot delete this account record');
                    }
                }
            }
        }
    }*/
}
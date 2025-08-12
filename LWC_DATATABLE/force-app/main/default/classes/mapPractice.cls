public class mapPractice {
	
    public static void method1(){
        map<Integer, Account> accmap = new map<Integer, Account>();
        for(Integer i = 1; i<=10; i++){
            Account acc = new Account();
            acc.Name = 'map practice '+i;
            accmap.put(i,acc);
        }
        
        if(!accmap.isEmpty()){
            system.debug(accmap.size());
            insert accmap.values();
        }
    }
    
    public static void method2(){
        set<Id> accids = new set<Id>();
        for(Account acc : [Select Id From Account]){
            accids.add(acc.Id);
        }
        list<AggregateResult> aggr = [Select AccountId, count(Id) totalOpps From Opportunity Where AccountId IN: accids AND isClosed = false Group by AccountId];
        for(AggregateResult agg : aggr){
            Id ids = (Id) agg.get('AccountId');
            if(accids.contains(ids)){
                system.debug('aggresult : '+agg.get('AccountId'));
            }
        }
    }
}
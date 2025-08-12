public class PracticeOne {
	
    public static void soql(){
        //String str = '%Test%';
        //list<Account> acclist = [Select Id, Name From Account where Name like: str];
        DateTime now = DateTime.now();
        list<Case> caselist = [Select Id From Case Where createdDate <=: now and createdDate >=: now.addDays(-1)];
        for(Case cc : caselist){
            system.debug(cc);
        }
        system.debug(caselist.size());
        
    }
    
    public static void AccountSOQL(){
        Datetime now = DateTime.now();
        list<Account> acclist = [Select Id, Name, Phone From Account Where Phone != null and createdDate <=: now and createdDate >=: now.addDays(-1)];
        
        system.debug(acclist.size());
        for(Account acc : acclist){
            system.debug(acc);
        }
        
    }
    
}
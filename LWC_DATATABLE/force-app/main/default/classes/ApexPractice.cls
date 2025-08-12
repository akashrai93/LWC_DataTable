public class ApexPractice {
	
    public static void soql(){
        DateTime now = DateTime.now();
        list<Case> caselist = [Select Id, Subject From Case Where createdDate <=: now and createdDate >=: now.addDays(-2)];
        system.debug(caselist.size());
    }
}
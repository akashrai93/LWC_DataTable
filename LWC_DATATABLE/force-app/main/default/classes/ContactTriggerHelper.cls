public class ContactTriggerHelper {
	
    /*Trigger 1
     * 	Find all the contacts which have a phone number and populate the same phone to account,
     * 		If Account have multiple contacts then 123,123,123,...
     */ 
    public static void updateContactPhoneOnAccountPhone(list<contact> conlist, map<Id, Contact> oldmap){
        
        map<Id, list<String>> conmap = new map<Id, list<String>>();
        
        for(Contact con : conlist){
            //if(Trigger.new){}		will also work
            if(oldmap == null){
                if(con.AccountId != null && con.phone != null){
                    if(conmap.containsKey(con.AccountId)){
                        conmap.get(con.AccountId).add(con.Phone);
                    }else{
                        conmap.put(con.AccountId, new list<String>{con.Phone});
                    }
                }
            }
            if(oldmap != null){
                if(oldmap.get(con.Id).AccountId != con.AccountId || oldmap.get(con.Id).Phone != con.Phone){
                    if(conmap.containsKey(con.AccountId)){
                       conmap.get(con.AccountId).add(con.Phone);
                       
                    }else{
                       conmap.put(con.AccountId, new list<String>{con.Phone});
                       conmap.put(oldmap.get(con.Id).AccountId, new list<String>{oldmap.get(con.Id).Phone});
                    }
                }
            }
        }
        if(!conmap.keyset().isEmpty()){
        	list<Account> acclist = [Select Id, Phone From Account Where Id IN: conmap.KeySet()];    
        
        
        
        for(Account acc : acclist){
            for(String str : conmap.get(acc.Id)){
                acc.Phone = acc.Phone==null ? str:acc.Phone + ','+str;
                /*if(acc.Phone == null){
                    acc.Phone = str;
                }else{
                    acc.Phone = acc.Phone + ','+ str;s
                }
				*/
            }
            //acc.phone = String.join(conmap.get(acc.Id), ',');	not working as expected
        }
        
        if(!acclist.isEmpty()){
            update acclist;
        }}
    }
    
    /*Trigger 2
     * 	Create an Account when a contact is created
     */ 
    public static void createAccount(list<Contact> conlist){
        
        map<Id, String> accmap = new map<Id, String>();
        list<Account> acclist = new list<Account>();
        
        for(Contact con : conlist){
        	Account acc = new Account();
            acc.name = con.LastName;
            acc.Phone = con.Phone;
        	acclist.add(acc);    
        }
        if(!acclist.isEmpty()){
            insert acclist;
        }
    }

    //Calculate all contact under the account
    
}
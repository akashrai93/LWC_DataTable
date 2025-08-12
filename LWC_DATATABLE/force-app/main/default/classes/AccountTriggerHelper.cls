public class AccountTriggerHelper {
	

    /*Trigger 3
        What is the realtionship between Account and Case object --- answer is lookUp relationship

        Write a trigger for scenario
        1. if the Account being deleted has Parent Account reparent all ites related Cases to Parent Account.
        2. if the Account doen not have a Parent Account, delete all related Cases, then delete the Account.
    */
    public static void deleteAccountAndCase(list<Account> oldacclist){
        if(!oldacclist.isEmpty()){
            map<Id, Id> accidmap = new map<Id, Id>();
            for(Account acc : oldacclist){
                accidmap.put(acc.Id, acc.ParentId);
            }

            if(!accidmap.isEmpty()){
                list<Case> caselist = [Select Id, AccountId From Case where AccountId IN: accidmap.keySet()];
                list<case> newupdatecase = new list<case>();
                list<case> caseToBeDeleted = new list<Case>();
                for(case cc : caselist){
                    if(accidmap.containsKey(cc.AccountId) && String.isNotBlank(accidmap.get(cc.AccountId))){
                        cc.AccountId = accidmap.get(cc.AccountId);
                        newupdatecase.add(cc);
                    }else{
                        caseToBeDeleted.add(cc);
                    }
                }
                try {
                    update newupdatecase;
                    delete caseToBeDeleted;
                } catch (Exception e) {
                    System.debug(e.getMessage());
                }
            }
        }
    }


    /*Trigger 1
     * 	when Account Industry = Agriculture or Biotechnology, then update the related contact description with Account's Description
     */ 
    public static void updateContactDescriptionWithAccountDescription(list<Account> acclist, map<Id, Account> oldmap){
        
        map<Id, String> accmap = new map<Id, String>();
        for(Account acc : acclist){
            if(oldmap == null){
                if(acc.Industry == 'Agriculture' || acc.Industry == 'Biotechnology'){
                    accmap.put(acc.Id, acc.Description);
                }
            }
            if(oldmap != null && acc.Industry != oldmap.get(acc.Id).industry && (acc.Industry == 'Agriculture' || acc.Industry == 'Biotechnology')){
                accmap.put(acc.Id, acc.Description);
            }
        }
        list<Contact> conlist = [Select AccountId, Description From Contact Where AccountId IN: accmap.KeySet()];
        
        for(Contact con : conlist){
            con.Description = accmap.get(con.AccountId);
        }
        update conlist;
    }
    
    /*Trigger 2
     *  Get all Account where Phone is not null and Industry is Biotechnology, create a related contact
     * 		Where Lastname = Accountname
     * 				Phone = Account Phone
     * 				Description = Account Description
     */ 			
    public static void createRelatedContact(list<Account> acclist, map<Id, Account> oldmap){
        
        map<Id, String> accmap = new map<Id, String>();
        list<Contact> conlist = new list<Contact>();
        
        for(Account acc : acclist){
            if(oldmap == null){
                if(acc.Phone != null && acc.Industry == 'Biotechnology'){
                    Contact con = new Contact();
                    con.AccountId = acc.Id;
                    con.LastName = acc.Name;
                    con.Phone = acc.Phone;
                    con.Description = acc.Description;
                    conlist.add(con);
                }
            }
            if(oldmap != null && acc.Industry == 'Biotechnology' && (acc.Industry != oldmap.get(acc.Id).industry)){
               		Contact con = new Contact();
                    con.AccountId = acc.Id;
                    con.LastName = acc.Name;
                    con.Phone = acc.Phone;
                    con.Description = acc.Description;
                    conlist.add(con);
            }
        }
        if(!conlist.isEmpty()){
            Insert conlist;
        }
    }
}
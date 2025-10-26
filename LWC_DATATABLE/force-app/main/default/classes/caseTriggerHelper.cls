public with sharing class caseTriggerHelper {
    /*
        write a trigger, when a case is created, find the contact on the basis of web email(SuppliedEmail) field, and fill that contact
    */
    public static void findContactOnEmail(list<Case> caselist){
        if(!caselist.isEmpty()){
            set<String> email = new set<String>();
            for(Case cc : caselist){
                if(String.isNotBlank(cc.SuppliedEmail)){
                    email.add(cc.SuppliedEmail);
                }
            }

            if(!email.isEmpty()){
                map<String, Id> conmap = new map<String, Id>();
                for(Contact con : [Select Id, Email From Contact Where Email IN: email]){
                    conmap.put(con.Email, con.Id);
                }

                for(Case cc : caselist){
                    if(conmap.containsKey(cc.SuppliedEmail)){
                        cc.ContactId = conmap.get(cc.SuppliedEmail);
                    }
                }
            }
        }
    }
}
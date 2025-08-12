@RestResource(URLMapping='/account')
global class createWebService {
	
    @httpPut
    global static void createAccount(){
        list<Account> acclist = new list<Account>();
        Account acc = new Account();
        acc.Name = 'test Integration';
        acc.Description = 'account created from another org';
        acclist.add(acc);
        insert acclist;
    }
    
    @httpGet
    global static list<Contact> fetchContact(){
        list<Contact> conlist = [Select Id, Name From Contact];
        return conlist;
    }
}
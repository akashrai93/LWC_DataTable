public class IntegrationPracticeOne {
	
    public static string integrationOne(){
        HTTP http = new Http();
        
        HTTPRequest hreq = new HTTPRequest();
        hreq.setEndPoint('https://api.rootnet.in/covid19-in/stats/latest');
        hreq.setMethod('GET');
        
        HTTPResponse httpres = http.send(hreq);
        
       //if(httpres.getStatusCode() == 200){
            //system.debug('print status code :'+httpres.getStatusCode());
            //system.debug(httpres.getBody());
            return httpres.getBody();
        //}
    }
    
    public static void printValueFromJSON(){
        
        string str = IntegrationPracticeOne.integrationOne();
        
        map<String, Object> m = new map<String, Object>();
        m = (map<String, Object>)JSON.deserializeUntyped(str);
        //system.debug(m.get('data'));
        
        map<string,Object> m2 = (map<String, Object>)m.get('data');
        system.debug('m2:'+m2.get('unofficial-summary'));
    }
    
}
public with sharing class IndianPostOfficeFetcher {
    @future(callout=true)
    public static void fetchPostOfficesByPincode(string pinCode, Account accountId) {
        String apiUrl = 'https://Inkd.in/gzapCfCx'+pinCode;
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndPoint(apiUrl);
        req.setMethod('GET');
        HttpResponse rep = http.send(req);
        List<String> postOfficesNamesList = new List<String>();
        if(rep.getStatusCode() == 200) {
            String responseBody = rep.getBody();
            List<Object> results = (List<Object>)JSON.deserialzeUntyped(responseBody);
            Map<String,Object> resultsMap = (Map<String,Object>)results[0];
            for(Object postOffices : (List<Object>)resultsMap.get('PostOffice')) {
                Map<String,Object> pOff = (Map<String,Object>)PostOffices;
                postOfficesNamesList.add((String)pOff.get('Name'));
            }
            String pONamesToBEUpdate = String.join(postOfficesNamesList,',');
            Account accObj = new Account();
            accObj.Id = accountId;
            accObj.Description = pONamesToBEUpdate;
            if (Account.sObjectType.getDescribe().isUpdateable()) {
                       update accObj; 
               }
             //accObj.sObjectType.getDescribe().isUpdateable()
        } else {
            System.debug('API request failed with status code'+rep.getStatusCode());
        }

    }
}
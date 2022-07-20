public with sharing class CFEXDataService {
    private static CFXResponse getCFEXAccounts(){
        CalloutUtils callout = new CalloutUtils();
        callout
            .endPoint('callout:cfex/api/data')
            .method('GET')
            .timeout(120000);
        
        HttpResponse res = callout.send();
        if(res.getStatusCode() == 200){
            CFXResponse CFXres = (CFXResponse)JSON.deserialize(res.getBody(), CFXResponse.class);
            return CFXres;
        }
        return null;
    }

    @AuraEnabled
    public static list<CFEXLightningTree> getAccountHierachy(){
        try {
            CFXResponse cfxRes = CFEXDataService.getCFEXAccounts();
            if(cfxRes == null) return new list<CFEXLightningTree>();
            if(cfxRes.data ==  null || cfxRes.data.isEmpty()) return new list<CFEXLightningTree>(); 
            return CFEXLightningTree.convertCFEX2LightningTree(CFEXDataService.getCFEXAccounts().data);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


}

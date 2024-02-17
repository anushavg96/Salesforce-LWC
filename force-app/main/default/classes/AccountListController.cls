public with sharing class AccountListController {
    @AuraEnabled(cacheable =true)
    public static List<Account> getAccList() {
        return [SELECT Id, Name, Phone, Rating FROM Account WITH SECURITY_ENFORCED ORDER BY CreatedDate];
    }
}
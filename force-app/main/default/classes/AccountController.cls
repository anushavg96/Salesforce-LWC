public with sharing class AccountController{
    @AuraEnabled(cacheable=true)
        public static List<Account> getAccList() {
         List<Account> accList = new List<Account>();
         accList = [SELECT Id,Name FROM ACCOUNT WITH SECURITY_ENFORCED];
            return accList;
        }
}
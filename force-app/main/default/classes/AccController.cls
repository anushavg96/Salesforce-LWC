public with sharing class AccController {
    
    @AuraEnabled(cacheable=true)
   public static List<Account> getAccList() {
    return [SELECT Id, Name, Phone FROM ACCOUNT WITH SECURITY_ENFORCED LIMIT 10];
   }
   @AuraEnabled
   public static List<Account> findAccList(String keyword) {
    String key='%'+keyword+'%';
    return [SELECT Id, Name, Phone FROM ACCOUNT WHERE Name Like:Key WITH SECURITY_ENFORCED LIMIT 10];

   }
   @AuraEnabled(cacheable=true)
   public static List<Account> findAccounts(String keyword) {
    String key='%'+keyword+'%';
    return [SELECT Id, Name, Phone FROM ACCOUNT WHERE Name Like:Key WITH SECURITY_ENFORCED LIMIT 10];

   }
   
}
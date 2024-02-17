public with sharing class opporunityTriggerHandler {
    public void countNumber(List<id> accountId) {
        List<Account> accList = new List<Account>();
        for(AggregateResult ars : [select count(Id)opp, AccountId from opportunity where AccountId IN: accountId WITH_SECURITY_ENFORCED Group By AccountId ]) {
            Account acc = new Account();
            acc.id = (Id)ars.get('AccountId');
            acc.Total_Opportunity__c = (Decimal)ars.get('opp');
            accList.add(acc);
        }
        if(accList.size() > 0) {
            update accList;
        }
    }
    // write a code to associate opportunity with maximum amount to the account record 

    public static void recalculatingAmount(List<opportunity> oppList) {
        set<id> accountIds = new set<id>();
        List<Account> accList = new List<Account>();
        for(opportunity opp: oppList) {
            accountIds.add(opp.AccountId);
        }
        map<id,account> existingaccMap = new map<id,account>([select Id, max_Amount_Opp__c, max_Ammount_Opp__r.Amount from account where max_Amount_Opp__c != null and Id IN: accountIds]);
        map<id,opportunity> maxAmountMap =  new map<id,opportunity>();
        for(opportunity opp: oppList) {
            if((existingaccMap != null && existingaccMap.keyset().contains(opp.AccountId) && existingaccMap.get(opp.AccountId).max_Ammount_Opp__r.Amount < opp.Amount) || (existingaccMap == null || existingaccMap.keyset().size() == 0)) {
                if(maxAmountMap != null && maxAmountMap.keyset().contains(opp.AccountId) && maxAmountMap.get(opp.AccountId).Amount < opp.Amount) {
                     maxAmountMap.put(opp.AccountId,opp);
                }
                else if(!maxAmountMap.keyset().contains(opp.AccountId)) {
                    maxAmountMap.put(opp.AccountId,opp);
                }
            }
        }
        if(maxAmountMap.keyset().size() > 0) {
            account acc;
            for(id accId: maxAmountMap.keyset()) {
                acc = new account(id=accId);
                acc.max_Amount_Opp__c = maxAmountMap.get(accId).Id;
                accList.add(acc);
            }
        }

        if(accList.size() > 0) {
            update accList;
        }
    }

    //scenario 4
    public static void deleteHandlerRecalculate(set<Id> accountIdList) {
        List<account> accList = new List<account>();
         map<id,account> existingaccMap = new map<id,account>([select Id, max_Amount_Opp__c, max_Ammount_Opp__r.Amount from account where max_Amount_Opp__c = null and Id IN: accountIdList]);
         map<id,opportunity> maxAmountMap =  new map<id,opportunity>();
         for(opportunity opp: [select Id,amount,accountId from opportunity where accountId IN : accountIdList]) {
            if(existingaccMap != null && existingaccMap.keyset.contains(opp.accountId)) {
                 if(maxAmountMap != null && maxAmountMap.keyset().contains(opp.AccountId) && maxAmountMap.get(opp.AccountId).Amount < opp.Amount) {
                     maxAmountMap.put(opp.AccountId,opp);
                }
                else if(!maxAmountMap.keyset().contains(opp.AccountId)) {
                    maxAmountMap.put(opp.AccountId,opp);
                }
         }
    }
     if(maxAmountMap.keyset().size() > 0) {
            account acc;
            for(id accId: maxAmountMap.keyset()) {
                acc = new account(id=accId);
                acc.max_Amount_Opp__c = maxAmountMap.get(accId).Id;
                accList.add(acc);
            }
        }

        if(accList.size() > 0) {
            update accList;
        }
    }
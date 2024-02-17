trigger oppTrigger on opportunity (after insert, after update, after delete, after undelete, before insert, before update) {
// write a code to capture total count of opportunity record on parent account record

if(trigger.isAfter) {
    List<Id> accountIds = new List<Id>();
    opporunityTriggerHandler othandler = new opporunityTriggerHandler();
    if(trigger.isinsert) {
        for(opportunity opp: trigger.new) {
            if(opp.accountId != null) {
                accountIds.add(opp.accountId);
            }
        }
        //scenario 4
        othandler.recalculatingAmount(trigger.new);
    }

    if(trigger.isupdate) {
        List<opportunity> oppList = new List<opportunity>();
        for(opportunity opp: trigger.new) {
            if(opp.accountId != null && trigger.oldmap.get(opp.Id).accountId != null) {
                accountIds.add(opp.accountId);
                accountIds.add(trigger.oldmap.get(opp.Id).accountId);
            }
            //scenario 4
            if(opp.Amount != trigger.oldmap.get(opp.Id).Amount) {
                oppList.add(opp);
            }
            //scenario 4
        othandler.recalculatingAmount(oppList);
        }
    }

    if(trigger.isdelete) {
        set<Id> accId = new set<Id>();
        for(opportunity opp : trigger.old) {
            if(opp.accountId != null) {
                accountIds.add(opp.accountId);
                // scenario 4
                accId.add(opp.accountId);
            }
        }
        // scenario 4
        othandler.deleteHandlerRecalculate(accId);
        
    }

    if(trigger.isundelete) {
        for(opportunity opp : trigger.old) {
            if(opp.accountId != null) {
                accountIds.add(opp.accountId);
            }
        }
    }
    othandler.countNumber(accountIds); 
} 
//Scenario 7 write logic to update max amount checkbox on opportunity based on amount on insert or update of opportunity
if(trigger.isbefore){
    if(trigger.isinsert){
        set<Id> accountId = new set<Id>();
        map<Id,opportunity> existingOppMap = new map<Id,opportunity>();
        for(opportunity opp: trigger.new) {
            accountId.add(opp.AccountId);
        }
        //create a feild of max amount of type checkbox which is unchecked
        //map of account with existing opportunity having max amount
        for(opportunity opp: [select Id,max_Account__c,amount,AccountId from opportunity where AccountId IN : accountId and max_Account__c = true WITH_SECURITY_ENFORCED]) {
            existingOppMap.put(opp.AccountId,opp);
        }
        list<opportunity> opptoUpdate = new list<opportunity>();
        for(opportunity opp: trigger.new) {
            if(existingOppMap != null && existingOppMap.keyset().contains(opp.AccountId)) {
                //checking the new opportunity amount is greater than the existing opp
                if(existingOppMap.get(opp.AccountId).amount < opp.amount) {
                opp.max_Account__c = true;
                opportunity oppOld = new opportunity();
                oppOld = existingOppMap.get(opp.AccountId);
                oppOld.max_Account__c = false;
                opptoUpdate.add(oppOld);
                }
            }
            else  {
                opp.max_Account__c = true;
            }
        }
        if(opptoUpdate.size() > 0) {
            update opptoUpdate;
        }
    }
    if(trigger.isupdate){
       set<Id> accountId = new set<Id>();
        map<Id,opportunity> existingOppMap = new map<Id,opportunity>();
        for(opportunity opp: trigger.new) {
            accountId.add(opp.AccountId);
        }
        //create a feild of max amount of type checkbox which is unchecked
        //map of account with existing opportunity having max amount
        for(opportunity opp: [select Id,max_Account__c,amount,AccountId from opportunity where AccountId IN : accountId and max_Account__c = true WITH_SECURITY_ENFORCED]) {
            existingOppMap.put(opp.AccountId,opp);
        }
        list<opportunity> opptoUpdate = new list<opportunity>();
        for(opportunity opp: trigger.new) {
            if(opp.amount != trigger.oldmap.get(opp.Id).amount) {
                if(existingOppMap != null && existingOppMap.keyset().contains(opp.AccountId)) {
                //checking the new opportunity amount is greater than the existing opp
                    if(existingOppMap.get(opp.AccountId).amount < opp.amount) {
                    opp.max_Account__c = true;
                    opportunity oppOld = new opportunity();
                    oppOld = existingOppMap.get(opp.AccountId);
                    oppOld.max_Account__c = false;
                    opptoUpdate.add(oppOld);
                    }
                }
                else  {
                opp.max_Account__c = true;
                }
            }
        }
        if(opptoUpdate.size() > 0) {
            update opptoUpdate;
        } 
    }
}

}
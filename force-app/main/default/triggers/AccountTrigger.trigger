trigger AccountTrigger on Account (After update, before delete) {
// write a trigger that will update a custom field on a contact record whenever the related account's billing state is changed
if(trigger.isupdate) {
    if(trigger.isafter) {
        map<id,account> accMap = new map<id,account>();
       for(account acc: trigger.new) {
        if(acc.billingstate != trigger.oldmap.get(acc.id).billingstate) {
            accMap.put(acc.id,acc);
        }
       }
       List<contact> contactList = new List<contact>();
       for(contact con: [select id,con_Account_State__c,accountId from contact where accountId IN : accMap.keyset() WITH_SECURITY_ENFORCED LIMIT 49999 ]) {
            con.con_Account_State__c = accMap.get(con.accountId).billingstate;
            contactList.add(con);
       }
       if(contactList.size() > 0) {
        update contactList;
       }
    }
}
// write a code to prevent user from deleting the account if it has open cases or user is not account owner
if(trigger.isdelete) {
    if(trigger.isbefore){
        Set<Id> accIds = new Set<Id>();
       for(case cs : [select id,status, accountId from case where accountId IN: trigger.oldmap.keyset() and status != 'Closed' WITH_SECURITY_ENFORCED]) {
            accIds.add(cs.accountId);
       }
       for(account acc: trigger.old) {
        if(acc.OwnerId != userInfo.getuserId() || accIds.contains(acc.id)) {
            acc.addError('You are not allowed to delete the record');
        }
       }
    }
}
}
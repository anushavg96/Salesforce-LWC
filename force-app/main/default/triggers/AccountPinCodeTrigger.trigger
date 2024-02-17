trigger AccountPinCodeTrigger on Account (After insert) {
    if(trigger.isAfter) {
        if(trigger.isInsert){
           for(Account acc : trigger.new) {
            IndianPostOfficeFetcher.fetchPostOfficesByPincode(acc.PostalPinCode__c,acc.Id);
           } 
        }
    }

}
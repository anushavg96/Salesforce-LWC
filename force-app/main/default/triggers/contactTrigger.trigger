trigger contactTrigger on contact (before insert) {
// write  a code to check the dulicate in contact based on email and phone number while creation
//create a checkbox field in contact object as Duplicate_Contact
if(trigger.isbefore) {
    if(trigger.insert) {
        set<string> emailData = new set<string>();
        set<string> phoneNumber = new set<string>();
        for(contact con: trigger.new) {
            emailData.add(string.valueOf(con.Email));
            phoneNumber.add(string.valueOf(con.Phone));
        }
        set<string> ExistingEmailData = new set<string>();
        set<string> ExistingPhoneNumber = new set<string>();
        for(contact con: [select Id, Email, Phone from contact where Email IN :emailData and  Phone IN : phoneNumber WITH_SECURITY_ENFORCED]) {
            ExistingEmailData.add(string.valueOf(con.Email));
            ExistingPhoneNumber.add(string-valueOf(con.Phone));
        }
        for(contact con : trigger.new) {
            if(ExistingEmailData.size() > 0 && ExistingEmailData.contains(string.valueOf(con.Email))) {
                con.Duplicate_Contact__c = true;
            }
            else if(ExistingPhoneNumber.size() > 0 && ExistingPhoneNumber.contains(string.valueOf(con.Phone))) {
                con.Duplicate_Contact__c = true;
            }
        }

    }
}
}
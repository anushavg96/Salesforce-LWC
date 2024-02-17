trigger contactDemoTrigger on contact (after update) {
    //Reparenting the related records on deactivation of the contact records
if(trigger.isafter) {
    if(trigger.isupdate){
        set<Id> contactIds = new set<Id>();
        for(contact con: trigger.new) {
            //checking the change in status field and field value becoming inactive
            if(trigger.oldmap.get(con.Id).Status__c != con.Status__c && con.Status__c == 'Inactive') {
                contactIds.add(con.Id);
            }
        }
        list<project__c> projectToUpdate = new list<project__c>();
        //fetching the project records associated with contacts
        for(project__c project : [select Id, Contact__c, Contact__r.Backup_Contact__c from project__c where Contact__c IN :contactIds WITH_SECURITY_ENFORCED]) {
            project.Contact__c = project.Contact__r.Backup_Contact__c ;// doing reparenting
            projectToUpdate.add(project);
        }
        if(projectToUpdate.size() > 0) {
            update projectToUpdate;
        }
    }
}
}
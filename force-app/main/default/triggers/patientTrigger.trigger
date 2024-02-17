//Area - holds information about all the coivd 19 patients in an area
//patient - a person infected with covid 19 . it has field called state(mild/critical/cured/fatal)
// area and patient are lookup relationship
//find out: - avg days to recover in that area(cured date - createdDate) - avg days of fatality (fatalDate - createdDate)
//Trigger on patient
//after update

trigger patientTrigger on SOBJECT (beforce update , after update) {
    if(trigger.isupdate){
        if(trigger.isbefore){
            AreaService.beforeUpdatePatient(trigger.new, trigger.oldmap);
        }
        if(trigger.isafter) {
            AreaService.afterUpdatePatient(trigger.new, trigger.oldmap);
        }
    }


}
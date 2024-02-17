public with sharing class AreaService {

  public static void beforeUpdatePatient(List<Patient__C> patientList, Map<Id,Patient__C> oldmap) {
    for(Patient__C objPatient : patientList) {
        if(objPatient.state__c != oldmap.get(objPatient.Id).state__c) {
            if(objPatient.state__c == 'cured' || objPatient.state__c == 'fatal') {
                objPatient.StateChangeTime__c = System.now();
            }
    }
        }
}

    public static void afterUpdatePatient(List<Patient__C> patientList, Map<Id,Patient__C> oldmap) {
        set<Id> setCuredPatientArea = new set<Id>();
        set<Id> setfatalPatientArea = new set<Id>();
      for(Patient__C objPatient : patientList) {
        if(objPatient.state__c != oldmap.get(objPatient.Id).state__c) {
           if(objPatient.state__c == 'cured') {
                setCuredPatientArea.add(objPatient.Area__c);
           } else if(objPatient.state__c == 'fatal') {
                setfatalPatientArea.add(objPatient.Area__c);
           }  
        }
        if(!setCuredPatientArea.isEmpty()) {
            AreaService.calculateRecoveryRate(setCuredPatientArea);
        }
        if(!setfatalPatientArea.isEmpty()){
          AreaService.calculateFatalRate(setfatalPatientArea);  
        }
        }
    }

    public static void calculateRecoveryRate(set<Id> setCuredPatientArea) {
        List<Patient__C> patientList = [Select Id,Name,CreatedDate,StateChangeTime__c,Area__c,state__c from Patient__C where Area__c IN :setCuredPatientArea and state__c = 'cured' WITH_SECURITY_ENFORCED];
        Map<Id,Integer> mapAreaTocuredAverage = new Map<Id,Integer>();
        Map<Id,Integer> mapAreaToCount = new Map<Id,Integer>();
        for(Patient__C pateintObj : patientList) {
            Integer diffStateChange = (pateintObj.StateChangeTime__c - pateintObj.CreatedDate);
            if(mapAreaTocuredAverage.containsKey(pateintObj.Area__c)){
                Integer existingDiff = mapAreaTocuredAverage.get(pateintObj.Area__c);
                mapAreaTocuredAverage.put(pateintObj.Area__c,existingDiff + diffStateChange);
            } else {
               mapAreaTocuredAverage.put(pateintObj.Area__c, diffStateChange); 
            }
            if(mapAreaToCount.containsKey(pateintObj.Area__c)) {
                mapAreaToCount.put(pateintObj.Area__c,mapAreaToCount.get(pateintObj.Area__c)+1);
            } else {
              mapAreaToCount.put(pateintObj.Area__c, 1);  
            }
        }

        List<Area__c> AreasToUpdate = new List<Area__c>();
        for(Id  areaId : mapAreaTocuredAverage.KeySet()) {
            Integer Total = mapAreaTocuredAverage.get(areaId);
            Integer Count = mapAreaToCount.get(areaId);
            AreasToUpdate.add(new Area__c(Id = areaId , AvgDaysToCure = (total/count).setScale(2)));
        }

        if(!AreasToUpdate.isEmpty()) update AreasToUpdate;


    }

    public static void calculateFatalRate(set<Id> setfatalPatientArea) {
        List<Patient__C> patientList = [Select Id,Name,CreatedDate,StateChangeTime__c,Area__c,state__c from Patient__C where Area__c IN :setfatalPatientArea and state__c = 'fatal' WITH_SECURITY_ENFORCED];
        Map<Id,Integer> mapAreaTofatalAverage = new Map<Id,Integer>();
        Map<Id,Integer> mapAreaToCount = new Map<Id,Integer>();
        for(Patient__C pateintObj : patientList) {
            Integer diffStateChange = (pateintObj.StateChangeTime__c - pateintObj.CreatedDate);
            if(mapAreaTofatalAverage.containsKey(pateintObj.Area__c)){
                Integer existingDiff = mapAreaTofatalAverage.get(pateintObj.Area__c);
                mapAreaTofatalAverage.put(pateintObj.Area__c,existingDiff + diffStateChange);
            } else {
               mapAreaTofatalAverage.put(pateintObj.Area__c, diffStateChange); 
            }
            if(mapAreaToCount.containsKey(pateintObj.Area__c)) {
                mapAreaToCount.put(pateintObj.Area__c,mapAreaToCount.get(pateintObj.Area__c)+1);
            } else {
              mapAreaToCount.put(pateintObj.Area__c, 1);  
            }
        }

        List<Area__c> AreasToUpdate = new List<Area__c>();
        for(Id  areaId : mapAreaTofatalAverage.KeySet()) {
            Integer Total = mapAreaTofatalAverage.get(areaId);
            Integer Count = mapAreaToCount.get(areaId);
            AreasToUpdate.add(new Area__c(Id = areaId , AvgDaysToCure = (total/count).setScale(2)));
        }

        if(!AreasToUpdate.isEmpty()) update AreasToUpdate;


    }
}
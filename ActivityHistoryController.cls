public class ActivityHistoryController {
    
    @AuraEnabled
    public static ActivityHistoryWrapper getActivityData(String customerRecordId){
        ActivityHistoryWrapper  returnWrapper=new ActivityHistoryWrapper();
        returnWrapper.collectionActivityHistory=new List<ActivityHistory>();
        returnWrapper.TracingActivityHistory=new List<ActivityHistory>();
        returnWrapper.fieldActivityHistory=new List<ActivityHistory>();
        List<ActivityHistory> activityHistoryData=new List<ActivityHistory>();



        activityHistoryData=getActivityRecords(customerRecordId);
        if(!activityHistoryData.isEmpty()){
            for(ActivityHistory historyrec:activityHistoryData){
                if(!String.isEmpty(historyrec.Activity_Type__c) && historyrec.Activity_Type__c=='Collection'){
                    returnWrapper.collectionActivityHistory.add(historyrec);
                }
                else if(!String.isEmpty(historyrec.Activity_Type__c) && historyrec.Activity_Type__c=='Field'){
                    returnWrapper.fieldActivityHistory.add(historyrec);
                }
                else if(!String.isEmpty(historyrec.Activity_Type__c) && historyrec.Activity_Type__c=='Tracing'){
                    returnWrapper.TracingActivityHistory.add(historyrec);
                }
            }
        }
        
        return  returnWrapper;
    }


    public  static List<ActivityHistory> getActivityRecords(String customerRecordId){
        List<ActivityHistory> activityHistoryData=new List<ActivityHistory>();
        
        Customer__c customerRec=[select id,name,(select WhatId,OwnerID,owner.Name,ActivityDate,Subject,Status,Phone__c,Call_Date__c,Call_Status__c ,Tracing_Status__c,Priority,LastModifiedDate,Assigned_To__c,Activity_Type__c,Description,Duration__c,Call_Id__c,Call_Start_End_Time__c,Field_Visit_Status__c FROM ActivityHistories  order by CreatedDate desc) from Customer__c where id=:customerRecordId];
        if(!customerRec.ActivityHistories.isEmpty()){
            return customerRec.ActivityHistories;
        }
        
        return activityHistoryData;
    }
}
public class ActivityHistoryCreatedDateWrapper {
    
    @AuraEnabled
    public String dateofTracking;

    @AuraEnabled
    public List<ActivityWrapper> activtyList;

    
    public class ActivityWrapper{
        @AuraEnabled
        public String type;

        @AuraEnabled
        public String subject;

        @AuraEnabled
        public String status;

        @AuraEnabled
        public String userAssignto;
    }
}
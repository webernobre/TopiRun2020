global class PutProjectOutboundAsync {
    
    @future(callout=true)
    public static void updateProjectOnExternalSystem(List<Id> projectIds)
    {
        PutProjectOutboundService service = new PutProjectOutboundService();
        ProjectRepository repository = new ProjectRepository();
    
        List<Project__c> projects = new List<Project__c>();
        
        for (Id project : projectIds) {
            projects.add(service.publishProject(project)); 
        }
        repository.store(projects);
        
    } 

}
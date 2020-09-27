/**
 * @author walmeida
 */
public virtual with sharing class ProjectTH extends TriggerHandler {

    List<Project__c> newProjects;
    
    Map<Id,Project__c> oldProjects;

    ProjectFilter filter;
    PutProjectOutboundService service;
    ProjectRepository repository;

    public ProjectTH () {
        this ( (List<Project__c>) Trigger.new, (Map<Id,Project__c>) Trigger.oldMap );
    }
    public ProjectTH (List<Project__c> newProjects , Map<Id,Project__c> oldProjects) {
        
        this.newProjects = newProjects;
        this.newProjects = newProjects;

        this.filter = new ProjectFilter();
        this.service = new PutProjectOutboundService();
        this.repository = new ProjectRepository();
        
    }

    override
    public void afterInsert() {
        publishProjectSync();
    }

    virtual
    public void publishProjectSync(){
        List<Project__c> projectsToUpdate = new List<Project__c>();
        Project__c projectOutbound;
        List<Project__c> filteredProjects = this.filter.filterByTypeEnterpiseAndStatusChanged(newProjects, oldProjects);
        for (Project__c project : filteredProjects) {
            projectOutbound = this.service.publishProject(project.Id);
            projectsToUpdate.add(projectOutbound);
        }
        
        repository.store(projectsToUpdate);
    }

}
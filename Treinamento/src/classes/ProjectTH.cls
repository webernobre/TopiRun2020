/**
 * @author walmeida
 */
public virtual with sharing class ProjectTH extends TriggerHandler {

    List<Project__c> newProjects;
    
    Map<Id,Project__c> oldProjects;

    ProjectFilter filter;
    ProjectRepository repository;

    public ProjectTH () {
        this ( (List<Project__c>) Trigger.new, (Map<Id,Project__c>) Trigger.oldMap );
    }
    public ProjectTH (List<Project__c> newProjects , Map<Id,Project__c> oldProjects) {
        
        this.newProjects = newProjects;
        this.newProjects = newProjects;

        this.filter = new ProjectFilter();
        this.repository = new ProjectRepository();
        
    }

    override
    public void afterInsert() {
        publishProjectSync();
    }

    override
    public void afterUpdate() {
        if(!System.isFuture()){
            publishProjectSync();
        }
    }

    virtual
    public void publishProjectSync(){

        List<Project__c> filteredProjects = this.filter.filterByTypeEnterpiseAndStatusChanged(newProjects, oldProjects);
        if(filteredProjects.size()>0){
            List<Id> projectIds = new List<Id>();
            for(Project__c project: filteredProjects){
                projectIds.add(project.Id);
            }
            PutProjectOutboundAsync.updateProjectOnExternalSystem(projectIds);
        }

    }

}
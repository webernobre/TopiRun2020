public with sharing class ProjectRepository {

    virtual
    public Project__c create(Project__c project){
        insert project;
        return project;
        
    }
    
    virtual
    public List<Project__c> create(List<Project__c> projects){
        insert projects;
        return projects;
        
    }

}
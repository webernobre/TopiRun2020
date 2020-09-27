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

    virtual
    public List<Project__c> store(List<Project__c> projects){
        update projects;
        return projects;
        
    }

    virtual
    public Project__c store(Project__c project){
        update project;
        return project;
        
    }

    virtual
    public Project__c findById(String id){
        List<Project__c> projects = findByIds(new List<String> {id});
        return !projects.isEmpty() ? projects.get(0) : null;
    }

    virtual
    public List<Project__c> findByIds(List<String> ids){
        return [SELECT ProjectName__c, Id, Status__c, 
                        startDate__c, endDate__c, Budget__c 
                FROM Project__c
                WHERE Id In :ids];
    }

}
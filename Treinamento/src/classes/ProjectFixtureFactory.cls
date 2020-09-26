/**
 * @author walmeida
 */
@isTest
public class ProjectFixtureFactory {

    public static Project__c newProject(ProjectSyncRequest project) {
        return new Project__c(
                            ProjectName__c = project.name
                            ,startDate__c = project.startDate
                            ,endDate__c = project.endDate
                            ,Status__c = project.status
                            ,Budget__c = project.budget
                            ,Type__c = 'Enterprise'
                            
        );
    }

    public static Project__c newProject(String name, Date startDate, Date endDate) {
        return new Project__c(
                            ProjectName__c = name
                            ,startDate__c = startDate
                            ,endDate__c = endDate
        );
    }

    public static Project__c createProject(String name, Date startDate, Date endDate) {
        return createProject(newProject(name, startDate, endDate));
    }

    public static Project__c createProject(Project__c project) {
        insert project;
        return project;
    }


}
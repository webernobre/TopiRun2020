/**
 * @author walmeida
 */
@isTest
public class ProjectFixtureFactory {

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
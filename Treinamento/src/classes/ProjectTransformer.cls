/**
 * @author walmeida
 */
public class ProjectTransformer {

    public Project__c toProject(AgileProject agileProject){

        return new Project__c(ProjectName__c = agileProject.name
                            ,ExternalId__c = agileProject.externalId
                            ,startDate__c = agileProject.startDate
                            ,endDate__c = agileProject.endDate);
    }
}
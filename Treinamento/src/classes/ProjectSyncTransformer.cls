/**
 * @author walmeida
 */
public class ProjectSyncTransformer {

    public ProjectSyncRequest generateRequest (Project__c project){
        ProjectSyncRequest projectRequest = new ProjectSyncRequest();
        projectRequest.name = project.ProjectName__c;
        projectRequest.code = project.Id;
        projectRequest.status = project.Status__c;
        projectRequest.startDate = project.startDate__c;
        projectRequest.endDate = project.endDate__c; 
        projectRequest.budget = project.Budget__c;

        return projectRequest;
    }
    
    public Project__c toProject(String projectId, ProjectSyncResponse projectResponse){
        Project__c project = new Project__c();
        project.ExternalId__c = projectResponse.projectId;
        project.Id = projectId;
        project.ErrorMessage__c = projectResponse.errorMessage;
        project.SynchronizationStatus__c = projectResponse.errorMessage == null 
                                            ? 'Integrado com sucesso' 
                                            : 'Erro na sincronização de projetos';
        project.LastSyncDate__c = Datetime.now();

        return project;

    }

    public ProjectSyncResponse handleError( String projectId, ProjectSyncResponse projectResponse){
        ProjectSyncResponse project = new ProjectSyncResponse();
        project.externalId = projectId;
        project.errorMessage = projectResponse.errorMessage;
        return project;
    }

}
/**
 * @author walmeida
 */
@RestResource(urlMapping = '/api/project')
global with sharing class ProjectController {

    @HttpPost
    global static Project__c create(AgileProject project){
        ProjectTransformer transformer = new ProjectTransformer();
        ProjectRepository repository = new ProjectRepository();

        Project__c projectToStore = transformer.toProject(project);

        Project__c createdProject = repository.create(projectToStore);

        return repository.create(transformer.toProject(project));

    }

}
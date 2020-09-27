/**
 * @author walmeida
 */
public virtual class PutProjectOutboundService {

    ProjectSyncTransformer transformer;
    
    
    public PutProjectOutboundService(){
        transformer = new ProjectSyncTransformer();
    }

    virtual
    public Project__c publishProject(String projectId){
        return transformer.toProject(projectId, putProjectSyncService(projectId));
    }

    virtual
    public ProjectSyncResponse putProjectSyncService ( String projectId ) {

        HttpRequest request = new HttpRequest();
        Http http = new Http();
        ProjectSyncRequest projectRequest = new ProjectSyncRequest();        
        ProjectRepository projectRepository = new ProjectRepository();
        
        //mock sucesso
        request.setEndpoint('https://run.mocky.io/v3/58d750c1-31bf-45ae-b361-bedecacf55a2');
        //mock erro
        //request.setEndpoint('https://run.mocky.io/v3/9e25f0c0-b57a-4bdd-bcda-93af84725435');
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(JSON.serialize(transformer.generateRequest(projectRepository.findById(projectId))));
        
        HttpResponse response = http.send(request);

        String payload = response.getBody();

        if (response.getStatusCode()<>200){
            return transformer.handleError(projectId, ( ProjectSyncResponse ) JSON.deserialize( payload , ProjectSyncResponse.class ));
        }
        
        return ( ProjectSyncResponse ) JSON.deserialize( payload , ProjectSyncResponse.class );
    
    }

}
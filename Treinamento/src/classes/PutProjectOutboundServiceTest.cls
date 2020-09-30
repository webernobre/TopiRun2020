/**
 * @author walmeida
 */
@isTest
public class PutProjectOutboundServiceTest {
    @isTest
    public static void givenProjectIdWhenCallProjectSyncServiceThenPublishProjectInExternalSystem(){
        String payloadsuccess = '{"projectId" : "01932190123", "externalId" : "a044W00000g70IKQAY"}';
        String payloaderror = '{"errorMessage" : "Invalid Start Date"}';
        
        ProjectSyncRequest projectRequest = new ProjectSyncRequest();
        projectRequest.name = 'TopiRun2020';
        projectRequest.status = 'Planejado';
        projectRequest.startDate = Date.valueOf('2020-01-01');
        projectRequest.endDate = Date.valueOf('2020-12-01');
        projectRequest.budget = 200000.00;
        
        Project__c project = ProjectFixtureFactory.newProject(projectRequest);
        project = ProjectFixtureFactory.createProject(project);
        project.Status__c='Iniciado';
        project = ProjectFixtureFactory.updateProject(project);
        
        Test.setMock(HttpCallOutMock.class, new ProjectSyncFailHttpMock(payloaderror));
        PutProjectOutboundService service = new PutProjectOutboundService();
        Test.startTest();
       

        try{
            Project__c response = service.publishProject(project.Id);
            System.assertEquals('Invalid Start Date', response.ErrorMessage__c);

        }catch(CalloutException e ){

            System.assert(true);
        }
        Test.setMock(HttpCallOutMock.class, new ProjectSyncSuccessHttpMock(payloadsuccess));
        Project__c response = service.publishProject(project.id);
        Test.stopTest();
    }

    public class ProjectSyncSuccessHttpMock implements HttpCalloutMock{
        String payload;

        public ProjectSyncSuccessHttpMock (String payload){
            this.payload = payload;
        }

        public HttpResponse respond (HttpRequest request){
            HttpResponse response = new HttpResponse();
            response.setBody(payload);
            response.setStatusCode(200);
            return response;
        }
    }


    public class ProjectSyncFailHttpMock implements HttpCalloutMock{
        String payload;

        public ProjectSyncFailHttpMock (String payload){
            this.payload = payload;
        }

        public HttpResponse respond (HttpRequest request){
            HttpResponse response = new HttpResponse();
            response.setBody(payload);
            response.setStatusCode(500);
            return response;
        }
    }

}
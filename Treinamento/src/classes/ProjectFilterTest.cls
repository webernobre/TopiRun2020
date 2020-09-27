/**
 * @author walmeida
 */
@isTest
public class ProjectFilterTest {

    @isTest
    static void filterByTypeEnterpiseAndStatusChangedTest() {
        List<Project__c> newProjects = new List<Project__c>();
        List<Project__c> filteredProjects = new List<Project__c>();
        Map<Id,Project__c> oldProjects = new Map<Id,Project__c>() ;
        ProjectFilter filter = new ProjectFilter();

        ProjectSyncRequest project = new ProjectSyncRequest();
        project.name = 'TopiRun2020';
        project.status = 'Iniciado';
        project.startDate = Date.valueOf('2020-01-01');
        project.endDate = Date.valueOf('2020-12-01');
        project.budget = 200000.00;

        newProjects.add(ProjectFixtureFactory.newProject(project));
        newProjects.add(ProjectFixtureFactory.newProject('Test 1', Date.today(), Date.today().addDays(1)));
        newProjects.add(ProjectFixtureFactory.newDefaultProject());
        

        filteredProjects = filter.filterByTypeEnterpiseAndStatusChanged(newProjects, null);
        System.assertNotEquals(newProjects.size(), filteredProjects.size());
        System.assertEquals(filteredProjects.size(), 1);

        Project__c changedProject = newProjects.get(0).clone(true, true, true, true);
        changedProject.ProjectName__c = 'Teste Update';
        oldProjects.put(changedProject.Id, changedProject);
        filteredProjects = filter.filterByTypeEnterpiseAndStatusChanged(newProjects, oldProjects);
        System.assertEquals(filteredProjects.size(), 0);

        oldProjects.clear();
        changedProject.Status__c = 'Enterprise';
        oldProjects.put(changedProject.Id, changedProject);
        filteredProjects = filter.filterByTypeEnterpiseAndStatusChanged(newProjects, oldProjects);
        System.assertEquals(filteredProjects.size(), 1);

    }



}
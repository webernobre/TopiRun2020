/**
 * @author walmeida
 */
public class ProjectFilter {

    public List<Project__c> filterByTypeEnterpiseAndStatusChanged(List<Project__c> newProjects,
                                                Map<Id,Project__c> oldProjects){
    
        List<Project__c> filteredProjects = new List<Project__c> ();    

        for ( Project__c project : newProjects ) {
            
            if ( String.isEmpty(project.Type__c) ) {
                continue;
            } 

            if(project.Status__c<>'Iniciado'){
                continue;
            }

            if (project.Type__c<>'Enterprise') {
                continue;
            }

            if ( oldProjects == null || oldProjects.isEmpty() ) {

                filteredProjects.add(project);
                continue;
            
            }

            if(project.Status__c == oldProjects.get(project.Id).Status__c){
                continue;
            }

            filteredProjects.add(project);

        }
        return filteredProjects;

    }

}
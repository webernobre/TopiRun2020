/**
 * @author walmeida
 */
trigger ProjectTrigger on Project__c (after insert, after update) {

    new ProjectTH().run();

}
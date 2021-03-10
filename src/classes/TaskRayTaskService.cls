/**
* This class contains the primary business logic for the TaskRayTask object, outside of what's contained in the managed package.
* Created : 06/11/2019
* @author Connor Gallaher - Slalom
*/

public class TaskRayTaskService {

    //Pulling ID of System Administrator in; want to post as this User to prevent
    //other users from deleting post(s).
    public static final Id SYS_ADMIN_ID = Id.valueOf(System.Label.System_Admin_Id);
    
    /*
    * Posts a Chatter feed item to the parent TaskRay Project associated with each task.
    */
    public static void postToParentProject(List<TASKRAY__Project_Task__c> tasks) {
        List<String> parameters;
        String chatterPostTemplate = System.Label.TaskRay_Chatter_Post_Message;

        List<FeedItem> feedItems = new List<FeedItem>();
        FeedItem item;
        for (TASKRAY__Project_Task__c task : tasks) {
            item = new FeedItem();
            item.ParentId = task.TASKRAY__Project__c;
            item.CreatedById = SYS_ADMIN_ID;
            parameters = new List<String>{task.Name, UserInfo.getName()};
            String postText = String.format(chatterPostTemplate, parameters);
            item.Body = postText;
            feedItems.add(item);
        }
        if (!feedItems.isEmpty()) {
            insert feedItems;
        }
    }
}
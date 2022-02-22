package controller;

import java.util.HashMap;

import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.user.*;
import controller.comment.*;
import controller.group.ApplyAcceptGroupController;
import controller.group.ApplyGroupController;
import controller.group.CreateGroupController;
import controller.group.DeleteGroupController;
import controller.group.DropoutGroupController;
import controller.group.ListManageGroupController;
import controller.group.ListGroupController;
import controller.group.ListMyGroupController;
import controller.group.SearchGroupController;
import controller.group.UpdateGroupController;
import controller.group.ViewManageGroupController;
import controller.post.CreatePostController;
import controller.post.DeletePostController;
import controller.post.DetailPostController;
import controller.post.ListPostController;
import controller.post.UpdatePostController;
import controller.post.UpdatePostFormController;
import controller.group.ViewGroupController;

public class RequestMapping {
    private static final Logger logger = LoggerFactory.getLogger(DispatcherServlet.class);
   
    private Map<String, Controller> mappings = new HashMap<String, Controller>();

    public void initMapping() {
    	//메인화면
    	mappings.put("/", new ForwardController("index.jsp"));
    	
    	//사용자
    	mappings.put("/user/mainPage", new ForwardController("/user/mainPage.jsp"));
    	mappings.put("/user/register/form", new ForwardController("/user/registerForm.jsp"));
    	mappings.put("/user/register", new RegisterUserController());
    	mappings.put("/user/login/form", new ForwardController("/user/login.jsp"));
    	mappings.put("/user/login", new LoginController());
    	mappings.put("/user/logout", new LogoutController());
    	mappings.put("/user/view", new ViewUserController());
    	mappings.put("/user/update/form", new UpdateUserController());
    	mappings.put("/user/update", new UpdateUserController());
    	mappings.put("/user/home", new GoToHomeController());
    	
    	//여행그룹관리(leader)
    	mappings.put("/group/manageGroupList", new ListManageGroupController());
    	mappings.put("/group/manageGroup", new ViewManageGroupController());
    	mappings.put("/group/manageGroup/delete", new DeleteGroupController());
    	mappings.put("/group/manageGroup/update/form", new UpdateGroupController());
    	mappings.put("/group/manageGroup/update", new UpdateGroupController());
    	mappings.put("/group/manageGroup/applyAccept", new ApplyAcceptGroupController());
    	
    	//여행그룹관리(멤버)
    	mappings.put("/group/myApplyList", new ApplyListController());
    	mappings.put("/group/myGroup", new ListMyGroupController());
    	mappings.put("/group/myGroup/dropOut", new DropoutGroupController());
    	
    	//여행그룹정보
    	mappings.put("/group/list", new ListGroupController());
    	mappings.put("/group/view", new ViewGroupController());
    	mappings.put("/group/apply", new ApplyGroupController());
    	mappings.put("/group/create/form", new CreateGroupController());
    	mappings.put("/group/create", new CreateGroupController());
    	mappings.put("/group/search/form", new ForwardController("/group/searchGroup.jsp"));
    	mappings.put("/group/search", new SearchGroupController());
    	
    	//커뮤니티 
    	mappings.put("/post/list", new ListPostController());
    	mappings.put("/post/detail", new DetailPostController());
    	mappings.put("/post/create/form", new CreatePostController());
    	mappings.put("/post/create", new CreatePostController());
    	mappings.put("/post/update/form", new UpdatePostFormController());
    	mappings.put("/post/update", new UpdatePostController());
    	mappings.put("/post/delete", new DeletePostController());
    	
    	
    	//댓글
    	mappings.put("/comment/register", new RegisterCommentController());
    	mappings.put("/comment/delete", new DeleteCommentController());
        
        logger.info("Initialized Request Mapping!");
    }

    public Controller findController(String uri) {	
        return mappings.get(uri);
    }
}

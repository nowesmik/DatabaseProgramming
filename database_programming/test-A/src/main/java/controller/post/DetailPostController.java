package controller.post;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.Comment;
import model.Post;
import model.service.Manager;
import model.service.NotFoundException;

public class DetailPostController implements Controller {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int postId = Integer.parseInt(request.getParameter("postId"));
		
		try {
			Manager manager = Manager.getInstance();
			
			Post detailPost = manager.findPost(postId);
			int numOfComm = manager.numberOfComment(postId);
			ArrayList<Comment> commList = manager.getAllComment(postId);
			
			HttpSession session = request.getSession();
			int memberId = UserSessionUtils.getLoginUserId(session);
			
			request.setAttribute("memberId", memberId);
			request.setAttribute("post", detailPost);
			request.setAttribute("numOfComm", numOfComm);	
			request.setAttribute("commList", commList);
			
			return "/myGroup/detailPost.jsp";	
		} catch (NotFoundException e) {
			request.setAttribute("Failed", true);
			request.setAttribute("exception", e);
			
			return "/myGroup/view.jsp"; 
		}
	}
}

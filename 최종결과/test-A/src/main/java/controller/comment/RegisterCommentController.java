package controller.comment;

import java.util.ArrayList;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.Comment;
import model.service.Manager;

public class RegisterCommentController implements Controller {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		int member_id = UserSessionUtils.getLoginUserId(session);
		int groupId = Integer.parseInt(request.getParameter("groupId"));
		int postId = Integer.parseInt(request.getParameter("postId"));
		
		Comment comment = new Comment();

		comment.setContent(request.getParameter("content"));
		comment.setGroupId(groupId);
		comment.setWriter_id(member_id);
		comment.setPostId(postId);
	
		try {
			Manager manager = Manager.getInstance();
			int comment_id = manager.createComment(comment);

			return "redirect:/post/detail?postId=" + postId;
		} catch (Exception e) {
			
			request.setAttribute("exception", e);
			request.setAttribute("comment", comment);
			return "/myGroup/detailPost.jsp";
		}	
	}
}

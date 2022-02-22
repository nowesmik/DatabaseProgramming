package controller.comment;

import java.util.ArrayList;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.Comment;
import model.service.Manager;

public class DeleteCommentController implements Controller {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int comment_id = Integer.parseInt(request.getParameter("comment_id"));
		try {
			Manager manager = Manager.getInstance();
			
			int writer = Integer.parseInt(request.getParameter("member_id"));
			HttpSession session = request.getSession();
			if (UserSessionUtils.isLoginUser(writer, session)) {
				
				manager.removeComment(comment_id);				
				
				int postId = Integer.parseInt(request.getParameter("postId"));
			
				return "redirect:/post/detail?postId=" + postId;	
			}

			request.setAttribute("exception", 
					new IllegalStateException("자신이 작성한 댓글만 삭제할 수 있습니다."));        		
			return "/myGroup/detailPost.jsp";
			
		} catch (Exception e) {
			request.setAttribute("exception", e);   
			return "/myGroup/detailPost.jsp";
		}
	}
}

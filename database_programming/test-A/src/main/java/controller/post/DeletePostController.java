package controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.service.Manager;

public class DeletePostController implements Controller {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int postId = Integer.parseInt(request.getParameter("postId"));
		int groupId = Integer.parseInt(request.getParameter("groupId"));
		try {
			Manager manager = Manager.getInstance();
			
			int writer = Integer.parseInt(request.getParameter("memberId"));
			HttpSession session = request.getSession();
						
			if (UserSessionUtils.isLoginUser(writer, session)) {		
				manager.removePost(postId);
				return "redirect:/post/list?groupId=" + groupId;

			}
			request.setAttribute("exception", 
					new IllegalStateException("자신이 작성한 게시글만 삭제할 수 있습니다."));        		
			return "/myGroup/detailPost.jsp";
			
		} catch (Exception e) {
			request.setAttribute("exception", e);
			return "/myGroupy/detailPost.jsp";
		}
		
	}

}

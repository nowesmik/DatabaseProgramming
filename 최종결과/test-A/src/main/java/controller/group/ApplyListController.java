package controller.group;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.service.Manager;

public class ApplyListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		int userId = UserSessionUtils.getLoginUserId(session);
		int groupId = Integer.valueOf(request.getParameter("groupId"));
		
		Manager manager = Manager.getInstance();
		
		String comments = request.getParameter("comments");
		


		int result = 0;	
		try {
			result = manager.applyToGroup(groupId, userId, comments);

			if (result == 1) {
				return "redirect:/group/myApplyList";
			}
			return "redirect:/group/view?groupId=" + groupId + "&result=" + result;

		} catch (Exception e) {

			return "redirect:/group/view?groupId=" + groupId + "&result=" + result;
		}
	}
	
}

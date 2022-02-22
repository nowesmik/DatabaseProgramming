package controller.group;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.service.Manager;
import model.service.NotFoundException;

public class ApplyAcceptGroupController implements Controller {
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int groupId = Integer.parseInt(request.getParameter("groupId")); 
		int userId = Integer.parseInt(request.getParameter("memberId")); 
		String isAccepted = request.getParameter("isAccepted");
		try {
			Manager manager = Manager.getInstance();
			int result = -1;
			if(isAccepted.equals("true")) {
				result = manager.manageApplicationInGroup(groupId, userId, true);
			}else if(isAccepted.equals("false")) {
				manager.manageApplicationInGroup(groupId, userId, false);
			}
			 
			if(result == -3) {
				return "redirect:/group/manageGroup?groupId=" + groupId + "&result=" + result;
			}
			
			return "redirect:/group/manageGroup?groupId=" + groupId; 
		} catch (NotFoundException e) {
			request.setAttribute("Failed", true);
			request.setAttribute("exception", e);
			
			return "/manage/view.jsp";
		}
	}
}

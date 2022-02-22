package controller.group;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.service.Manager;

public class DeleteGroupController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int deleteId = Integer.valueOf(request.getParameter("groupId"));
		try {
			Manager manager = Manager.getInstance();
			manager.removeGroup(deleteId);
			return "redirect:/group/manageGroupList";
			
		} catch (Exception e) { 
			request.setAttribute("exception", e);
			return "/manage/main.jsp";
		}
		
	}
}

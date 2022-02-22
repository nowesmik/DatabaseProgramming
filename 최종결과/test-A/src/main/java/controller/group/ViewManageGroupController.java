package controller.group;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.Application;
import model.Group;
import model.service.Manager;
import model.service.NotFoundException;

public class ViewManageGroupController implements Controller{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Manager manager = Manager.getInstance();
		
		Object result = request.getParameter("result");
		if(result != null) {
			request.setAttribute("result", result);
		}
		
		int groupId = Integer.valueOf(request.getParameter("groupId"));
		Group group;
		ArrayList<Application> applyList;
	
		try {
			group = manager.findGroup(groupId);
			applyList = manager.getAllApplication(groupId);
		}catch(NotFoundException e) {
			return "redirect:/"; 
		}
		
		request.setAttribute("Group", group);
		request.setAttribute("applyList", applyList);
		
		return "/manage/view.jsp";
	}
}

package controller.group;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.Group;
import model.service.Manager;
import model.service.NotFoundException;


public class ViewGroupController implements Controller{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		int groupId = Integer.valueOf(request.getParameter("groupId"));
		String result = request.getParameter("result");
		Manager manager = Manager.getInstance();
		
		Group group = null;
		try {
			group = manager.findGroup(groupId);
		} catch(NotFoundException e) {
			return "";
		}
		
		request.setAttribute("Group", group);
		if(result == null) {
			System.err.println("result == null");
			return "/group/view.jsp";
		}else {
			System.err.println("result != null");
			return "/group/view.jsp?result=" + result;
		}
	}
}

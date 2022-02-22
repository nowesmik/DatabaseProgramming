package controller.group;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.Group;
import model.service.Manager;

public class ListGroupController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if(!UserSessionUtils.hasLogined(session)) {return "redirect:/user/login";}
		
		Manager manager = Manager.getInstance();
		
		Object object = request.getAttribute("errorResult");
		
		if(object != null) {
			request.setAttribute("errorResult", object.toString());
		}
		List<Group> groupList = manager.getAllGroup();
		
		request.setAttribute("groupList", groupList);
		
		return "/group/list.jsp";
	}

}

package controller.user;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import controller.Controller;
import model.Group;
import model.service.Manager;

public class ListGroupController implements Controller {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
    	if (!UserSessionUtils.hasLogined(request.getSession())) {
            return "redirect:/user/login/form";		
        }
    	
    	Manager manager = Manager.getInstance();
    	String email = (String) request.getSession().getAttribute("email");
		String password = (String) request.getSession().getAttribute("password");
		
		if(!manager.isLogin(email, password)) {
			return "redirect:/user/login.jsp ";
		}
		
		Object object = request.getAttribute("errorResult");
		
		if(object != null) {
			request.setAttribute("errorResult", object.toString());
		}
		List<Group> groupList = manager.getAllGroup();
		
		request.setAttribute("groupList", groupList);
		
		return "/group/list.jsp";
	}
}

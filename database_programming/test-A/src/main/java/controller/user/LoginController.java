package controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.User;
import model.service.Manager;

public class LoginController implements Controller {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		try {
			Manager manager = Manager.getInstance();
			manager.login(email, password);
	
            User user = manager.findUser(email);
			HttpSession session = request.getSession();
            session.setAttribute(UserSessionUtils.USER_SESSION_KEY, user.getUser_id());
            
            request.setAttribute("user", user);
            
            return "/user/mainPage.jsp";			
		} catch (Exception e) {
            request.setAttribute("loginFailed", true);
			request.setAttribute("loginException", e);
            return "/user/login.jsp";			
		}	
    }
}

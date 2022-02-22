package controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.User;
import model.service.ExistingUserException;
import model.service.Manager;

public class RegisterUserController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(RegisterUserController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
       	User user = new User(
			request.getParameter("email"),
			request.getParameter("phone"),
			request.getParameter("password"),
			request.getParameter("name"),
			Integer.parseInt(request.getParameter("age")),
			Integer.parseInt(request.getParameter("gender")));
		
        log.debug("Create User : {}", user);

		try {
			Manager manager = Manager.getInstance();
			manager.createUser(user);
	        return "/user/login.jsp";	
	        
		} catch (ExistingUserException e) {	
            request.setAttribute("registerFailed", true);
			request.setAttribute("exception", e);
			request.setAttribute("user", user);
			return "/user/registerForm.jsp";
		}
    }
}

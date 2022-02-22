package controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.service.Manager;
import model.User;

public class ViewUserController implements Controller {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {					
		HttpSession session = request.getSession();

		if(!UserSessionUtils.hasLogined(session)) {
			return "redirect:/user/login";
		}
		
		int userId = Integer.valueOf(UserSessionUtils.getLoginUserId(session));
		
		Manager manager = Manager.getInstance();
		User user;
		
		try {
			user = manager.findUser(userId);
		}catch(Exception e) {
			return "redirect:/user/mainPage";
		}
		
		request.setAttribute("user", user);
		return "/user/myPage.jsp";
    }
}

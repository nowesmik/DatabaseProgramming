package controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.User;
import model.service.Manager;

public class GoToHomeController implements Controller{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		if(!UserSessionUtils.hasLogined(session)) {return "redirect:/user/login";}

		int userId = UserSessionUtils.getLoginUserId(request.getSession());
		Manager manager = Manager.getInstance();
		User user = manager.findUser(userId);
		
		request.setAttribute("user", user);
		return "/user/mainPage.jsp";
	}
}

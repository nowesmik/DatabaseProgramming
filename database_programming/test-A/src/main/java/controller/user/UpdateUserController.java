package controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.service.Manager;
import model.User;

public class UpdateUserController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(UpdateUserController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
    	if (request.getMethod().equals("GET")) {
			int updateId = Integer.parseInt(request.getParameter("userId"));

			Manager manager = Manager.getInstance();
			
			User user = (User) manager.findUser(updateId);
			request.setAttribute("user", user);

			HttpSession session = request.getSession();
				
			if(!UserSessionUtils.hasLogined(session)) {
				return "redirect:/user/login";
			}
			
			if (UserSessionUtils.isLoginUser(updateId, session)) {
				return "/user/updateForm.jsp";
			}

			request.setAttribute("updateFailed", true);
			request.setAttribute("exception", new IllegalStateException("타인의 정보는 수정할 수 없습니다."));
			return "/user/myPage.jsp";
		}
		
		HttpSession session = request.getSession();
		int userId;
		if(UserSessionUtils.hasLogined(session)) {
			userId = UserSessionUtils.getLoginUserId(session);
		}else {
			return "redirect:/user/login";
		}
		
		User updateUser = new User();
		
		updateUser.setUser_id(userId);
		updateUser.setEmail(request.getParameter("email"));
		updateUser.setName(request.getParameter("name"));
		updateUser.setPhone(request.getParameter("phone"));
		updateUser.setPassword(request.getParameter("password"));
		
		Manager manager = Manager.getInstance();
		int result = manager.updateUser(updateUser);
		
		return "redirect:/user/view";
    }
}

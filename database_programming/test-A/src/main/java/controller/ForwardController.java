package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.user.UserSessionUtils;

public class ForwardController implements Controller {
    private String forwardUrl;

    public ForwardController(String forwardUrl) {		
        if (forwardUrl == null) {
            throw new NullPointerException("forwardUrl is null.");
        }
        this.forwardUrl = forwardUrl;
    }

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse respsponse) throws Exception {
    	HttpSession session = request.getSession();
//    	System.out.println("session : " + request.getRequestURI()); // 확인을 위한 코드
		if(!request.getRequestURI().equals("/test-A/user/mainPage") && !request.getRequestURI().equals("/test-A/user/register/form")
				&& !UserSessionUtils.hasLogined(session)) {
			return "redirect:/user/login";
		}
		
        return forwardUrl;
    }
}

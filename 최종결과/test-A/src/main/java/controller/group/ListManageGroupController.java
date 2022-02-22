package controller.group;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.service.Manager;
import model.Group;

public class ListManageGroupController implements Controller {

	@SuppressWarnings("static-access")
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		UserSessionUtils utils = new UserSessionUtils();
		if(!utils.hasLogined(session)) {return "redirect:/user/login";}
		
		int userId = Integer.valueOf(utils.getLoginUserId(session));
		
		Manager manager = Manager.getInstance();
		try {
			ArrayList<Group> groupList = manager.getManageGroupList(userId);
			request.setAttribute("groupList", groupList);
		}catch(SQLException e) {
			return "recirect:/"; 
		}
		
		return "/manage/main.jsp";
	}

}

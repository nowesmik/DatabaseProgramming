package controller.group;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.Group;
import model.service.Manager;

public class SearchGroupController implements Controller{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		if(!UserSessionUtils.hasLogined(session)) {return "redirect:/user/login";}

		String place = null;
		String gender_type = null;
		String traffic_type = null;
		int term = 0;
		int numOfMem = 0;
		int age = 0;
		
		try {
			place = (String) request.getParameter("place");
			gender_type = (String) request.getParameter("genderType");
			traffic_type = (String) request.getParameter("trafficType");
			term = Integer.valueOf((String)request.getParameter("term"));
			numOfMem = Integer.valueOf((String)request.getParameter("numberOfUsers"));	
			age = Integer.valueOf((String)request.getParameter("age"));
			
			Manager manager = Manager.getInstance();
			ArrayList<Group> groupList = manager.searchGroups(term, numOfMem, place, gender_type, traffic_type, age);
			
			System.out.println(groupList);
			
			request.setAttribute("groupList", groupList);
			request.setAttribute("place", place);
			request.setAttribute("genderType", gender_type);
			request.setAttribute("trafficType", traffic_type);
			request.setAttribute("term", term);
			request.setAttribute("num", numOfMem);
			request.setAttribute("age", age);

			return "/group/searchGroup.jsp";
		} catch (Exception e) {
			request.setAttribute("place", place);
			request.setAttribute("genderType", gender_type);
			request.setAttribute("trafficType", traffic_type);
			request.setAttribute("term", term);
			request.setAttribute("num", numOfMem);
			request.setAttribute("age", age);
			
			request.setAttribute("searchFailed", true);
			request.setAttribute("exception", e);
			return "/group/searchGroup.jsp";
		}
	}
}

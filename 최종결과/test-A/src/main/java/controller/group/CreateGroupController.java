package controller.group;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.Group;
import model.User;
import model.service.Manager;

public class CreateGroupController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		if(!UserSessionUtils.hasLogined(session)) {return "redirect:/user/login";} 
		
		Manager manager = Manager.getInstance();
		List<Group> list = manager.getAllGroup();
		
		if (request.getMethod().equals("GET")) {	
			request.setAttribute("groupList", list);
			return "/group/createGroup.jsp";
		}
		
		
//		manager = Manager.getInstance();
		int memberId = UserSessionUtils.getLoginUserId(request.getSession());
		User user = manager.findUser(memberId);
		
		int genderType = Integer.valueOf(request.getParameter("genderType"));
		int age = Integer.valueOf(request.getParameter("age"));
		String groupName = request.getParameter("groupName");
		String description = request.getParameter("description");
		String place = request.getParameter("place");
		
		
		System.out.println("사용자 성별 : " + user.getGender());
		System.out.println("조건 성별 : " + genderType);
		try {
			for (int i=0; i < list.size(); i++) {
				System.out.println("여기에 들어왔는지확인" +  groupName);
				System.out.println("그룹이름: " + list.get(i).getGroupName());
				if (list.get(i).getGroupName() != null && list.get(i).getGroupName().equals(groupName)) {
					request.setAttribute("errorResult", "groupName");
				    return "/group/createGroup.jsp";
				}
			}
			if (groupName.equals("")) {
				request.setAttribute("errorResult", "emptyName");
				return "/group/createGroup.jsp";
			}
			if (description.equals("")) {
				request.setAttribute("errorResult", "emptyDescription");
				return "/group/createGroup.jsp";
			}
			if (place.equals("")) {
				request.setAttribute("errorResult", "emptyPlace");
				return "/group/createGroup.jsp";
			}
			if(genderType != 0) {
				if(genderType != user.getGender()) {
					request.setAttribute("errorResult", "gender");
					return "/group/createGroup.jsp";
				}
			}
		
			if(age != 0 && age > Integer.valueOf(user.getAge())) {
				request.setAttribute("errorResult", "age");
				return "/group/createGroup.jsp";
			}
		

			Group tavelGroup = new Group(Integer.parseInt(request.getParameter("numberOfUsers")),
					request.getParameter("groupName"), request.getParameter("description"),
					Integer.parseInt(request.getParameter("term")), request.getParameter("place"),
					request.getParameter("genderType"), request.getParameter("trafficType"),
					Integer.parseInt(request.getParameter("age")));
	
				
			int userId = UserSessionUtils.getLoginUserId(session);
				
			manager.createGroup(tavelGroup, userId);
			return "redirect:/group/list";
			
		}catch(Exception e) {
		
			request.setAttribute("exception", e);
			System.out.println(e.getMessage());
			return "redirect:/group/create/form";
		}
	}
}

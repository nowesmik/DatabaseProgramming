package controller.group;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.Group;

import model.service.Manager;

public class UpdateGroupController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		Manager manager = Manager.getInstance();
		int groupId = Integer.valueOf(request.getParameter("groupId"));
		
		if(request.getMethod().equals("GET")) {
			Group group = manager.findGroup(groupId);
			int nowNumber = manager.getNumberOfMemberInGroup(groupId);
			request.setAttribute("nowNumber", nowNumber);
			request.setAttribute("Group", group);
			return "/manage/update.jsp";
		}
		
		Group group = manager.findGroup(groupId);
		String groupName = (String) request.getParameter("groupName");
		if(groupName != null) { group.setGroupName(groupName); }
		String numberOfUsers = (String) request.getParameter("numberOfUsers");
		if (numberOfUsers != null) { group.setNumberOfUsers(Integer.valueOf(numberOfUsers)); }
		String term = (String) request.getParameter("term");
		if(term != null) { group.setTerm(Integer.valueOf(term)); }
		String place = (String)request.getParameter("place");
		if(place == null) { System.out.println("place is null"); }
		if(place != null) { System.out.println(place); 
		group.setPlace(place); }
 		String genderType = (String)request.getParameter("genderType");
 		if(genderType != null) { group.setGenderType(genderType); }
 		String trafficType = (String)request.getParameter("trafficType");
 		if(trafficType != null) { group.setTrafficType(trafficType); }
 		String age = (String)request.getParameter("age");
 		if(age != null) { group.setAge(Integer.valueOf(age)); }
 		String leaderId = (String)request.getParameter("leaderId");
 		if(leaderId != null) { group.setLeaderId(Integer.valueOf(leaderId)); }
 		String description = (String) request.getParameter("description");
 		if (description != null) { group.setDescription(description); }
		
		int result = 0;
		try {
			System.out.println("업데이트그룹컨트롤러reuslt"); 
			result = manager.updateGroup(group);
			System.out.println(result);
		}catch(Exception e) {
			System.out.println("오류발생..");
			return "redirect:/"; 
		}
		
		return "redirect:/group/manageGroup?groupId=" + groupId;
	}

}

package controller.group;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.Group;
import model.service.DeleteException;
import model.service.Manager;
import model.service.NotFoundException;

public class DropoutGroupController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception, DeleteException {
		// TODO Auto-generated method stub
		
		int groupId = Integer.valueOf(request.getParameter("groupId"));
		int memberId = UserSessionUtils.getLoginUserId(request.getSession());
		Manager manager = Manager.getInstance();
		try {
			Group group = manager.findGroup(groupId);
			if(group.getLeaderId() == memberId) {
				System.out.println("팀장은 그룹에서 탈퇴할 수 없습니다.");
				throw new DeleteException("팀장은 그룹에서 탈퇴할 수 없습니다.");
			}else {
				manager.removeMemberInGroup(groupId, memberId);
			}
		}catch(Exception e) {
			if(e instanceof NotFoundException) {
				request.setAttribute("exception", "notFound");
			}
			if(e instanceof SQLException) {
				request.setAttribute("exception", "sqlException");
			}
			if(e instanceof DeleteException) {
				request.setAttribute("exception", "deleteException");
				request.setAttribute("groupList", manager.getMyGroupList(memberId));
				return "/myGroup/main.jsp";
			}
			
			return ""; 
			
		}
		
		return "redirect:/group/myGroup";
	}
}
package controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.Post;
import model.service.Manager;

public class CreatePostController implements Controller {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int groupId = Integer.parseInt(request.getParameter("groupId"));
		HttpSession session = request.getSession();
		int memberId = UserSessionUtils.getLoginUserId(session);
		
		if(request.getMethod().equals("POST")) {
			Post post = new Post();
		
			String title = request.getParameter("title");
			String content = request.getParameter("content");
		
			if(title.equals("")) {System.out.println("title is null");}
			if(content.equals("")) {System.out.println("content is null");}
			post.setTitle(request.getParameter("title"));
			post.setContent(request.getParameter("content"));
		
			System.out.println(post.getTitle() + ", " + post.getContent());
		
			post.setWriter_id(memberId);
			post.setGroup_id(groupId);
		
			System.out.println(post.getWriter_id() + "," + post.getGroup_id());
		
			try {
//				System.out.println("try 안으로 들어옴.");
				Manager manager = Manager.getInstance();
				int post_id = manager.createPost(post);

//				System.out.println("create- post 실행 중");
				return "redirect:/post/list?groupId=" + groupId;
			
			} catch (Exception e) {
				request.setAttribute("exception", e);
				request.setAttribute("post", post);
				// 게시글 등록폼
				return "/myGroup/addGroupboard.jsp";
			}
		}else {	
			return "/myGroup/addGroupboard.jsp?groupId=" + groupId;
		}
		
	}
}

package controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.Post;
import model.User;
import model.service.Manager;

public class UpdatePostFormController implements Controller{
   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println(request.getParameter("postId"));
      int postId = Integer.parseInt(request.getParameter("postId"));

      try {
         Manager manager = Manager.getInstance();
         Post post = manager.findPost(postId);
         
         int writer = Integer.parseInt(request.getParameter("memberId"));
         HttpSession session = request.getSession();
         if (UserSessionUtils.isLoginUser(writer, session)) {
            request.setAttribute("post", post);
            return "/myGroup/postUpdateForm.jsp";

         }
         request.setAttribute("exception", 
               new IllegalStateException("자신이 작성한 게시글만 수정할 수 있습니다."));              
         return "/myGroup/detailPost.jsp";
      } catch (Exception e) {
         request.setAttribute("exception", e);
         return "/myGroup/detailPost.jsp";
      }
      
   }
}
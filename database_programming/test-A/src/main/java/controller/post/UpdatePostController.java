package controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.Post;
import model.service.Manager;

public class UpdatePostController implements Controller{
   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      int postId = Integer.parseInt(request.getParameter("postId"));
      
      Post post = new Post();
      post.setTitle(request.getParameter("title"));
      post.setContent(request.getParameter("content"));
      post.setPostId(postId);
      
      Manager manager = Manager.getInstance();
      try {
         manager.updatePost(post);
         
         return "redirect:/post/detail?postId=" + postId;

      } catch (Exception e) {
         
         request.setAttribute("exception", e);
         request.setAttribute("post", post);
         return "/myGroup/postUpdateForm.jsp";
      }
   }

}
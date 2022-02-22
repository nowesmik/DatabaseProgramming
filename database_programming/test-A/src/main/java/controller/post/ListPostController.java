package controller.post;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.Post;
import model.service.Manager;
import model.service.NotFoundException;

public class ListPostController implements Controller {
   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      int groupId = Integer.parseInt(request.getParameter("groupId"));
      
      try {
         Manager manager = Manager.getInstance();
         ArrayList<Post> postList = manager.getAllPost(groupId);
         
         request.setAttribute("postList", postList);
         request.setAttribute("groupId", groupId);
         return "/myGroup/view.jsp";
      } catch (NotFoundException e) {
           request.setAttribute("Failed", true);
         request.setAttribute("exception", e);
         
         return "/myGroup/main.jsp";
      }
   }
}
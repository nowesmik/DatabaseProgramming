package model.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Application;
import model.Comment;
import model.Group;
import model.Post;
import model.User;
import model.dao.*;

public class Manager {
   private static Manager manager = new Manager();
   private UserDAO userDAO;
   private GroupDAO groupDAO;
   private PostDAO postDAO;
   private CommentDAO commentDAO;

   private Manager() {
      try {
         userDAO = UserDAO.getInstance();
         groupDAO = GroupDAO.getInstance();
         postDAO = PostDAO.getInstance();
         commentDAO = CommentDAO.getInstance();
      
      }catch(Exception e) {
         e.printStackTrace();
      }
   }
   
   public static Manager getInstance() {
      return manager;
   }

   public boolean login(String email, String password) throws SQLException, NotFoundException, PasswordMismatchException{
      User user = userDAO.findUser(email);
      if(user == null) {throw new NotFoundException();}

      if (!user.matchPassword(password)) {
         throw new PasswordMismatchException("비밀번호가 일치하지 않습니다.");
      }
      return true;
   }
   
   public boolean isLogin(String email, String password) throws SQLException{
      return userDAO.existingUser(email, password);
   }
   
   public int createUser(User user) throws SQLException, ExistingUserException{
      if(isLogin(user.getEmail(), user.getPassword())) {
         throw new ExistingUserException(user.getEmail() + "는 존재하는 아이디입니다.");
      }
      return userDAO.userCreate(user);
   }
   
   public int updateUser(User user) throws SQLException, NotFoundException{
      return userDAO.userInfoUpdate(user);
   }
   
   public User findUser(int userId) throws SQLException, NotFoundException {
         User user = userDAO.findUser(userId);
         
         if (user == null) {
            throw new NotFoundException(userId + "는 존재하지 않는 아이디입니다.");
         }      
         return user;
   }
   
   public User findUser(String email) throws SQLException{
      User user = userDAO.findUser(email);      
      return user;
   }
   
   public int createGroup(Group group, int userId) throws SQLException, ExistingUserException, NotFoundException{
      int createdGroupId = 0;
      int r2 = 0;
      
      createdGroupId = groupDAO.addGroup(group, userId);
      if(createdGroupId != 0) {
         r2 = groupDAO.addMemberInGroupMember(group.getGroupId(), userId, "1"); // 1이면 리더 
      }
      
      if(createdGroupId != 0 && r2 == 1)
         return createdGroupId;
      return 0;
   }
   
   public int removeGroup(int groupId) throws SQLException, NotFoundException, RemoveException{
		if(!groupDAO.existingGroup(groupId)) {
			throw new NotFoundException(groupId + "는 존재하지 않는 groupId 입니다.");
		}
		int result = 0;
		// Group을 참조 하고 있는 테이블 레코드 전부 삭제
		result = groupDAO.removeMemberInGroup(groupId, -1);
		System.out.println("member :" + result);
		result = commentDAO.deleteAllCommentsByGroupId(groupId);
		System.out.println("comment :" + result);
		result = postDAO.removeAllPost(groupId);
		System.out.println("post :" + result);
		result = groupDAO.removeAllApply(groupId);
		System.out.println("applys :" + result);
		
		result = groupDAO.removeGroup(groupId);
		if(result == 0) {throw new RemoveException(groupId + "그룹 삭제가 실패하였습니다.");}
		
		return result;
	}
	

	public int updateGroup(Group group)  throws SQLException, NotFoundException {
		if(!groupDAO.existingGroup(group.getGroupId())) {
			throw new NotFoundException(group.getGroupId() + "는 존재하지 않는 groupId 입니다.");
		}
		System.out.println("여기까지 잘 왔음을...."); // 확인을 위한 코드
		int result = groupDAO.updateGroup(group);
		System.out.println(result);
		if(result == 0) {throw new SQLException();}
		
		return result;
	}
	
   public Group findGroup(int groupId) throws SQLException, NotFoundException{
      Group group = groupDAO.selectGroup(groupId);
      
      if(group == null) {throw new NotFoundException();}
//      User leader = findUser(group.getLeaderId());
      
      return group;
   }
   
   public ArrayList<Group> searchGroups (Integer term, Integer numOfMem, String place, String gender_type, String traffic_type, int age) throws SQLException {
      ArrayList<Group> groupList = groupDAO.searchGroupList(term, numOfMem, place, gender_type, traffic_type, age);
   
      if(groupList == null) {throw new SQLException("조건에 맞는 그룹이 없습니다.");}
      
      return groupList;
   }
   
   public ArrayList<Group> getMyGroupList(int memberId) throws SQLException, NotFoundException {		
		ArrayList<Group> groupList = userDAO.getMyGroupList(memberId);
		if(groupList == null) {throw new SQLException("나의 그룹 내역 조회 실패");}
		
		return groupList;
	}
   
   public ArrayList<Group> getManageGroupList(int memberId) throws SQLException, NotFoundException{
		ArrayList<Group> groupList = userDAO.getManageGroupList(memberId);
		if(groupList == null) {throw new SQLException("나의 그룹 내역 조회 실패");}
		
		return groupList;
	}
   
   public int manageApplicationInGroup(int groupId, int userId, boolean approved) throws SQLException, NotFoundException{
		int result = groupDAO.findApplication(groupId, userId);
		// 지원서에 없을 경우
		if(result != 1) {throw new NotFoundException();}		
//		result = groupDAO.deleteFromApplyList(groupId, userId);
		if(approved && result == 1) {
			Group group = groupDAO.selectGroup(groupId);
			if(group.getNumberOfUsers() <= group.getGroupMembers().size()) {
				return -3;
			}			
			groupDAO.acceptApply(groupId, userId);
			result = groupDAO.addMemberInGroupMember(groupId, userId, "0");
		} else if (approved == false && result == 1) {
			groupDAO.rejectApply(groupId, userId);
		}
		
		return result;
	}
   
   public ArrayList<User> getAllMemberInGroup (int groupId) throws SQLException, NotFoundException{
      if(!groupDAO.existingGroup(groupId)) {
         throw new NotFoundException(groupId + "는 존재하지 않는 groupId 입니다.");
      }
      
      return groupDAO.getAllMemberInGroup(groupId);
   }
 
   
   public int getNumberOfMemberInGroup(int groupId) throws SQLException, NotFoundException{
      if(!groupDAO.existingGroup(groupId)) {
         throw new NotFoundException(groupId + "는 존재하지 않는 groupId 입니다.");
      }
      return groupDAO.getNumberOfMember(groupId);
   }
   
   public int removeMemberInGroup(int groupId, int memberId) throws SQLException, NotFoundException {
		if(!groupDAO.existingGroup(groupId)) {
			throw new NotFoundException();
		}
		int result = groupDAO.deleteFromApplyList(groupId, memberId);
		return groupDAO.removeMemberInGroup(groupId, memberId);
	}
   
  
   public List<Group> getAllGroup() throws SQLException, NotFoundException{ 
      List<Group> groupList = groupDAO.selectAllGroup();
      return groupList;
   }
   
   public int applyToGroup(int groupId, int userId, String comments) throws SQLException, NotFoundException{
	      if(!groupDAO.existingGroup(groupId)) {
	         throw new NotFoundException(groupId + "는 존재하지 않는 groupId 입니다.");
	      }
	      User user = findUser(userId);
	      Group group = findGroup(groupId);
	      
	      int isExistingUser = groupDAO.findApplication(groupId, userId);
	      int isGroupMember = groupDAO.findUserInGroup(groupId, userId);
	      
	      
	      if (isExistingUser != 0) {
	         System.out.println("이미 해당 그룹에 신청하였습니다. " + isExistingUser);
	         //throw new ExistingException("이미 해당 그룹에 신청하였습니다.");   
	         return -1;
	      }
	      if (isGroupMember != 0) {
	         System.out.println("이미 해당 그룹에 존재하는 멤버입니다. " + isGroupMember);
	         //throw new ExistingException("이미 해당 그룹에 존재하는 멤버입니다.");   
	         return 2;
	      }
	      if (!group.getGenderType().equals("0")) {
	         if (!String.valueOf(user.getGender()).equals(group.getGenderType())) {
	            System.out.println("신청 조건에 맞지 않습니다. 사용자 성별: " + user.getGender() + " 그룹 성별: "  + group.getGenderType());
	            //throw new ConditionMismatchException("신청 조건에 맞지 않습니다.");
	            return 3;
	         }      
	      }
	      if (group.getAge() != 0) {
	         System.out.println("사용자 나이 : " + user.getAge());
	         System.out.println("조건 나이 : " + group.getAge());
	   
	         if (Integer.valueOf(user.getAge()) != Integer.valueOf(group.getAge())) {
	            System.out.println("신청 조건에 맞지 않습니다.");
	            //throw new ConditionMismatchException("신청 조건에 맞지 않습니다.");
	            return 4;
	         }
	      }
	      return groupDAO.applyToGroup(groupId, userId, comments);
	   }

   
   //나의 신청현황
 	public ArrayList<Application> getApplyList(int userId) throws NotFoundException, SQLException {		
 		ArrayList<Application> applyList = userDAO.getApplyList(userId);
 		if(applyList == null) {
 			throw new NotFoundException("나의 신청 현황 조회 실패");
 		}	
 		return applyList;
 	}
 	
 // 해당 그룹 지원서 반환 (단, isApproved가 0인 지원서에 대해서만 반환함)
 	public ArrayList<Application> getAllApplication(int groupId) throws NotFoundException, SQLException {
 		if(!groupDAO.existingGroup(groupId)) {throw new NotFoundException();}
 		
 		return groupDAO.getAllApplication(groupId);
 	}
   
 	
 	//post
    public Post findPost(int postId) throws SQLException, NotFoundException{
       Post post = postDAO.getOnePost(postId);
       if(post == null) {
          throw new NotFoundException(postId + "는 존재하지 않는 게시물입니다.");
       }
       return post;
    }
    
    public ArrayList<Post> getAllPost(int groupId) throws SQLException, NotFoundException {
       if(!groupDAO.existingGroup(groupId)) {
          throw new NotFoundException(groupId + "는 존재하지 않는 groupId 입니다.");
       }
       return postDAO.getPostList(groupId);
    }

    public int createPost(Post post) throws SQLException, AppException{
       try {
          int postId = postDAO.addPost(post);
          return postId;
       } catch (Exception e) {
          throw new AppException("게시글 등록에 실패하였습니다.");
       }   
    }
    
    public int updatePost(Post post) throws SQLException, NotFoundException{
       if(!postDAO.existingPost(post.getPostId())){
          throw new NotFoundException(post.getPostId() + "는 존재하지 않는 게시물입니다.");
       }
       return postDAO.updatePost(post);
    }
    
    public int removePost(int postId) throws SQLException, NotFoundException{
       if(!postDAO.existingPost(postId)){
          throw new NotFoundException(postId + "는 존재하지 않는 게시물입니다.");
       }
       commentDAO.deleteAllComments(postId);
       
       return postDAO.removePost(postId);
    }
    
    //comment
    public Comment findComment(int commentId) throws SQLException, NotFoundException{

       Comment comment = commentDAO.selectCommentByPrimaryKey(commentId);
       if(comment == null) {throw new NotFoundException(commentId + "는 존재하지 않는 댓글입니다.");}
       
       return comment;
    }
    
    public int numberOfComment(int postId) throws SQLException, NotFoundException{
       if(!postDAO.existingPost(postId)) {throw new NotFoundException(postId + "는 존재하지 않는 게시물입니다.");}
    
       return commentDAO.selectCommentCount(postId);
    }
    
    public ArrayList<Comment> getAllComment(int postId) throws SQLException, NotFoundException{
       if(!postDAO.existingPost(postId)) {throw new NotFoundException(postId + "는 존재하지 않는 게시물입니다.");}
       
       return commentDAO.selectAllComment(postId);
    }
    
    public int createComment(Comment comment) throws SQLException, AppException{
       try {
          commentDAO.insertComment(comment);
          return comment.getComment_id();
       } catch (Exception e) {
          throw new AppException("댓글 등록에 실패하였습니다.");
       }
    }
    
    public int removeComment(int commentId) throws SQLException, NotFoundException{
       if(!commentDAO.existingComment(commentId)) {throw new NotFoundException(commentId + "는 존재하지 않는 댓글입니다.");}
       
       return commentDAO.deleteComment(commentId);
    }
}
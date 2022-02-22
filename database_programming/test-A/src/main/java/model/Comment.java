package model;

import java.io.Serializable;
import java.util.*;

public class Comment implements Serializable{
   private int comment_id; 
   private User userName;
   private Date createdDate = null; 
   private Date modifiedDate = null; 
   private String content;
   private int postId; 
   private int groupId;
   private int writer_id; 
   
   private String member_name;
   
   public Comment() {
      super();
      // TODO Auto-generated constructor stub
   }
   
   
   public Comment(int postId, int comment_id, User userName, Date createdDate, Date modifiedDate, String content, 
         int refMember, int refGroup) {
      super();
      this.postId = postId;
      this.comment_id = comment_id;
      this.userName = userName;
      this.createdDate = createdDate;
      this.modifiedDate = modifiedDate;
      this.content = content;
      this.writer_id = refMember;
      this.groupId = refGroup;
   }
   
   public int getComment_id() {
      return comment_id;
   }
   
   public void setComment_id(int comment_id) {
      this.comment_id = comment_id;
   }
   public User getUserName() {
		return userName;
	}
	public void setUserName(User userName) {
		this.userName = userName;
	}
   public Date getCreatedDate() {
      return createdDate;
   }
   
   public void setCreatedDate(Date createdDate) {
      this.createdDate = createdDate;
   }
   
   public Date getModifiedDate() {
      return modifiedDate;
   }
   
   public void setModifiedDate(Date modifiedDate) {
      this.modifiedDate = modifiedDate;
   }
   
   public String getContent() {
      return content;
   }
   
   public void setContent(String content) {
      this.content = content;
   }
   
   public int getPostId() {
      return postId;
   }
   
   public void setPostId(int postId) {
      this.postId = postId;
   }

   public int getGroupId() {
      return groupId;
   }

   public void setGroupId(int groupId) {
      this.groupId = groupId;
   }

   public int getWriter_id() {
      return writer_id;
   }

   public void setWriter_id(int writer_id) {
      this.writer_id = writer_id;
   }
   public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String memeber_name) {
		this.member_name = memeber_name;
	}


   @Override
   public String toString() {
      // TODO Auto-generated method stub
      return super.toString();
   }
   
}
   


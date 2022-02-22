package model;

import java.util.*;

public class Post {
   private int postId; 
   private String title;
   private Date createdDate; 
   private Date modifiedDate;
   private String userName;
   private String content; 
   private int writer_id; 
   private int group_id; 
   
   public Post() {
      super();
   }
   
   public Post(int postId, String title, Date createdDate, Date modifiedDate, String userName, String content,
         int refMember, int refGroup) {
      super();
      this.postId = postId;
      this.title = title;
      this.createdDate = createdDate;
      this.modifiedDate = modifiedDate;
      this.userName = userName;
      this.content = content;
      this.writer_id = refMember;
      this.group_id = refGroup;
   }

   public int getPostId() {
      return postId;
   }
   
   public void setPostId(int postId) {
      this.postId = postId;
   }
   
   public String getTitle() {
      return title;
   }
   
   public void setTitle(String title) {
      this.title = title;
   }

   public String getUserName() {
      return userName;
   }
   
   public void setUserName(String userName) {
      this.userName = userName;
   }
   
   public String getContent() {
      return content;
   }
   
   public void setContent(String content) {
      this.content = content;
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

   public int getWriter_id() {
      return writer_id;
   }
   
   public void setWriter_id(int writer_id) {
      this.writer_id = writer_id;
   }
   
   public int getGroup_id() {
      return group_id;
   }

   public void setGroup_id(int group_id) {
      this.group_id = group_id;
   }

   
}
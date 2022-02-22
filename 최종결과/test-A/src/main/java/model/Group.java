package model;

import java.io.Serializable;
import java.util.ArrayList;

public class Group implements Serializable {

   int groupId; 
   java.util.Date createdDate; 
   int numberOfUsers ; 
   String groupName; 
   String description; 
   int term; 
   String place; 
   String genderType; 
   String trafficType; 
   int age; 
   int leaderId; 
   ArrayList<User> groupMembers;
   
   public Group(int numberOfUsers, String groupName, String description, int term, String place,
         String genderType, String trafficType, int age) {
      
      super();
      this.numberOfUsers = numberOfUsers;
      this.groupName = groupName;
      this.description = description;
      this.term = term;
      this.place = place;
      this.genderType = genderType;
      this.trafficType = trafficType;
      this.age = age;
   }

   public Group() {

   }
   
   public int getGroupId() {
      return groupId;
   }



   public void setGroupId(int _id) {
      this.groupId = _id;
   }



   public java.util.Date getCreatedDate() {
      return createdDate;
   }



   public void setCreatedDate(java.util.Date createdDate) {
      this.createdDate = createdDate;
   }



   public int getNumberOfUsers() {
      return numberOfUsers;
   }



   public void setNumberOfUsers(int numberOfUsers) {
      this.numberOfUsers = numberOfUsers;
   }
   
   public String getGroupName() {
      return groupName;
   }



   public void setGroupName(String groupName) {
      this.groupName = groupName;
   }



   public String getDescription() {
      return description;
   }



   public void setDescription(String description) {
      this.description = description;
   }



   public int getTerm() {
      return term;
   }



   public void setTerm(int term) {
      this.term = term;
   }



   public String getPlace() {
      return place;
   }



   public void setPlace(String place) {
      this.place = place;
   }



   public String getGenderType() {
      return genderType;
   }



   public void setGenderType(String genderType) {
      this.genderType = genderType;
   }



   public String getTrafficType() {
      return trafficType;
   }



   public void setTrafficType(String trafficType) {
      this.trafficType = trafficType;
   }



   public int getAge() {
      return age;
   }



   public void setAge(int age) {
      this.age = age;
   }



   public int getLeaderId() {
      return leaderId;
   }

   public void setLeaderId(int leaderId) {
      this.leaderId = leaderId;
   }

   public ArrayList<User> getGroupMembers() {
      return groupMembers;
   }



   public void setGroupMembers(ArrayList<User> groupMembers) {
      this.groupMembers = groupMembers;
   }

}
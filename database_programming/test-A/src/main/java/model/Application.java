package model;

public class Application {

   int memberId;
   String memberName;
   int groupId;
   String groupName;
   String applyDate;
   String isApproved;
   String approvedDate;
   String comment; //지원자가 남기는 간단한 메시지
   
   public int getMemberId() {
      return memberId;
   }
   public void setMemberId(int memberId) {
      this.memberId = memberId;
   }
   public String getMemberName() {
      return memberName;
   }
   public void setMemberName(String memberName) {
      this.memberName = memberName;
   }
   public int getGroupId() {
      return groupId;
   }
   public void setGroupId(int groupId) {
      this.groupId = groupId;
   }
   public String getGroupName() {
      return groupName;
   }
   public void setGroupName(String groupName) {
      this.groupName = groupName;
   }
   public String getApplyDate() {
      return applyDate;
   }
   public void setApplyDate(String applyDate) {
      this.applyDate = applyDate;
   }
   public String getIsApproved() {
      return isApproved;
   }
   public void setIsApproved(String isApproved) {
      this.isApproved = isApproved;
   }
   public String getApprovedDate() {
      return approvedDate;
   }
   public void setApprovedDate(String approvedDate) {
      this.approvedDate = approvedDate;
   }
   public String getComment() {
      return comment;
   }
   public void setComment(String comment) {
      this.comment = comment;
   }
}
package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.naming.java.javaURLContextFactory;

import model.Application;
import model.Group;
import model.User;
import model.service.AppException;

public class UserDAO {
   private static UserDAO ud = new UserDAO();
   private JDBCUtil jdbcUtil = null;
   
   private UserDAO() {
      jdbcUtil = new JDBCUtil();
   }
   public static UserDAO getInstance() {
      return ud;
   }
      
   public int userCreate(User user) throws SQLException {
      int result = 0;
      String query = "INSERT INTO MEMBER (user_id, email, password, name, phone, "
            + "age, gender)"
            + " VALUES (SEQUENCE_USER.NEXTVAL, ?, ?, ?, ?, ?, ?)";
      
      Object[] param = new Object[] {user.getEmail(), user.getPassword(), user.getName(),
            user.getPhone(), user.getAge(), user.getGender()};
      
      jdbcUtil.setSqlAndParameters(query, param);
      try {
         result = jdbcUtil.executeUpdate();
         jdbcUtil.commit();
      }catch (Exception ex) {
         jdbcUtil.rollback();
         ex.printStackTrace();
      } finally {      
         jdbcUtil.close();   
      }      
      return result;
   }

   public boolean existingUser(String email, String password) throws SQLException{
      boolean result = false;
      String query = "SELECT * FROM MEMBER WHERE email=? and password=?";
      jdbcUtil.setSqlAndParameters(query, new Object[] {email, password});
      
      try {
         ResultSet rs = jdbcUtil.executeQuery();
         
         if(rs.next()) {
            result = true;
         }
         jdbcUtil.commit();
      }catch(Exception ex) {
         ex.printStackTrace();
         jdbcUtil.rollback();
      }finally {
         jdbcUtil.close();
      }
      return result;
   }
   
   public User findUser(int userId) throws SQLException{
      String query = "SELECT *"
            + "FROM MEMBER "
            + "WHERE USER_ID =?";
      
      jdbcUtil.setSqlAndParameters(query, new Object[] {userId});
      ResultSet rs = null;
      User user = null;
      try {
         rs = jdbcUtil.executeQuery();
         if(rs.next()) {
            user = new User(
                  rs.getInt("user_Id"),
                  rs.getString("email"),
                  rs.getString("phone"),
                  rs.getString("password"),
                  rs.getString("name"),
                  rs.getInt("age"),
                  rs.getInt("gender"));         
         }
         jdbcUtil.commit();
      }catch(Exception ex) {
         ex.printStackTrace();
         jdbcUtil.rollback();
      } finally {
         jdbcUtil.close();      // resource 諛섑솚
      }
      return user;
   }
   
   public User findUser(String email) throws SQLException{
      String query = "SELECT * "
            + "FROM MEMBER "
            + "WHERE email=?";
      
      jdbcUtil.setSqlAndParameters(query, new Object[] {email});
      ResultSet rs = null;
      User user = null;
      try {
         rs = jdbcUtil.executeQuery();
         if(rs.next()) {
            user = new User(
                  rs.getInt("user_id"),
                  rs.getString("email"),
                  rs.getString("phone"),
                  rs.getString("password"),
                  rs.getString("name"),
                  rs.getInt("age"),
                  rs.getInt("gender"));         
         }
         jdbcUtil.commit();
      }catch(Exception ex) {
         ex.printStackTrace();
         jdbcUtil.rollback();
      } finally {
         jdbcUtil.close();      
      }
      return user;
   }
   
   public int userInfoUpdate(User user) throws SQLException {
      int result = 0;
      String query = "UPDATE MEMBER "
            + "SET name=?, phone=?, email=?, password=? WHERE user_id=?";
   
      Object[] param = new Object[] {user.getName(), user.getPhone(), user.getEmail(), user.getPassword(), 
              user.getUser_id()};
      jdbcUtil.setSqlAndParameters(query, param);
      
      try {
         result = jdbcUtil.executeUpdate();
         jdbcUtil.commit();
      }catch (Exception ex) {
         jdbcUtil.rollback();
         ex.printStackTrace();
      }finally {
         jdbcUtil.close();
      }
      return result;
   }


   public ArrayList<Group> getMyGroupList(int userId) throws SQLException{
      
      ArrayList<Group> groupList = new ArrayList<Group>();
      
      String query = "select * from GROUPMEMBER gm, TRAVELGROUP t "
            + "where gm.group_id = t.group_id and user_id=?";
      Object[] param = new Object[] {userId};
      jdbcUtil.setSqlAndParameters(query, param);
      try {
         ResultSet rs = jdbcUtil.executeQuery();      
         while(rs.next()) {
            Group tg = new Group();
            
            tg.setGroupId(rs.getInt("group_id"));
            tg.setCreatedDate(rs.getDate("created_date"));
            tg.setNumberOfUsers(rs.getInt("number_of_member"));
            tg.setGroupName(rs.getString("name"));
            tg.setDescription(rs.getString("description"));
            tg.setTerm(rs.getInt("term"));
            tg.setPlace(rs.getString("place")); 
            tg.setTrafficType(rs.getString("traffic")); 
            tg.setGenderType(rs.getString("gender_type"));
            tg.setLeaderId(rs.getInt("leader_id"));
            
            groupList.add(tg);
      }
         jdbcUtil.commit();
         return groupList;
      }catch(Exception ex) {
         jdbcUtil.rollback();
         ex.printStackTrace();
      }finally {
         jdbcUtil.close();   
      }
      return null;   
   }
   
 	public ArrayList<Group> getManageGroupList(int memberId) throws SQLException{
 		
 		ArrayList<Group> groupList = new ArrayList<Group>();
 		String query ="SELECT * " 
 				+ "FROM travelgroup "
 				+ "WHERE leader_id=?";
 		Object[] param = new Object[] {memberId};
 		jdbcUtil.setSqlAndParameters(query, param);
 		
 		try {
 			ResultSet rs = jdbcUtil.executeQuery();		
 			while(rs.next()) {
 				Group g = new Group();
 				
 				g.setGroupId(rs.getInt("group_id"));
 	            g.setCreatedDate(rs.getDate("created_date"));
 	            g.setNumberOfUsers(rs.getInt("number_of_member"));
 	            g.setGroupName(rs.getString("name"));
 	            g.setDescription(rs.getString("description"));
 	            g.setTerm(rs.getInt("term"));
 	            g.setPlace(rs.getString("place")); 
 	            g.setTrafficType(rs.getString("traffic")); 
 	            g.setGenderType(rs.getString("gender_type"));
 	            g.setLeaderId(rs.getInt("leader_id"));
 				
 				groupList.add(g);
 		}
 			jdbcUtil.commit();
 			return groupList;
 		}catch(Exception ex) {
 			jdbcUtil.rollback();
 			ex.printStackTrace();
 		}finally {
 			jdbcUtil.close();	
 		}
 		
 		return null;
 	}
 	
   
 	public ArrayList<Application> getApplyList(int memberId) {
 		String query = "SELECT m.name mName, tg.group_id tgGroup_id, tg.name tgName, apply_date, approved_date, isApproved, commt "
 				+ "FROM TRAVELGROUP tg, APPLYLIST a, MEMBER m "
 				+ "WHERE m.user_id=a.user_id AND tg.group_id=a.group_id AND m.user_id=?";
 		Object[] param = new Object[] {memberId};
 		jdbcUtil.setSqlAndParameters(query, param);
 		try {
 			ResultSet rs = jdbcUtil.executeQuery();
 			if(rs == null) {throw new AppException();}
 			
 			ArrayList<Application> applyList = new ArrayList<Application>();
 			
 			while (rs.next()) {
 				Application apply = new Application();
 				
 				apply.setMemberId(memberId);
 				apply.setMemberName(rs.getString("mName"));
 				apply.setGroupId(rs.getInt("tgGroup_id"));
 				apply.setGroupName(rs.getString("tgName"));		
 				
 				java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy/MM/dd");
 				java.util.Date utilDate = new java.util.Date(rs.getDate("apply_date").getTime());
 				String apply_date = df.format(utilDate); 
 				apply.setApplyDate(apply_date);
 				
 				utilDate = new java.util.Date(rs.getDate("apply_date").getTime());
 				String approved_date = df.format(utilDate); 
 				apply.setApplyDate(approved_date);
 				
 				String approved = rs.getString("isApproved");
 				if (approved.equals("1"))
 					apply.setIsApproved("수락 완료");
 				else if(approved.equals("2")) 
 					apply.setIsApproved("수락 거절");
 				else
 					apply.setIsApproved("수락 대기");
 				apply.setComment(rs.getString("commt"));
 					 
 				applyList.add(apply);
 			}
 			jdbcUtil.commit();
 			return applyList;
 		} catch (Exception ex) {
 			jdbcUtil.rollback();
 			ex.printStackTrace();
 		} finally {
 			jdbcUtil.close();
 		}
 		
 		return null;
 	}
 	
}
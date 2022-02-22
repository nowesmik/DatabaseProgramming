package model.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.example.repository.mapper.TotalMapper;

import model.Application;

import model.Group;
import model.User;
import model.service.AppException;

public class GroupDAO {
   private static GroupDAO dao = new GroupDAO();
   JDBCUtil jdbcUtil = null;
   private SqlSessionFactory sqlSessionFactory;
   
   private GroupDAO() {
      jdbcUtil = new JDBCUtil();
		
		String resource = "mybatis-config.xml";
		InputStream inputStream;
		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			throw new IllegalArgumentException(e);
		}
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
   }
   
   public static GroupDAO getInstance() {
      return dao;
   }
   
	public ArrayList<Group> selectAllGroup(){
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try { 
			return sqlSession.getMapper(TotalMapper.class).selectAllGroup();			
		} finally {
			sqlSession.close();
		}
	}
	
	public Group selectGroup(int groupId) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.getMapper(TotalMapper.class).selectGroup(groupId);			
		} finally {
			sqlSession.close();
		}
	}
	
   public int addGroup(Group tg, int memberId) throws SQLException{
      int result = 0;
      int key = 0;
      String query1 = "INSERT INTO TRAVELGROUP (group_id, leader_id, created_date, number_of_member, name, "
    		  + "term, gender_type, age, description, traffic, place) "
               + "VALUES (SEQUENCE_GROUP.NEXTVAL, ?, SYSDATE, ?, ?, ?, ?, ?, ?, ?, ?)";
      String query2 = "SELECT SEQUENCE_GROUP.CURRVAL as group_id FROM DUAL";
      ResultSet rs = null;

      Object[] param = new Object[] {memberId, tg.getNumberOfUsers(), tg.getGroupName(), tg.getTerm(), 
    		   tg.getGenderType(), tg.getAge(), tg.getDescription(),tg.getTrafficType(), tg.getPlace() };
      Object[] param2 = new Object[] {};
      try {
         jdbcUtil.setSqlAndParameters(query1, param);
         result = jdbcUtil.executeUpdate();
         if(result != 1) {throw new AppException();}
         
         jdbcUtil.setSqlAndParameters(query2, param2);
         rs = jdbcUtil.executeQuery();
         if(rs.next()) {
            tg.setGroupId(rs.getInt("group_id"));
            tg.setLeaderId(memberId);
            key = rs.getInt("group_id");
         }
         jdbcUtil.commit();
      }catch (Exception ex) { 
         jdbcUtil.rollback();
         ex.printStackTrace();
      } finally {      
         jdbcUtil.close();   
      }      
      return key;
   }
   
   public int addMemberInGroupMember(int group_id, int member_id, String isLeader) {
      String query = "insert into GROUPMEMBER values(?, ?, ?)";
      
      Object [] param = new Object[] {isLeader, member_id, group_id};
      
      jdbcUtil.setSqlAndParameters(query, param);
      int result = 0;   
      try {
         result = jdbcUtil.executeUpdate();
         if(result != 1) {throw new AppException();}
         jdbcUtil.commit();
      }catch (Exception ex) {
         jdbcUtil.rollback();
         ex.printStackTrace();
      } finally {      
         jdbcUtil.close();   
      }      
      return result;
   }
   
   public int removeGroup(int groupId) throws SQLException {
      
      int result = 0;
      String query = "DELETE FROM TRAVELGROUP WHERE group_id=?";
      
      Object [] param = new Object[] {groupId};
      jdbcUtil.setSqlAndParameters(query, param);
      
      try {
         result = jdbcUtil.executeUpdate();
         jdbcUtil.commit();
      }catch(Exception e) {
         jdbcUtil.rollback();
      }finally {
         jdbcUtil.close();
      }
      
      return result;
   }
   
   public int removeAllApply(int groupId) {
		int result = 0;
		String query = "DELETE FROM applylist WHERE group_id=?";
		
		Object [] param = new Object[] {groupId};
		jdbcUtil.setSqlAndParameters(query, param);
		
		try {
			result = jdbcUtil.executeUpdate();
//			if(result != 1) {throw new AppException();}
			jdbcUtil.commit();
		}catch(Exception e) {
			jdbcUtil.rollback();
		}finally {
			jdbcUtil.close();
		}

		return result;
	}
   
   public int removeMemberInGroup(int groupId, int memberId) throws SQLException{
      int result = 0;
      String query;
      Object [] param;
      if(memberId == -1) { 
         query = "DELETE FROM groupmember WHERE group_id=?";
         param = new Object[] {groupId};
      }else {
         query = "DELETE FROM groupmember WHERE group_id=? and user_id=?";
         param = new Object[] {groupId, memberId};
      }
      
      jdbcUtil.setSqlAndParameters(query, param);
      
      try {
         result = jdbcUtil.executeUpdate(); 
         jdbcUtil.commit();
      }catch(Exception e) {
         jdbcUtil.rollback();
      }finally {
         jdbcUtil.close();
      }
      
      return result;
   }
   
   public int updateGroup(Group group) {
      int result = 0;
      String query = "UPDATE TRAVELGROUP SET name=? , number_of_member=? , term=? , place=? "
            +", gender_type=? , traffic=? , leader_id=? , description=? , age=? "
            + "WHERE group_id=?";
         
      Object [] param = new Object[] {
            group.getGroupName(), group.getNumberOfUsers(), group.getTerm(), group.getPlace()
            , group.getGenderType(), group.getTrafficType(), group.getLeaderId(), group.getDescription(),
            group.getAge(), group.getGroupId() };
      
      jdbcUtil.setSqlAndParameters(query, param);
      try {
         result = jdbcUtil.executeUpdate();
         if(result != 1) {throw new AppException();}
         jdbcUtil.commit();
      }catch(Exception e) {
         jdbcUtil.rollback();
      }finally {
         jdbcUtil.close();
      }
      
      return result;
   }
   
   public int applyToGroup(int groupId, int userId, String comments) {
		int result = 0;
		String query = "INSERT INTO APPLYLIST (user_id, group_id, apply_date, isApproved, commt) values(?, ?, SYSDATE, ?, ?)";
		
		Object [] param = new Object[] {userId, groupId, "0", comments};
		
		jdbcUtil.setSqlAndParameters(query, param);
		
		try {
			result = jdbcUtil.executeUpdate();
			jdbcUtil.commit();
		}catch(Exception e) {
			jdbcUtil.rollback();
		}finally {
			jdbcUtil.close();
		}
		
		return result;
	}

	public int deleteFromApplyList(int groupId, int userId) {
		int result = 0;
		String query;
		Object [] param;
		query = "DELETE FROM applyList where user_id=? and group_id=?";
		param = new Object[] {userId, groupId};
		
		jdbcUtil.setSqlAndParameters(query, param);
		
		try {
			result = jdbcUtil.executeUpdate();
			if(result != 1) {throw new AppException();}
			jdbcUtil.commit();
		}catch(Exception e) {
			jdbcUtil.rollback();
		}finally {
			jdbcUtil.close();
		}
		
		return result;
	}

	public ArrayList<Application> getAllApplication(int groupId) throws SQLException{
		String query = "select a.user_id, name, group_id, apply_date, isapproved, approved_date, commt from APPLYLIST a, MEMBER m "
				+ "where group_id=? and a.user_id=m.user_id";
		
		ResultSet rs = null;
		Object [] param = new Object[] {groupId};
		
		jdbcUtil.setSqlAndParameters(query, param);
		
		try {
			rs = jdbcUtil.executeQuery();
			ArrayList<Application> applyList = new ArrayList<Application>();
			
			while(rs.next()) {
				Application apply = new Application();
				apply.setMemberId(rs.getInt("user_id"));
				apply.setMemberName(rs.getString("name"));
				apply.setGroupId(rs.getInt("group_id"));
				
				java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy/MM/dd");
				java.util.Date utilDate = new java.util.Date(rs.getDate("apply_date").getTime());
				String apply_date = df.format(utilDate); 
				apply.setApplyDate(apply_date);
				
				apply.setIsApproved(rs.getString("isapproved"));
				
				utilDate = new java.util.Date(rs.getDate("apply_date").getTime());
				String approved_date = df.format(utilDate); 
				apply.setApplyDate(approved_date);
				
				apply.setComment(rs.getString("commt"));
				
				applyList.add(apply);
			}
			jdbcUtil.commit();
			return applyList;
		}catch(Exception e) {
			jdbcUtil.rollback();
		}finally {
			jdbcUtil.close();
		}
		
		return null;
	}
	
	public int findApplication(int groupId, int userId) {
		int result = 0;
		String query = "select * from applylist where group_id=? and user_id=?";
		
		ResultSet rs = null;
		Object [] param = new Object[] {groupId, userId};
		
		jdbcUtil.setSqlAndParameters(query, param);
		
		try {
			rs = jdbcUtil.executeQuery();
			if(!rs.next())
				result = 0;
			else
				result = 1;
			jdbcUtil.commit();
		}catch(Exception e) {
			jdbcUtil.rollback();
		}finally {
			jdbcUtil.close();
		}
		
		return result;
	}

   public int findUserInGroup (int groupId, int userId) {
      int result = 0;
      String query = "select * from groupmember where group_id=? and user_id=?";
      
      ResultSet rs = null;
      Object [] param = new Object[] {groupId, userId};
      
      jdbcUtil.setSqlAndParameters(query, param);
      
      try {
         rs = jdbcUtil.executeQuery();
         if(!rs.next())
            result = 0;
         else
            result = 1;
         jdbcUtil.commit();
      }catch(Exception e) {
         jdbcUtil.rollback();
      }finally {
         jdbcUtil.close();
      }
      
      return result;
      
   }
   
   public ArrayList<Group> searchGroupList(Integer term, Integer numOfMem, String place, String gender_type, String traffic_type, int age) throws SQLException {
      String query = "SELECT * FROM TRAVELGROUP where ";
      ResultSet rs = null;
      Object [] selected = new Object[] {null, null, null, null, null, null};
      int i = 0;
      
      if(term != -1) { 
         if(i != 0) {query += "and ";}
         query += "term=? ";
         selected[i++] = term;
      }
      if(numOfMem != -1) {
         if(i != 0) {query += "and ";}
         query += "number_Of_member=? ";
         selected[i++] = numOfMem;
      }
      if(!place.equals("")) { 
         if(i != 0) {query += "and ";}
         query += "place=? ";
         selected[i++] = place;
      }
      if(Integer.valueOf(gender_type) != -1) {
         if(i != 0) {query += "and ";}
         query += "gender_type=? ";
         selected[i++] = gender_type;
      }
      if(Integer.valueOf(traffic_type) != -1) {
         if(i != 0) {query += "and ";}
         query += "traffic=?";
         selected[i++] = traffic_type;
      }
      if(Integer.valueOf(age) != -1) {
          if(i != 0) {query += "and ";}
          query += "age=?";
          selected[i++] = age;
       }
      
      if(i != 0) { 
         Object[] param = new Object[i];
         for(int j = 0; j < 6; j++) {
            if(selected[j] != null) {
               param[j] = selected[j];
            }
         }
         jdbcUtil.setSqlAndParameters(query, param);
      } else {
         query = "SELECT * FROM TRAVELGROUP";
         jdbcUtil.setSqlAndParameters(query, null);
      }
           
      try {
         rs = jdbcUtil.executeQuery();
         ArrayList<Group> groupList = null;         
         while (rs.next()) {
            if (groupList == null) {
               groupList = new ArrayList<Group>();
            }
            Group group = new Group();
               
            group.setGroupId(rs.getInt("group_id"));
            group.setCreatedDate(rs.getDate("created_date"));
            group.setNumberOfUsers(rs.getInt("number_of_member"));
            group.setGroupName(rs.getString("name"));
            group.setDescription(rs.getString("description"));
            group.setTerm(rs.getInt("term"));
            group.setPlace(rs.getString("place"));
            group.setGenderType(rs.getString("gender_type"));
            group.setTrafficType(rs.getString("traffic"));
            group.setAge(rs.getInt("age"));
            group.setLeaderId(rs.getInt("leader_id"));
            
            groupList.add(group);
         }
         jdbcUtil.commit();
         return groupList;
      } catch (Exception ex) {
         jdbcUtil.rollback();
         ex.printStackTrace();
      } finally {
         jdbcUtil.close();
      }
         
      return null;
   }
   
   public int acceptApply(int groupId, int userId) {
		int result = 0;
		String query;
		Object [] param;
		query = "update applylist set isapproved=?, approved_date=sysdate " +
		"where group_id=? and user_id=?";
		param = new Object[] {1, groupId, userId};
		
		jdbcUtil.setSqlAndParameters(query, param);
		
		try {
			result = jdbcUtil.executeUpdate();
			if(result != 1) {throw new AppException();}
			jdbcUtil.commit();
		}catch(Exception e) {
			jdbcUtil.rollback();
		}finally {
			jdbcUtil.close();
		}
		
		return result;	
	}

	public int rejectApply(int groupId, int userId) {
		int result = 0;
		String query;
		Object [] param;
		query = "update applylist set isapproved=? " +
		"where group_id=? and user_id=?";
		param = new Object[] {2, groupId, userId};
		
		jdbcUtil.setSqlAndParameters(query, param);
		
		try {
			result = jdbcUtil.executeUpdate();
			if(result != 1) {throw new AppException();}
			jdbcUtil.commit();
		}catch(Exception e) {
			jdbcUtil.rollback();
		}finally {
			jdbcUtil.close();
		}
		
		return result;	
	}
   
   public ArrayList<User> getAllMemberInGroup(int groupId){
      String query = "SELECT * from GROUPMEMBER gm, MEMBER m "
            + "where gm.user_id = m.user_id and gm.group_id=?";
      Object[] param = new Object[] {groupId};
         
      jdbcUtil.setSqlAndParameters(query, param);
         
      try {
         ResultSet rs = jdbcUtil.executeQuery();
         ArrayList<User> memberList = new ArrayList<User>();
            
         while (rs.next()) {
            User member = new User();
            member.setUser_id(rs.getInt("user_id"));
            member.setEmail(rs.getString("email"));
            member.setPassword(rs.getString("password"));
            member.setName(rs.getString("name"));
            member.setPhone(rs.getString("phone"));
            member.setGender(rs.getInt("gender"));
            member.setAge(rs.getInt("age"));
            memberList.add(member);
         }
         jdbcUtil.commit();
         return memberList;
      } catch (Exception ex) {
         jdbcUtil.rollback();
         ex.printStackTrace();
      } finally {
         jdbcUtil.close();
      }
         
      return null;
   }
   
   public int getNumberOfMember(int groupId) {
      int result = 0;
      String query = "select count(*) as count from GROUPMEMBER where group_id=?";
      
      ResultSet rs = null;
      Object [] param = new Object[] {groupId};
      
      jdbcUtil.setSqlAndParameters(query, param);
      
      try {
         rs = jdbcUtil.executeQuery();
         if(rs.next()){
            result = rs.getInt("count");
         }
         jdbcUtil.commit();
      }catch(Exception e) {
         jdbcUtil.rollback();
      }finally {
         jdbcUtil.close();
      }
      
      return result;
   }
   
   public boolean existingGroup(int groupId) {
      String query = "SELECT * FROM TRAVELGROUP WHERE group_id=?";
      jdbcUtil.setSqlAndParameters(query, new Object[] {groupId});
      
      int result = 0;
      try {         
         result = jdbcUtil.executeUpdate();
      }catch(Exception ex) {
         ex.printStackTrace();
      }finally {
         jdbcUtil.close();
      }
      
      if(result == 1) return true;
      return false;
   }
   
}
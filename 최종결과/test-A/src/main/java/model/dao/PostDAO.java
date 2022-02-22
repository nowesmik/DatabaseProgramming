package model.dao;

import model.Post;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PostDAO {
   private static PostDAO dao = new PostDAO();
   private JDBCUtil jdbcUtil = null;
   
   private PostDAO() {
      jdbcUtil = new JDBCUtil();
   }
   
   public static PostDAO getInstance() {
      return dao;
   }
   
   public boolean existingPost(int postId) throws SQLException{
      boolean result = false;
      String query = "select * from POST where post_id=?";
      jdbcUtil.setSqlAndParameters(query, new Object[] {postId});
      
      try {
         ResultSet rs = jdbcUtil.executeQuery();
         if (rs.next()) {
            result = true;
         }
         jdbcUtil.commit();
      } catch (Exception ex) {
         ex.printStackTrace();
         jdbcUtil.rollback();
      } finally {
         jdbcUtil.close();
      }
      
      return result;
   }
   
   public ArrayList<Post> getPostList(int groupId) throws SQLException {
      String query = "SELECT * "
            + "FROM post p JOIN member m ON (p.writer_id=m.user_id) "
            + "WHERE group_id = ? ORDER BY created_date DESC";
      
      jdbcUtil.setSqlAndParameters(query, new Object[] {groupId});
      
      try {
         ResultSet rs = jdbcUtil.executeQuery();
         ArrayList<Post> postList = new ArrayList<Post>();
         
         while (rs.next()) {
            Post post = new Post();
            
            post.setPostId(rs.getInt("post_id"));
            post.setUserName(rs.getString("name"));
            post.setTitle(rs.getString("title"));
            post.setContent(rs.getNString("content"));
            post.setCreatedDate(rs.getDate("created_date"));
            post.setModifiedDate(rs.getDate("modified_date"));
            post.setWriter_id(rs.getInt("writer_id"));
            post.setGroup_id(rs.getInt("group_id"));
            postList.add(post);
         }
         return postList;
      } catch (Exception ex) {
         ex.printStackTrace();
      } finally {
         jdbcUtil.close();
      }
      
      return null;
   }
   
   
   public Post getOnePost(int postId) throws SQLException {
      String query = "SELECT name, title, content, created_date, modified_date, writer_id, group_id "
            + "FROM post p JOIN member m ON (p.writer_id=m.user_id)"
            + "WHERE post_id = ?";
      
      jdbcUtil.setSqlAndParameters(query, new Object[] {postId});
      
      try {
         ResultSet rs = jdbcUtil.executeQuery();
         
         if (rs.next()) {
            Post post = new Post();

            post.setPostId(postId);
            post.setUserName(rs.getString("name"));
            post.setTitle(rs.getString("title"));
            post.setContent(rs.getNString("content"));
            post.setCreatedDate(rs.getDate("created_date"));
            post.setModifiedDate(rs.getDate("modified_date"));
            post.setWriter_id(rs.getInt("writer_id"));
            post.setGroup_id(rs.getInt("group_id"));
            
            return post;
         }
      } catch (Exception ex) {
         ex.printStackTrace();
      } finally {
         jdbcUtil.close();
      }
      
      return null;
   }
   
   public int addPost(Post post) throws SQLException {     
      String query = "INSERT INTO post (post_id, title, content, created_date, writer_id, group_id) "
            + "VALUES (SEQUENCE_POST.nextval, ?, ?, SYSDATE, ?, ?)";
      String query2 = "SELECT SEQUENCE_POST.CURRVAL AS POST_ID FROM DUAL";
      Object[] param = new Object[] {post.getTitle(), post.getContent(), post.getWriter_id(), post.getGroup_id()};
      Object[] param2 = new Object[] {};
      
      ResultSet rs = null;   
      try {
         jdbcUtil.setSqlAndParameters(query, param);
         int result = jdbcUtil.executeUpdate();
         
         if (result > 0) {
            jdbcUtil.setSqlAndParameters(query2, param2);
            rs = jdbcUtil.executeQuery();
            if (rs.next()) {
               result = rs.getInt("POST_ID");
            }
         }
         
         return result;
      } catch (Exception ex) {
         jdbcUtil.rollback();
         ex.printStackTrace();
      } finally {      
         jdbcUtil.commit();
         jdbcUtil.close();
      }
      
      return 0;
   }
   
   public int updatePost(Post post) throws SQLException {
      //jdbcUtil.setAutoCommit(false);
      
      String query = "UPDATE post SET title = ?, content = ?, modified_date = SYSDATE "
            + "WHERE post_id = ?";
      Object[] param = new Object[] {post.getTitle(), post.getContent(), post.getPostId()};
      jdbcUtil.setSqlAndParameters(query, param);
      
      try {
         int result = jdbcUtil.executeUpdate();
         
         if (result != 1) {
            jdbcUtil.rollback();
         } else {
            jdbcUtil.commit();
         }
         
         return result;
      } catch (Exception ex) {
         jdbcUtil.rollback();
         ex.printStackTrace();
      } finally {      
         jdbcUtil.commit();
         jdbcUtil.close();
      }
      
      return 0;
   }
   
   
   public int removePost(int postId) throws SQLException {

      String query2 = "DELETE FROM post WHERE post_id = ?";
      jdbcUtil.setSqlAndParameters(query2, new Object[] {postId});

      //jdbcUtil.setAutoCommit(false);
      
      String query = "DELETE FROM post WHERE post_id = ?";
      jdbcUtil.setSqlAndParameters(query, new Object[] {postId});
      
      try {
         int result = jdbcUtil.executeUpdate();
         
         if (result != 1) {
            jdbcUtil.rollback();
         } else {
            jdbcUtil.commit();
         }
         
         return result;
      } catch (Exception ex) {
         jdbcUtil.rollback();
         ex.printStackTrace();
      } finally {      
         jdbcUtil.commit();
         jdbcUtil.close();
      }
      
      return 0;
   }

   public int getPostCount(int ref) throws SQLException {
      String query = "select count(*) as count from post where group_id=?";
      jdbcUtil.setSqlAndParameters(query, new Object[] {ref});
      try {
         ResultSet rs = jdbcUtil.executeQuery();   
         int count = 0;
         if(rs.next()) {
            count = rs.getInt("count");
         }
         return count;
         
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         jdbcUtil.close();
      }
      return 0;
   }
   
   public int removeAllPost(int groupId) throws SQLException {
      int result = 0;
      String query = "DELETE FROM post WHERE group_id = ?";
      Object [] param = new Object[] {groupId};
      
      jdbcUtil.setSqlAndParameters(query, param);
      
      try {
         result = jdbcUtil.executeUpdate();
//         if(result != 1) {throw new AppException();}
         jdbcUtil.commit();
      } catch (Exception ex) {
         jdbcUtil.rollback();
         ex.printStackTrace();
      } finally {      
         jdbcUtil.close();
      }
      
      return result;   
   }
   
}
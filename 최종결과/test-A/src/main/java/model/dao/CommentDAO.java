package model.dao;

import model.Comment;

import model.User;
import model.service.AppException;
//import oracle.net.aso.n;

import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.example.repository.mapper.TotalMapper;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import org.apache.ibatis.io.Resources;

import com.example.repository.mapper.TotalMapper;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class CommentDAO {
   private SqlSessionFactory sqlSessionFactory;
   private static CommentDAO dao = new CommentDAO();
   private JDBCUtil jdbcUtil = null; 
   public CommentDAO() {
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
   
   public static CommentDAO getInstance() {
      return dao;
   }
   
   
   public boolean existingComment(int commentId) throws SQLException{
      boolean result = false;
      SqlSession sqlSession = sqlSessionFactory.openSession();
      try {
         Comment c = sqlSession.getMapper(TotalMapper.class).selectCommentByPrimaryKey(commentId);         
         if(c != null) { result = true; }
      } finally {
         sqlSession.close();
      }
      
      return result;
   }
   
   public Comment selectCommentByPrimaryKey(int comment_id) {
      SqlSession sqlSession = sqlSessionFactory.openSession();
      try {
         return sqlSession.getMapper(TotalMapper.class).selectCommentByPrimaryKey(comment_id);         
      } finally {
         sqlSession.close();
      }
   }
   
   
   public int selectCommentCount(int postId) {
      SqlSession sqlSession = sqlSessionFactory.openSession();
      try {
         return sqlSession.getMapper(TotalMapper.class).selectCommentCount(postId);         
      } finally {
         sqlSession.close();
      }
   }
   
   
   public ArrayList<Comment> selectAllComment(int postId){
      SqlSession sqlSession = sqlSessionFactory.openSession();
      ArrayList<Comment> commentList = null;
      try {
         commentList = sqlSession.getMapper(TotalMapper.class).selectAllComment(postId);         
      } finally {
         sqlSession.close();
      }
      
      return commentList;
   } 
   
   
   public int insertComment(Comment comment) {
      SqlSession sqlSession = sqlSessionFactory.openSession();
      try {
         int result = sqlSession.getMapper(TotalMapper.class).insertComment(comment);
         if (result > 0) {
            sqlSession.commit(); 
         } 
         return result;
      } finally {
         sqlSession.close();
      }
   }
   
   public int deleteComment(int comment_id) {
      SqlSession sqlSession = sqlSessionFactory.openSession();
      try {
         int result = sqlSession.getMapper(TotalMapper.class).deleteComment(comment_id);
         if (result > 0) {
            sqlSession.commit();
         } 
         return result;   
      } finally {
         sqlSession.close();
      }
   }
   
   
   public int deleteAllComments(int postId) {
      SqlSession sqlSession = sqlSessionFactory.openSession();
      try {
         int result = sqlSession.getMapper(TotalMapper.class).deleteAllComments(postId);
         if (result > 0) {
            sqlSession.commit();
         } 
         return result;      
      } finally {
         sqlSession.close();
      }
   }
    
   public int deleteAllCommentsByGroupId(int groupId) {
      SqlSession sqlSession = sqlSessionFactory.openSession();
      try {
         int result = sqlSession.getMapper(TotalMapper.class).deleteAllCommentsByGroupId(groupId);
         if (result > 0) {
            sqlSession.commit();
         } 
         return result;
      } finally {
         sqlSession.close();
      }
   }
   
}
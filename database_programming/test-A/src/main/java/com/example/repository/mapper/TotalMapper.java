package com.example.repository.mapper;

import java.util.ArrayList;


import model.Comment;
import model.Group;

public interface TotalMapper {

	Comment selectCommentByPrimaryKey(int comment_id);
	
	ArrayList<Comment> selectAllComment(int postId);
	
	int selectCommentCount(int postId);
	
	int insertComment(Comment comment);
	
	int deleteComment(int comment_id);
	
	int deleteAllComments(int postId);
	
	int deleteAllCommentsByGroupId(int groupId);
	
	ArrayList<Group> selectAllGroup();
	
	Group selectGroup(int groupId);
}
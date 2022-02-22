package model.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import model.Application;
import model.Comment;
import model.Post;
import model.Group;
import model.User;
import model.service.ExistingException;
import model.service.Manager;
import model.service.NotFoundException;
import model.service.PasswordMismatchException;

public class Main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub


		CommentDAO commentDAO = new CommentDAO();
		commentDAO.deleteAllCommentsByGroupId(611);
	
	}
}
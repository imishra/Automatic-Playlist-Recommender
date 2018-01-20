package com.apr.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import com.apr.model.User;

/**
 * This is a Data Accesss Object class which access the database
 * and add data for a new user
 * 
 */
public class SignupDAO {
private static final Logger LOGGER=Logger.getLogger(SignupDAO.class.getName());
	
	/*
	 * This method add the details of a user to the database
	 * 
	 * Argument: User,String
	 * Returns: String
	 */
	public static String signUP(User user,String password) throws ClassNotFoundException, SQLException{
		String result="success";
		
		String addCredentialQuery="insert into APR.credentials "
				+ "values (\""+user.getUsername()+"\",\""+password+"\")";

		String addUserQuery="insert into APR.users "
				+ "values (\""+user.getUsername()+"\",\""+user.getEmail()+"\",\""+user.getFirstName()+"\",\""
							+user.getLastName()+"\",\""+user.getSex()+"\",\""+user.getStreetAddress()+"\",\""
							+user.getCity()+"\",\""+user.getCountry()+"\")";
		
		Connection con = null;
		Statement stmt = null;
		con = MysqlConnection.getConnection();
		LOGGER.debug("Adding new user "+user.getUsername());
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(addUserQuery);
			stmt.executeUpdate(addCredentialQuery);
			
		}catch(Exception e) {
			result="failure";
		}
		finally {
			MysqlConnection.closeConnection(con);
		}
		return result;
	}
}

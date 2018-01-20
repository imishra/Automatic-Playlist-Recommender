package com.apr.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.apr.model.User;

/**
 * This is a Data Accesss Object class which access the database
 * and create the data objects 
 * 
 */
public class LoginDAO {
	private static final Logger LOGGER=Logger.getLogger(LoginDAO.class.getName());
	
	/*
	 * This method validate the users credentials
	 * 
	 * Argument: String,String
	 * Returns: User
	 */
	public static User validateUser(String username,String password) throws ClassNotFoundException, SQLException{
		
		String sqlQuery="select count(*) as count from APR.credentials where user_name=? and password=?";
		Connection con = null;
		PreparedStatement ps = null;
		con = MysqlConnection.getConnection();
		User user=null;
		LOGGER.debug("Authenticating Credentials for "+username);
		try {
			ps = con.prepareStatement(sqlQuery);
			ps.setString(1, username);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			
			rs.next();
			if(rs.getInt("count")==1){
				LOGGER.debug("Login Succesful for "+username);
				user=getUserDetails(username);
			}
			else{
				LOGGER.error("Login Failed for "+username);
			}
			
		}catch(Exception e) {
			
		}
		finally {
			MysqlConnection.closeConnection(con);
			MysqlConnection.closePreparedStatement(ps);
		}
		return user;
	}
	private static User getUserDetails(String username) throws SQLException, ClassNotFoundException{
		String sqlQuery="select * from APR.users where user_name=?";
		Connection con = null;
		PreparedStatement ps = null;
		con = MysqlConnection.getConnection();
		User user=new User();
		LOGGER.debug("Fetching the details for "+username);
		try {
			ps = con.prepareStatement(sqlQuery);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				user.setUsername(username);
				user.setFirstName(rs.getString("first_name"));
				user.setLastName(rs.getString("last_name"));
				user.setEmail(rs.getString("email"));
				user.setSex(rs.getString("sex"));
				user.setStreetAddress(rs.getString(("street_address")));
				user.setCity(rs.getString("city"));
				user.setCountry(rs.getString("country"));
			}
		}
		finally {
			MysqlConnection.closeConnection(con);
			MysqlConnection.closePreparedStatement(ps);
		}
		return user;
	}
}

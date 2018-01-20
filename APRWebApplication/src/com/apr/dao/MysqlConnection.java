package com.apr.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * This is a Connection class for mysql database which access the database and create the
 * data objects
 * 
 */
public class MysqlConnection {
	private static final String USER_NAME = "root";
	private static final String PASSWORD = "secret";
	private static final String URL = "jdbc:mysql://localhost:3306/APR";
	private static final String DRIVER_NAME = "com.mysql.jdbc.Driver";

	/**
	 * Connecting to the database
	 * 
	 * @return
	 * @throws ClassNotFoundException
	 */

	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		Connection con = null;

		try {

			Class.forName(DRIVER_NAME);
			con = DriverManager.getConnection(URL, USER_NAME, PASSWORD);
		} finally {
			// Nothing to do
		}
		return con;
	}

	/**
	 * Closing connection to database
	 * 
	 * @param con
	 */

	public static void closeConnection(Connection con) throws SQLException {
		if (con != null) {
			try {
				con.close();
			} finally {
				// Nothing to do
			}
		}
	}

	/**
	 * Closing prepared statement
	 * 
	 * @param ps
	 */

	public static void closePreparedStatement(PreparedStatement ps) throws SQLException {
		if (ps != null) {
			try {
				ps.close();
			} finally {
				// Nothing
			}
		}
	}
}

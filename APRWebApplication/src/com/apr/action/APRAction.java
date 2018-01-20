package com.apr.action;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

import com.apr.dao.LoginDAO;
import com.apr.dao.RecommendationDAO;
import com.apr.dao.SignupDAO;
import com.apr.model.User;
import com.apr.utility.Utility;
import com.opensymphony.xwork2.ActionSupport;

/**
 * This class represents a the login action class
 * 
 * @author Jeet
 */
public class APRAction extends ActionSupport implements SessionAware{
	private static final long serialVersionUID = 1L;
	private static final Logger logger=Logger.getLogger(APRAction.class.getName());
	private SessionMap<String,Object> sessionMap; 
	
	//number of playlist to show initially
	private static int playlistCount=6;
	//number of songs to show per suggested playlist
	private static int songCountSuggestedPlaylist=5;
	//number of songs to show in searched playlist
	private static int songCountSearchedPlaylist=10;
	/*
	 * This method will be called when the action is invoked
	 * 
	 * Argument: void
	 * Returns: String
	 */
	public String login() throws Exception {
		HttpServletRequest request=ServletActionContext.getRequest();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		//Convert the password to a salted hash-paasword
		password=Utility.createHashPhrase(password);
		
		//Validate the user
		User user=(User)sessionMap.get("user");
		if(user==null)
			user=LoginDAO.validateUser(username, password);
		if (user!=null) {
			sessionMap.put("user", user);
			logger.debug(user.getFirstName()+" "+user.getLastName()+" Signed in.");
			return "success";
		} else {
			request.setAttribute("loginFailed", "login");
			return "login";
		}
	}
	public String logout(){
		User user=(User)sessionMap.get("user");
		if(user!=null)
			logger.debug(user.getUsername()+" signed out");
		sessionMap.invalidate();
		return "success";
	}
	public String signup() throws ClassNotFoundException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		
		//Read the request parameters
		String username=(String)request.getParameter("username");
		String email=(String)request.getParameter("email");
		String firstName=(String)request.getParameter("firstname");
		String lastName=(String)request.getParameter("lastname");
		String sex=(String)request.getParameter("sex");
		String streetAaddress=(String)request.getParameter("address");
		String city=(String)request.getParameter("city");
		String country=(String)request.getParameter("country");
		String password=(String)request.getParameter("password");
		
		//Create the user object
		User user=new User();
		user.setUsername(username);
		user.setEmail(email);
		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setSex(sex);
		user.setStreetAddress(streetAaddress);
		user.setCity(city);
		user.setCountry(country);
		
		//Convert the password to a salted hash-password
		password=Utility.createHashPhrase(password);
		String result=SignupDAO.signUP(user, password);
		request.setAttribute("result", result);
		if("failure".equals(result))
			return "login";
		
		sessionMap.put("user", user);
		return "success";
	}
	public String getInitialPlaylist() throws ClassNotFoundException, SQLException{
		Map<Integer,List<String>> recommendations=null;
		HttpServletRequest request=ServletActionContext.getRequest();
		User user=(User)sessionMap.get("user");
		recommendations=RecommendationDAO.getInitialRecommendation(user,playlistCount,songCountSuggestedPlaylist);
		request.setAttribute("rcom",recommendations);
		return "success";
	}
	public String getCurrentPlaylist(){
		Map<Integer,List<String>> recommendations=null;
		HttpServletRequest request=ServletActionContext.getRequest();
		
		String recommendationType = request.getParameter("rcom");
		String currentSong = request.getParameter("ctrack");
		
		//Invalid request
		if(recommendationType!=null && currentSong!=null) {
			recommendations=RecommendationDAO.getCurrentRecommendation(recommendationType, 
																		currentSong,songCountSearchedPlaylist);
			request.setAttribute("rcom",recommendations);
			if("mbcf".equals(recommendationType))
				request.setAttribute("searched_song",currentSong);
		}
		else
			request.setAttribute("error", "Invalid Request");
		return "success";
	}
	@Override
	public void setSession(Map<String, Object> sessionMap) {
		this.sessionMap = (SessionMap<String,Object>)sessionMap;
	}	
}

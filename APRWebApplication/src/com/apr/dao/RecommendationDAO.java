package com.apr.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.apr.apiclient.RecommendationSeeker;
import com.apr.model.User;

/**
 * This is a Data Accesss Object class which calls the recommendation web service 
 * to get the the playlist recommendation  
 * 
 */
public class RecommendationDAO {
	private static final Logger LOGGER=Logger.getLogger(RecommendationDAO.class.getName());
	
	/*
	 * This method generates the initial recommendation based on user history
	 * 
	 * Argument: User,int,int
	 * Returns: Map<Integer,List<String>>
	 */
	public static Map<Integer,List<String>> getInitialRecommendation(User user,int playlistCount,int songCount) 
											throws ClassNotFoundException, SQLException{
		Map<Integer,List<String>> recommendations=new HashMap<Integer,List<String>>();
		RecommendationSeeker recommendationSeeker=new RecommendationSeeker();
		
		//last playlist is popular songs
		List<String> nMostPlayedSongs=getNMostPlayedSongs(user,playlistCount-1);
		
		//Recommend playlist as per the to n songs
		int songIndex=1;
		for(songIndex=1;songIndex<=nMostPlayedSongs.size();songIndex++) {
			List<String> songs=recommendationSeeker.request("mbcf", nMostPlayedSongs.get(songIndex-1),songCount);
			recommendations.put(songIndex,songs);
		}
		LOGGER.debug("Get the playlists recommendation for"+user.getUsername());
		//Recommend a playlist of most played songs
		recommendations.put(songIndex,recommendationSeeker.request("pb","",songCount));
		return recommendations;
	}
	/*
	 * This method generates the initial recommendation based on the search by the user
	 * 
	 * Argument: String,String
	 * Returns: Map<Integer,List<String>>
	 */
	public  static Map<Integer,List<String>> getCurrentRecommendation(String recommendationType,
																	String currentSong,int songCount){
		Map<Integer,List<String>> recommendations=new HashMap<Integer,List<String>>();
		LOGGER.debug("Get the searched playlist recommendation");
		RecommendationSeeker recommendationSeeker=new RecommendationSeeker();
		recommendations.put(1,recommendationSeeker.request(recommendationType, currentSong,songCount));
		return recommendations;
	}
	
	/*
	 * This method generates the initial recommendation based on the search by the user
	 * 
	 * Argument: User,int
	 * Returns: Map<Integer,List<String>>
	 */
	public static List<String> getNMostPlayedSongs(User user,int N) throws ClassNotFoundException, SQLException{
		List<String> mostPlayedSongs=new ArrayList<String>();
		String sqlQuery="select track_name from APR.user_history where user_name=? "
						+ "order by listen_count desc limit "+N;
		Connection con = null;
		PreparedStatement ps = null;
		con = MysqlConnection.getConnection();
		LOGGER.debug("Get the top "+N+" most played song for "+user.getUsername());
		try {
			ps = con.prepareStatement(sqlQuery);
			ps.setString(1, user.getUsername());
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				mostPlayedSongs.add(rs.getString("track_name"));
			}
			
		}catch(Exception e) {
			LOGGER.error("Database Operation Failed");
		}
		finally {
			MysqlConnection.closeConnection(con);
			MysqlConnection.closePreparedStatement(ps);
		}
		return mostPlayedSongs;
	}
}

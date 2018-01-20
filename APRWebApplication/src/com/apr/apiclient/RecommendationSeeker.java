package com.apr.apiclient;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;

import org.apache.log4j.Logger;
import org.glassfish.jersey.client.ClientConfig;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
/**
 * This is a Web Sevice Client which consumes the recommendation we serveice
 * 
 */
public class RecommendationSeeker {
	private static final Logger logger = Logger.getLogger(RecommendationSeeker.class);
	public static final String URL="http://localhost:5000/playlist";
			
	private ClientConfig config;
	private Client client;
	
	public RecommendationSeeker(){
		config=new ClientConfig();
		client=ClientBuilder.newClient(config);
	}
	
	/*
	 * This method send the request data from the recommendation api
	 * 
	 * Argument: String,String,int
	 * Returns: List<String>
	 */
	public List<String> request(String recommendationType,String currentSong,int songCount) {
		URI uri=UriBuilder.fromUri(URL).build(); 
		WebTarget webTarget = client.target(uri);
		
		//Parameters for request
		String postParam1="[{\"rcom\":\""+recommendationType+"\",\"qs\":\""+currentSong+"\",\"count\":\""+songCount+"\"}]";
		String response="";
		List<String> recommendations=null;
		try {
			response= webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(postParam1), String.class);
			recommendations=this.parseRecommendationResponse(response);
		}
		catch(Exception e) {
			logger.error(e.getMessage());
		}
		
		return recommendations;
	}
	
	/*
	 * This method process the json response string
	 * 
	 * Argument: String
	 * Returns: String
	 */
	public List<String> parseRecommendationResponse(String jsonResponse){
		List<String> recommendations=new ArrayList<String>();
		JSONParser parser = new JSONParser();
		try {
			Object jsonObject = parser.parse(jsonResponse);
			String status=((JSONObject)jsonObject).get("result").toString();
			if("success".equals(status)) {
				jsonObject=((JSONObject)jsonObject).get("playlist");
				JSONArray jsonArray = (JSONArray)jsonObject;
				
				for(int i=0;i<jsonArray.size();i++) {
					String track=jsonArray.get(i).toString();
					recommendations.add(track);
				}
			}
		}catch(ParseException e){
			e.printStackTrace();
		}
		return recommendations;
	}
}

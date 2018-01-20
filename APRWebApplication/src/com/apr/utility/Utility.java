package com.apr.utility;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;

/**
 * This is a helper class which contains some method for 
 * basic computations.
 * @author Jeet
 */
public class Utility {
	private static final String HASH_METHOD="SHA-256";
	private static final Logger logger = Logger.getLogger(Utility.class);
	
	/*
	 * This method creates a hash from the given string
	 * 
	 * Argument: String
	 * Returns: String
	 */
	public static String createHashPhrase(String text) {
		//Add a salted text to the password
		text+="Do You think, u can creack it? Yes? Let me tell u, You are overestimating ur abilities.";
		MessageDigest messageDigest=null;
		try {
			messageDigest = MessageDigest.getInstance(HASH_METHOD);
		} catch (NoSuchAlgorithmException e) {
			logger.error(e.getMessage());
		}
        byte[] messageDigestBytes = messageDigest.digest();

        //convert the byte to hex format method 1
        StringBuffer hash = new StringBuffer();
        for (int i = 0; i < messageDigestBytes.length; i++) {
          hash.append(Integer.toString((messageDigestBytes[i] & 0xff) + 0x100, 16).substring(1));
        }
        return hash.toString();
	}
	/*
	 * This method reads the database configuration from the properties file
	 * 
	 * Argument: String
	 * Returns: Map<String,String>
	 */
	public static Map<String,String> loadDatabaseConfiguration() throws IOException {
		InputStream inputStream=null;
		Map<String,String> databaseConfiguration=new HashMap<String,String>();
		try {
			Properties prop = new Properties();
			String propFileName = "dbconfig.properties";
 
			inputStream = Utility.class.getClassLoader().getResourceAsStream(propFileName);
 
			if (inputStream != null) {
				prop.load(inputStream);
			} else {
				throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
			}
 
			// get the property value and print it out
			@SuppressWarnings("rawtypes")
			Enumeration e = prop.propertyNames();
		    while (e.hasMoreElements()) {
		      String key = (String) e.nextElement();
		      databaseConfiguration.put(key,prop.getProperty(key));
		    }
 
		} catch (Exception e) {
			logger.error(e.getMessage());
		} finally {
			inputStream.close();
		}
		return databaseConfiguration;
	}
}

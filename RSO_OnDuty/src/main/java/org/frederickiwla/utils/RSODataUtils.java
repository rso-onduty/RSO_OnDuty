package org.frederickiwla.utils;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.UnknownHostException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.bson.types.ObjectId;
import org.jboss.crypto.CryptoUtil;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;
import com.mongodb.MongoException;
import com.mongodb.util.JSON;


public class RSODataUtils {

	private static Mongo mongo = null;
	
	private static String mongoHost = "localhost";
	
	private static String onDutyListName = "onDutyList";
	private static String scheduleListName = "scheduleList";
	
	private static final String appUserFilenamePath = "C:/jboss-as-7.1.1.Final/standalone/configuration/";
	private static final String appUserFilename = "application-users.properties";
	private static final String appRolesFilename = "application-roles.properties";
	private static final String realm = "ApplicationRealm";

	public RSODataUtils() {
		super();
	}

	private static String database = "rso";
	
	public String getRSOOnDutyList() throws UnknownHostException {
		DB db = getDB();
		DBCollection onDutyList = db.getCollection(onDutyListName);
				
		DBCursor cursor = onDutyList.find();
		List<DBObject> allRSOsOnDuty = cursor.toArray(); 
			
	    return allRSOsOnDuty.toString();
	}
	
	public String getRSOOnDutyList(Date now) throws UnknownHostException, MongoException {
		DB db = getDB();
		DBCollection onDutyList = db.getCollection(onDutyListName);
		
		BasicDBObject query = new BasicDBObject();

		query.put("offDutyAt", new BasicDBObject("$gt", new Date()));  // e.g. find all where offDutyAt is greater than now

		DBCursor cursor = onDutyList.find(query);
		List<DBObject> allRSOsOnDuty = cursor.toArray(); 
		
	    return allRSOsOnDuty.toString();
		
	}

	public String getRSOScheduleList(Date now) throws UnknownHostException, MongoException {
		DB db = getDB();
		DBCollection scheduleList = db.getCollection(scheduleListName);
		
		BasicDBObject query = new BasicDBObject();
		BasicDBObject sortBy = new BasicDBObject();

		query.put("offDutyAt", new BasicDBObject("$gt", new Date()));  // e.g. find all where offDutyAt is greater than now
		sortBy.put("onDutyAt", 1);
		
		DBCursor cursor = scheduleList.find(query);
		cursor.sort(sortBy);
		List<DBObject> allRSOs = cursor.toArray(); 
		
	    return allRSOs.toString();
	}

	public String addNewRSOOnDuty(DBObject dbObj) throws UnknownHostException {
		DB db = getDB();
		
		DBCollection onDutyList = db.getCollection(onDutyListName);
		
		onDutyList.insert(dbObj);
	    return dbObj.toString();
	}	
	
	
	public DBObject getRSO(String username) throws UnknownHostException, MongoException {
		DB db = getDB();

		DBObject dbObj = new BasicDBObject("username", username);
		DBObject rso = null;
		
		DBCollection rsoList = db.getCollection("rsoList");
		
		rso = rsoList.findOne(dbObj);

		return rso;
		
	}
	
	public DBObject getRSOfromEmail(String email) throws UnknownHostException, MongoException {
		DB db = getDB();
	
		DBObject dbObj = new BasicDBObject("email", email);
		DBObject rso = null;
		
		DBCollection rsoList = db.getCollection("rsoList");
		
		DBCursor cursor = rsoList.find(dbObj);
	
		if (cursor.size() > 0) {
		
			List<DBObject> rsos = cursor.toArray(); 
			rso = rsos.get(0);
		}
			
		return rso;
	}

	public DBObject getOnDutyRSO(String username) throws UnknownHostException, MongoException {
		DB db = getDB();

		DBObject dbObj = new BasicDBObject("username", username);
		DBObject rso = null;
		
		DBCollection rsoList = db.getCollection(onDutyListName);
		
		rso = rsoList.findOne(dbObj);
			
		return rso;
	}

	public String getRSOFullName(String username) throws UnknownHostException, MongoException {
		DBObject rso = getRSO(username);
		return rso.get("firstName")+" "+rso.get("lastName");
	}
	
	public String addRSO(String json) throws UnknownHostException, MongoException {
		
		DB db = getDB();
		
		DBObject dbObj = (DBObject) JSON.parse(json);
		
		DBCollection rsoList = db.getCollection("rsoList");
		
		rsoList.insert(dbObj);
		
	    return dbObj.toString();
		
	}
	
	public void updateRSO(DBObject rso) throws UnknownHostException, MongoException {
		DB db = getDB();
		DBCollection rsoList = db.getCollection("rsoList");
		rsoList.save(rso);
	}

	public String addNewRSO(String username, String firstName, String lastName, String email, String phone, String rsoID) throws UnknownHostException, MongoException {

		DB db = getDB();
		
		DBObject dbObj = (DBObject) new BasicDBObject();
		dbObj.put("username", username);
		dbObj.put("firstName", firstName);
		dbObj.put("lastName", lastName);
		dbObj.put("email", email);
		dbObj.put("phone", phone);
		dbObj.put("rsoID", rsoID);
		dbObj.put("dateRegistered", new Date());
		dbObj.put("dateVetted", null);
		
		DBCollection rsoList = db.getCollection("rsoList");
		
		rsoList.insert(dbObj);
		
	    return dbObj.toString();	
	    
	}
	
	public String getAllRSOs() throws UnknownHostException, MongoException {
		DB db = getDB();
		DBCollection rsoList = db.getCollection("rsoList");
				
		DBCursor cursor = rsoList.find();
		
		List<DBObject> rsos = cursor.toArray(); 
			
	    return rsos.toString();			
		
	}
	
	public String isOnDuty(String username) throws UnknownHostException, MongoException {
		DB db = getDB();
		DBCollection onDutyList = db.getCollection(onDutyListName);
		DBObject query = new BasicDBObject("username", username);
		query.put("offDutyAt", new BasicDBObject("$gt", new Date()));  // e.g. find all where offDutyAt is greater than now
		
		DBCursor cursor = onDutyList.find(query);

		if (cursor.size() > 0)
			return "true";
		else 
			return "false";

	}
	
	public boolean isRSOVetted(String username) throws UnknownHostException, MongoException {
		DBObject rso = getRSO(username);
		
		if (rso == null) return false;
		
		Object vettedDate = rso.get("dateVetted");
		
		if (vettedDate != null) {
			return true;
		} else {
			return false;
		}

	}
	
	public void rsoOffDuty(String username) throws UnknownHostException, MongoException {
		DB db = getDB();
		DBCollection onDutyList = db.getCollection(onDutyListName);
		DBObject dbObj = new BasicDBObject("username", username);
		
		onDutyList.remove(dbObj);
		
	}	
	
	
	public void rsoOnDuty(DBObject rso) throws UnknownHostException, MongoException {
		DB db = getDB();
		DBCollection onDutyList = db.getCollection(onDutyListName);
		onDutyList.save(rso);
	}

	
	public void scheduleRSO(String username, Date date, int duration, String scheduleType) throws UnknownHostException, MongoException {
		DBObject rso = getRSO(username);
		
		ObjectId newId = new ObjectId();
		
		rso.put("_id", newId);
		Calendar onDutyTime = Calendar.getInstance();
		onDutyTime.setTime(date);
		Calendar offDutyTime = Calendar.getInstance();
		offDutyTime.setTime(date);
		offDutyTime.add(Calendar.HOUR, duration);
		
		rso.put("onDutyAt", onDutyTime.getTime());
		rso.put("offDutyAt", offDutyTime.getTime());
		rso.put("type", scheduleType);
	
		DB db = getDB();
		DBCollection scheduleList = db.getCollection(scheduleListName);
		
		scheduleList.insert(rso);
			
		
	}

	public void unscheduleRSO(String scheduleId) throws UnknownHostException, MongoException {
		ObjectId id = new ObjectId(scheduleId);
		DBObject obj = new BasicDBObject();
		obj.put("_id", id);
		DB db = getDB();
		DBCollection scheduleList = db.getCollection(scheduleListName);

		scheduleList.remove(obj);
	}

	public boolean isUsernameAvailable(String username) throws UnknownHostException, MongoException {	
		Properties properties = getApplicationUsersProperties();
		
		Set<Object> usernames = properties.keySet();
		
		boolean isUsernameAvaialable = !usernames.contains(username);
		
		return isUsernameAvaialable;
	}
	
	public String changePassword(String username, String password) {
		String hashedPassword = hashPassword(username, password);
		
		Properties users = getApplicationUsersProperties();
		if (users.containsKey(username)) {
			users.put(username, hashedPassword);
			writeApplicationUsersProperties(users);
			return hashedPassword;
		}
		
		return null;
		
	}
	
	public void addUser(String username, String password, boolean isAdmin) {
		String hashedPassword = hashPassword(username, password);
		
		Properties users = getApplicationUsersProperties();
		if (!users.containsKey(username)) {
			users.put(username, hashedPassword);
			writeApplicationUsersProperties(users);
		}
		
		Properties roles = getApplicationRolesProperties();
		if (!roles.containsKey(username)) {
			String role = "user";
			if (isAdmin) role = role+",admin";
			roles.put(username, role);
			writeApplicationRolesProperties(roles);
		}
		
	}
	
	public String hashPassword(String username, String password) {
		
		String clearTextPassword=username +":"+realm+":"+password;
		String hashedPassword=CryptoUtil.createPasswordHash("MD5", "hex", null, null, clearTextPassword);	
		
		return hashedPassword;
		
	}
	
	
	public void sendEmail(String emailAddress, String subject, String messageText) {
		
		
		final String username = "jmsimpson68@gmail.com";
		final String password = "1luvg0lf";
 
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
 
		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });
 
		try {
 
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("rso-onduty@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(emailAddress));
			message.setSubject(subject);
			message.setText(messageText);
 
			Transport.send(message);
 
			System.out.println("Done");
 
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
	
	
	// UTILITIES for the utilities 
	
	public boolean checkPassword(String username, String passwordToCheck) {
		Properties properties = getApplicationUsersProperties();
		
		Set<Object> usernames = properties.keySet();
		if (!usernames.contains(username))
			return false;
		
		boolean result = false;
		
		String existingPassword = properties.getProperty(username);
		String hashedPasswordToCheck = hashPassword(username, passwordToCheck);
		
		result = hashedPasswordToCheck.equals(existingPassword);
		
		return result;
		
	}
	
	
	private static Mongo getMongo() throws UnknownHostException, MongoException {
		if (mongo == null) {
			mongo = new Mongo( mongoHost );
		}
		return mongo;
	}
	
	private DB getDB() throws UnknownHostException, MongoException {
		DB db;
		Mongo m = getMongo();
				
		db = m.getDB(database);
		return db;
	}


	private Properties getApplicationUsersProperties() {
		Properties properties = new Properties();
		try {
		    properties.load(new FileInputStream(appUserFilenamePath + appUserFilename));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return properties;

		
	}

	synchronized private void writeApplicationUsersProperties(Properties properties) {
		// Write properties file.
		try {
		    properties.store(new FileOutputStream(appUserFilenamePath + appUserFilename), null);
		} catch (IOException e) {
			e.printStackTrace();
		}		
				
	}
	
	private Properties getApplicationRolesProperties() {
		Properties properties = new Properties();
		try {
		    properties.load(new FileInputStream(appUserFilenamePath + appRolesFilename));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return properties;

		
	}

	synchronized private void writeApplicationRolesProperties(Properties properties) {
		// Write properties file.
		try {
		    properties.store(new FileOutputStream(appUserFilenamePath + appRolesFilename), null);
		} catch (IOException e) {
			e.printStackTrace();
		}		
				
	}

	
}

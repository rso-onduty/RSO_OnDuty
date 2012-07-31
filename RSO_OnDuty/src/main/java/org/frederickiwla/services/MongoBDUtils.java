package org.frederickiwla.services;

import java.net.UnknownHostException;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import com.mongodb.Mongo;

@Path("/api/OnDutyList")
public class MongoBDUtils {

	@GET()
	@Path("/dbNames")
	@Produces("text/plain")
	public String getDbNames() throws UnknownHostException {
		Mongo m = new Mongo( "localhost" );
		List<String> dbNames = m.getDatabaseNames();
		
		StringBuffer buf = new StringBuffer();
		
		buf.append("DB names: ");
		for (String dbName: dbNames) {
			buf.append(dbName +", ");
		}
		
		
	    return "Hello World - from the Maven Resteasy REST API! - " + buf.toString();
	}
	
	
}

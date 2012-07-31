package org.frederickiwla.services;

import java.net.UnknownHostException;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.frederickiwla.utils.RSODataUtils;

import com.mongodb.DBObject;
import com.mongodb.MongoException;

@Path("/api/RSOList")
public class RSOList {

	@GET()
	@Produces("application/json")
	public String getDutyList() throws UnknownHostException {
		return getRSOList();
	}
	
	
	@GET()
	@Path("/rso/{username}")
	@Produces("application/json")
	public String getRSO( @PathParam("username") String username) throws UnknownHostException {
		RSODataUtils utils = new RSODataUtils();
		DBObject rso = utils.getRSO(username);
		return rso.toString();
	}
	

	@POST()
	@Path("/rso")
	//@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces("text/plain")
	public String postRSOOnDuty(String jsonString) throws UnknownHostException {
		RSODataUtils utils = new RSODataUtils();		
		return utils.addRSO(jsonString);
	}
	
	@GET()
	@Path("/rso/isUsernameAvailable/{username}")
	public Response isUsernameAvailable(@PathParam("username") String username) throws UnknownHostException, MongoException {
		RSODataUtils utils = new RSODataUtils();
		boolean isUsernameAvailable = utils.isUsernameAvailable(username);
		
		return Response.status(Response.Status.OK).entity(Boolean.toString(isUsernameAvailable)).build();
	}
	
	
	private String getRSOList() throws UnknownHostException, MongoException {
		RSODataUtils utils = new RSODataUtils();
	    return utils.getAllRSOs();		
	}
	
}

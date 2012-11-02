package org.frederickiwla.services;

import java.util.Set;
import java.util.HashSet;
import javax.ws.rs.core.Application;


public class RSOOnDutyRESTApplication extends Application {

	private Set<Object> singletons = new HashSet<Object>();
	private Set<Class<?>> empty = new HashSet<Class<?>>();
	public RSOOnDutyRESTApplication(){
	     singletons.add(new OnDutyList());
	     singletons.add(new RSOList());
	}
	@Override
	public Set<Class<?>> getClasses() {
	     return empty;
	}
	@Override
	public Set<Object> getSingletons() {
	     return singletons;
	}
}

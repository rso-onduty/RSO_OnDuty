package org.frederickiwla.utils;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RSORegistration
 */
@WebServlet("/RSORegistration")
public class RSORegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RSORegistration() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RSODataUtils utils = new RSODataUtils();
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String firstName = request.getParameter("firstname");
		String lastName = request.getParameter("lastname");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String rsoID = request.getParameter("rsoid");
		
		StringBuffer buf = new StringBuffer();
		buf.append(firstName+",\n\n\tWelcome to RSO OnDuty.  We have recieved your registration request and we will validate your RSO ID with the NRA as soon as possible.\n");
		buf.append("The information you submitted is as follows:\n\n");
		buf.append("\tUsername = "+username+"\n")
			.append("\tFirst name = "+firstName+"\n")
			.append("\tLast name = "+lastName+"\n")
			.append("\tEmail = "+email+" (which is pretty obvious if you got this email)\n")
			.append("\tPhone = "+phone+"\n")
			.append("\tRSO ID = "+rsoID+"\n\n");
		
		
		utils.addUser(username, password, false);
		utils.addNewRSO(username, firstName, lastName, email, phone, rsoID);
		
		utils.sendEmail(email, "Registration submitted for RSO OnDuty!", buf.toString());
		
		
		response.sendRedirect(response.encodeURL(request.getContextPath()+"/registration-result.jsp?username="+username));
	
	}

}

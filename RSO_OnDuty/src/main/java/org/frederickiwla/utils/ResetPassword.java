package org.frederickiwla.utils;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mongodb.DBObject;

/**
 * Servlet implementation class ResetPassword
 */
@WebServlet("/ResetPassword")
public class ResetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResetPassword() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RSODataUtils utils = new RSODataUtils();
		
		String email = request.getParameter("email");

		DBObject rso = utils.getRSOfromEmail(email);
		
		String username = (String) rso.get("username");
		
		String tempRandomPassword = org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric(6);
		
		StringBuffer buf = new StringBuffer();
		buf.append(rso.get("firstName")+",\n\n\tThank you for using RSO OnDuty.  You have requested to update the password for username "+username+".\n");
		buf.append("RSO OnDuty has generated a new temporary password for you:\n\n");
		buf.append("\tUsername = "+username+"\n")
			.append("\tPassword = "+tempRandomPassword+"\n");

		utils.changePassword(username, tempRandomPassword);
		
		utils.sendEmail(email, "Account infomation changed for RSO OnDuty!", buf.toString());
		
		String updateHeader = "You have reset your RSO Account password";
		StringBuffer updateMsgBuf = new StringBuffer();
		updateMsgBuf
			.append("<p>You have reset the password for the account associated with "+email+".<br/>")
			.append("You should receive an email with a temporary password.<br/>")
			.append("You should log into RSO OnDuty with the temporary password and change your password.<br/>")
			.append(" </p> <p><b>Thank you for using RSO On Duty.</b></p>");
		
		
		response.sendRedirect(response.encodeURL(request.getContextPath()+"/rso/update-account-result.jsp?username="+username+"&updateHeader="+updateHeader+"&updateMessage="+updateMsgBuf.toString()));
	}
}

package org.frederickiwla.utils;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mongodb.DBObject;
import com.mongodb.MongoException;

/**
 * Servlet implementation class UpdateAccount
 */
@WebServlet("/UpdateAccount")
public class UpdateAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateAccount() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RSODataUtils utils = new RSODataUtils();
		
		String username = request.getParameter("username");
		String firstName = request.getParameter("firstname");
		String lastName = request.getParameter("lastname");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");

		try {
			DBObject rso = utils.getRSO(username);
			
			StringBuffer buf = new StringBuffer();
			buf.append(firstName+",\n\n\tThank you for using RSO OnDuty.  We have recieved your account information update.\n");
			buf.append("The information you updated is as follows:\n\n");
			buf.append("\tUsername = "+username+"\n")
				.append("\tFirst name = "+firstName+"\n")
				.append("\tLast name = "+lastName+"\n")
				.append("\tEmail = "+email+" (which is pretty obvious if you got this email)\n")
				.append("\tPhone = "+phone+"\n");
			
			
			rso.put("firstName", firstName);
			rso.put("lastName", lastName);
			rso.put("email", email);
			rso.put("phone", phone);
			
			utils.updateRSO(rso);
			
			
			utils.sendEmail(email, "Account infomation changed for RSO OnDuty!", buf.toString());
			
			String updateHeader = "You have successfully updated your RSO Account";
			StringBuffer updateMsgBuf = new StringBuffer();
			updateMsgBuf
				.append("<p>You have account information for username "+username+".<br/>")
				.append("You should receive an email to the email you specified in your accounts settings<br/>")
				.append("confirming the changes you made to your account information.<br/>")
				.append(" </p> <p><b>Thank you for using RSO On Duty.</b></p>");
			
			
			response.sendRedirect(response.encodeURL(request.getContextPath()+"/rso/update-account-result.jsp?username="+username+"&updateHeader="+updateHeader+"&updateMessage="+updateMsgBuf.toString()));
		} catch (MongoException e) {
			String updateHeader = "An error occurred while updating your RSO Account";
			StringBuffer updateMsgBuf = new StringBuffer();
			updateMsgBuf
				.append("<p>An error occurred while attempting to update account information for username "+username+".<br/>")
				.append("You should receive an email to the email you specified in your accounts settings<br/>")
				.append("confirming the changes you made to your account information.<br/>")
				.append(" </p> <p><b>Thank you for using RSO On Duty.</b></p>");
			
			response.sendRedirect(response.encodeURL(request.getContextPath()+"/rso/update-account-result.jsp?username="+username+"&updateHeader="+updateHeader+"&updateMessage="+updateMsgBuf.toString()));
			e.printStackTrace();
		}
	}

}

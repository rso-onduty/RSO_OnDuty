<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">


<%@page import="org.frederickiwla.utils.RSODataUtils"%>
<%@page import="com.mongodb.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Frederick IWLA RSO OnDuty</title>
	<link href="http://fonts.googleapis.com/css?family=Abel"
		rel="stylesheet" type="text/css" />
	<link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="<%= request.getContextPath() %>/css/ui-lightness/jquery-ui-1.8.21.custom.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.8.21.custom.min.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/onDutyList.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/livevalidation_standalone.js"></script>
	
	
	<script type="text/javascript">
		var requestURL = "<%= request.getContextPath() %>";
	</script>
	<style type="text/css">
		.loginoptions {padding:0em .7em;margin-top:20px}
		.loginoptions .basic{width:auto;margin:0}
		.loginoptions fieldset label{width:9.5em;padding-right:.5em}
		.loginoptions .inpu,.loginoptions .inpp{width:55%;min-width:8em}
		.loginoptions .inpe{width:80%;min-width:8em}
		.loginoptions fieldset{background:none;border:0;padding:0;margin:0;overflow:show}
		.loginoptions fieldset fieldset{display:block;width:auto}
		.loginoptions .submit input{margin-bottom:1em;float:none;margin-left:130px}
		#loginbox {width:18em;background-color:#def;border:1px solid #7AC;margin:0;padding:.7em}
		#loginbox .legend{margin-bottom:1em;font-size:120%}
		#loginbox label{width:5.4em;text-align:left}
		#loginbox input,.tooltip dl{width:10em}
		#loginbox .submit input{width:auto;margin-left:80px}
	</style>
</head>

<body>
	<div id="wrapper">
		<div id="wrapper2">
			<jsp:include page="header.jsp">
			    <jsp:param name="currentPage" value="RSO Registration" />
			</jsp:include>
			
			<div id="everything_content">
				<div class="secondaryNav">
					<div id="sideNav">
						<ul>
							<li class="nav-title"><a href="#">RSO Account</a></li>
							<li class="nav-first"><a href="rso_registration.jsp">Create Account</a></li>
							<li class="nav-first"><a href="#">Forgot Password?</a></li>
						</ul>
					</div>
				</div>
				<%
					RSODataUtils utils = new RSODataUtils();						
				%>
				<div id="sidenav-content" class="main-content">
						<h1>Reset your RSO OnDuty password</h1>
						<p>Enter the email associated with your RSO OnDuty account.<br/>
						RSO OnDuty will generate a new password and email it to you.<br/>
						Once you have logged in, you can change the password.
						</p>
						<p><b>All fields are required.</b></p>
					<div class="loginoptions">
					<form id="resetPassword" action="ResetPassword" class="basic" method="post">
						<fieldset style="margin: 5px 0px 15px 0px; border-bottom: gray solid 1px;">
							<label for="resetPassword_email" class="classic">Email</label>
							<fieldset>
								<input class="inpp" id="resetPassword_email" name="email"/>
							</fieldset>
							<label for="resetPassword_emailcf" class="classic"><span style="letter-spacing:-.03em">Confirm&nbsp;email</span></label>
							<fieldset>
								<input class="inpp" id="resetPassword_emailcf" name="emailcf"/>
							</fieldset>
							<script type="text/javascript">
								var resetPassword_email = new LiveValidation('resetPassword_email', { 'validMessage' : 'Valid email address!' } );
								resetPassword_email.add( Validate.Email );
								resetPassword_email.add( Validate.Presence );
					            var resetPassword_emailcf = new LiveValidation('resetPassword_emailcf', { validMessage: 'Email addresses match!'});
					            resetPassword_emailcf.add(Validate.Confirmation, { match: 'resetPassword_email', failureMessage: "Your email addresses don't match!" });
					            resetPassword_emailcf.add( Validate.Presence );
				 		 	</script>
						</fieldset>
						<fieldset style="margin-top:15px" class="submit">
							<input type="submit" name="submit" id="resetPassword_submit" value="Reset Password"/>
						</fieldset>
					</form>
					
					</div>
				</div>

			</div>

		</div>
	</div>
	<jsp:include page="footer.jsp" /></body>
</html>

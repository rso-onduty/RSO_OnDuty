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
	<link href="../css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="../css/ui-lightness/jquery-ui-1.8.21.custom.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="../js/jquery-ui-1.8.21.custom.min.js"></script>
	<script type="text/javascript" src="../js/onDutyList.js"></script>
	<script type="text/javascript" src="../js/livevalidation_standalone.js"></script>
	
	
	<script type="text/javascript">
		var requestURL = "<%= request.getContextPath() %>";

		$(
			$('#createAccount_submit').button()
		);
	</script>

</head>

<body>
	<div id="wrapper">
		<div id="wrapper2">
			<jsp:include page="../header.jsp">
			    <jsp:param name="currentPage" value="Account Settings" />
			</jsp:include>
			
			<div id="everything_content">
				<div class="secondaryNav">
					<div id="sideNav">
						<ul>
							<li class="nav-title"><a href="#">RSO Account</a></li>
							<li class="nav-first"><a href="#">Account Settings</a></li>
							<li class="nav-first"><a href="change_password.jsp">Change Password</a></li>
						</ul>
					</div>
				</div>
				<%
					RSODataUtils utils = new RSODataUtils();
					String username = request.getRemoteUser();
					DBObject rso = utils.getRSO(username);
						
				%>
				<div id="sidenav-content" class="main-content">
						<h1>Update your RSO Profile information</h1>
						<p>You can update any RSO account information by making the changes below.<br/>
						You cannot change your RSO number at this time.  If you have an issue and need<br/>
						to change your RSO ID number, please send and email to the <a href="mailto:rso-onduty@gmail.com?subject=RSO ID Update">site administrator</a>.<br/>
						An email will be sent to you as a confirmation of your changed information.<br/>
						If you do not get and email, it's likely you have entered an invalid email.
						</p>
						<p><b>Only update the fields that you want changed.</b></p>
					<div class="loginoptions">
					<form id="createAccount" action="<%= request.getContextPath() %>/UpdateAccount" class="basic" method="post">
						<fieldset style="margin: 5px 0px 15px 0px; border-bottom: gray solid 1px;">
							<input type="hidden" id="createAccount_username" name="username" value="<%= rso.get("username") %>"/>
							<label for="createAccount_firstname" class="classic">First name</label>
							<fieldset>
								<input class="inpp" id="createAccount_firstname" name="firstname" value="<%= rso.get("firstName") %>"/>
							</fieldset>
							<label for="createAccount_lastname" class="classic">Last name</label>
							<fieldset>
								<input class="inpp" id="createAccount_lastname" name="lastname"  value="<%= rso.get("lastName") %>"/>
							</fieldset>
							<label for="createAccount_email" class="classic">Email</label>
							<fieldset>
								<input class="inpp" id="createAccount_email" name="email" value="<%= rso.get("email") %>"/>
							</fieldset>
							<label for="createAccount_phone" class="classic">Phone</label>
							<fieldset>
								<input class="inpp" id="createAccount_phone" name="phone"  value="<%= rso.get("phone") %>"/>
							</fieldset>
							<script type="text/javascript">
								var createAccount_firstname = new LiveValidation('createAccount_firstname', { 'validMessage' : 'OK' } );
								createAccount_firstname.add( Validate.Presence );
								var createAccount_lastname = new LiveValidation('createAccount_lastname', { 'validMessage' : 'OK' } );
								createAccount_lastname.add( Validate.Presence );
								var createAccount_phone = new LiveValidation('createAccount_phone', { 'validMessage' : 'OK' } );
								createAccount_phone.add( Validate.Presence );
								var createAccount_email = new LiveValidation('createAccount_email', { 'validMessage' : 'Valid email address!' } );
								createAccount_email.add( Validate.Email );
								createAccount_email.add( Validate.Presence );
		         		 	</script>
						</fieldset>
						<fieldset style="margin-top:15px" class="submit">
							<input type="submit" name="submit" id="createAccount_submit" value="Update Account"/>
						</fieldset>
					</form>
					<script type="text/javascript">
							$('#createAccount_submit').button();
					</script>
					
					</div>
				</div>

			</div>

		</div>
	</div>
	<jsp:include page="../footer.jsp" /></body>
</html>

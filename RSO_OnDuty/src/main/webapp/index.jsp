<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Frederick IWLA RSO OnDuty</title>
	<link href="http://fonts.googleapis.com/css?family=Abel"
		rel="stylesheet" type="text/css" />
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/ui-lightness/jquery-ui-1.8.21.custom.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui-1.8.21.custom.min.js"></script>
	<script type="text/javascript" src="js/onDutyList.js"></script>
	<%@ page import="org.frederickiwla.utils.*" %>
	<%
		RSODataUtils utils = new RSODataUtils();		
	
		String isOnDuty = utils.isOnDuty(request.getRemoteUser());
		// This is a comment
	%>
	
	<script type="text/javascript">
		var username = "<%= request.getRemoteUser() %>";
		var requestURL = "<%= request.getContextPath() %>";
		var titleText ="Currently On Duty: ";
		setInterval(function() { loadOnDutyDiv(titleText); },60000);
		setInterval(function() { loadScheduleDiv(username); },300000);
		var isOnDuty = "<%= isOnDuty%>";
	
	
		$(function() {
				$("#loginoutButton").button();
	
				createOnDutyButton();
				createExtendDutyButton();
	
				loadOnDutyDiv(titleText);
				loadScheduleDiv(username);
	
		}
	
		);
		
	</script>
</head>

<body>
	<div id="wrapper">
		<div id="wrapper2">
			<jsp:include page="header.jsp">
			    <jsp:param name="currentPage" value="Homepage" />
			</jsp:include>
			<div id="rso-login-bar">
				<%
					if (request.getAuthType() == null) {
				%>
				<form method="post" action="LoginServlet">
					<div id="usename-prompt" style="float: left; padding-right: 30px;">
						<label style="display: block; float: left; padding-top: 12px;" for="username_input">USERNAME:</label><input
							style="margin: 10px 0px 5px 10px;" id="username_input" type="text" id="username" name="j_username"
							size="25" />
					</div>
					<div id="password-prompt" style="float: left;">
						<label style="display: inline; float: left; padding-top: 12px;" for="password_input">PASSWORD:</label><input
							style="margin: 10px 30px 5px 10px;" id="password_input" type="password" id="password"
							name="j_password" size="25" />
					</div>
					<div id="loginout-button" style="float: left;">
						<input type="hidden" name="function" value="login" /><input 
							id="loginoutButton" type="submit" name="submit" value="Login" />
					</div>
				</form>
								
				<%
					} else {
						String fullName = utils.getRSOFullName(request.getRemoteUser());
						boolean isVetted = utils.isRSOVetted(request.getRemoteUser());
						if (isVetted) {

				%>
				<div id="username">
					<div style="float: left;" >
						<h2 id="fullUserName" style="font-size: 1.6em;padding: 5px 50px 10px 10px;" >
							Welcome, <%=fullName%></h2>
					</div>
					<div style="float: left">
						<button id="onDutyButton"></button>
					</div>
					<div style="float: left">
						<button id="extendDutyButton" class="invisible"></button>
					</div>
					<div style="float: left">
						<label for="hours" style="margin: 20px 5px 10px 10px;"> for how many hours?</label>
						<select id="hours" style="margin: 10px 1px 10px 1px;">
						  <option>1</option>
						  <option>2</option>
						  <option>3</option>
						  <option>4</option>
						  <option>5</option>
						  <option>6</option>
						  <option>7</option>
						  <option>8</option>
						  <option>9</option>
						  <option>10</option>
						  <option>11</option>
						  <option>12</option>
						</select>
					</div>
					<div style="float: right;">
						<form method="post" action="LoginServlet">
							<div>
								<input type="hidden" name="function" value="logout" />
								<input id="loginoutButton" type="submit" name="submit" value="Logout" />
							</div>
						</form>
					</div>
				</div>

				<%
						} else {
				%>
				<div id="username">
					<div style="float: left;" >
						<h2 id="fullUserName" style="font-size: 1.6em;padding: 5px 50px 10px 10px;" >
							Welcome, <%=fullName%></h2>
					</div>
					<div style="float: left">
						<p>You have not yet been vetted as an RSO though the NRA. As soon as you are vetted you can go on duty.</p>
					</div>
					<div style="float: right;">
						<form method="post" action="LoginServlet">
							<div>
								<input type="hidden" name="function" value="logout" />
								<input id="loginoutButton" type="submit" name="submit" value="Logout" />
							</div>
						</form>
					</div>
				</div>
				<%			
						}
				%>
				<%
					}
				%>
			</div>
			
			<%
				if (request.getAuthType() == null) {
			%>
		
			<div id="rso-login-bar" style="border-top-style: solid; border-top-color: gray; border-top-width: 1px">
					<p style="padding-left: 10px; line-height: 170%">
						<a href="rso_registration.jsp"><b>CERTIFIED RSO:</b></a>   If you are a certified RSO and do not have a username and password, <a href="rso_registration.jsp">register here.</a><br/>
						<a href="reset_password.jsp"><b>FORGOT PASSWORD:</b></a>   If you have forgotten your password, <a href="reset_password.jsp">click here.</a>
					</p>
			</div>
			<%
				}
			
				if (request.isUserInRole("admin")) {
			%>
		
			<div id="rso-login-bar" style="height: 50px; border-top-style: solid; border-top-color: gray; border-top-width: 1px">
					<p style="padding-left: 25px;">You are an administrator.  Please <a href="admin/rso_registration_manager.jsp">click here</a> to complete user registration</p>
			</div>
			
			<%
				}
			%>

			
			<div id="banner-wrapper">
				<div id="on-duty-container">
					<div id="currently-on-duty" class="duty-container" style="float: left;">
						<div>
							<h3 id="onDutyListCount" style="text-align: center;">Currently On Duty: 4</h3>
						</div>
						<div id="onDutyListContainer" style="height: 90%; overflow: overlay; ">
	
						</div>
					</div>
					<div id="on-duty-schedule" class="duty-container"
						style="float: right">
						<div>
							<h3 style="text-align: center;">Duty Schedule</h3>
						</div>
						<div id="scheduleListContainer" style="height: 90%; overflow: auto; "></div>
					</div>
				</div>

			</div>

		<div id="page">
				<div id="content">
					<div class="post">
						<h2 class="title">
							<a href="#">Welcome to RSO OnDuty </a>
						</h2>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
							<p>
								Welcome to RSO OnDuty.  This site was built to help those who are are not Range Safety Officers but
								but have a hard time finding out when one is on duty.  Sometimes you also want to be sure that you
								are simply not alone at the range.  RSO OnDuty is here to help communicate when a RSO is at the range
								so you can participate on the range and get full measure from your IWLA membership.
							</p>
							<p>
								You must be a NRA certified RSO in order to get an account on this site.  However, anyone can see the site
								and see who is on duty at the range and who has scheduled themselves in the future.
								If you would like to become a NRA certified RSO, <a href="http://frederickiwla.org/Range_Safety_Officer.html">please click here</a>
								to go to the Range Safely Office Training class page on the Frederick IWLA site. <br />
							</p>
						</div>
					</div>
				</div>
				<!-- end #content -->
				<div id="sidebar">
					<ul>
						<li>
							<h2>RSO Articles</h2>
							<ul>
								<li><a href="http://frederickiwla.org/Regulations.html">Range Rules</a></li>
								<li><a href="http://frederickiwla.org/Range_Safety_Officer.html">Range Safely Officer Training</a></li>
								<li><a href="nra.org">National Rifle Association</a></li>
								<li><a href="#">RSO OnDuty iPhone App</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<!-- end #sidebar -->
				<div style="clear: both;">&nbsp;</div>
			</div>
			<!-- end #page -->
		</div>
	</div>
	<jsp:include page="footer-links.jsp" />
	<jsp:include page="footer.jsp" />
</body>
</html>

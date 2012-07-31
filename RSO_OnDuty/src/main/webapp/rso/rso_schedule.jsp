
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">


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
<script type="text/javascript" src="../js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="../js/jquery-ui-1.8.21.custom.min.js"></script>


</head>


<body>


	<div id="wrapper">
		<div id="wrapper2">
			<div id="header" class="container">
				<div id="IWLA logo" style="float: left;">
					<img height="80" src="../images/iwla.png"></img>
				</div>
				<div id="logo">
					<h1>
						<a href="#">RSO OnDuty </a>
					</h1>
				</div>
				<div id="menu">
					<ul>
						<li><a href="../index.jsp">Homepage</a></li>
						<li class="current_page_item"><a href="#">RSO Scheduling</a></li>
						<li><a href="registration/rso_registration.jsp">RSO Registration</a></li>
						<li><a href="http://frederickiwla.org">Frederick IWLA</a></li>
					</ul>
				</div>
			</div>
			<!-- end #header -->
			<div id="rso-login-bar">
				<div>
				<%
					String authType = request.getAuthType();
					String remoteUser = request.getRemoteUser();
				
				%>
				<p id="greeting">Hello </p>
				<p>AuthType = <%= authType %></p>
				
				</div>
				<script type="text/javascript">
					var username = "<%= request.getRemoteUser() %>";
					var requestURL = "<%= request.getRequestURL() %>";
					var titleText ="Hello ";
				
					$(
					    $.getJSON(requestURL+"api/RSOList/rso/"+username, function(onDutyList){
				
					         $("#greeting").html(titleText + this.firstName+" "+this.lastname);
					    }
	
					);
				</script>			
				<%
					if (request.isUserInRole("admin")) {
				%>
			</div>
			<div id="rso-login-bar" style="height: 50px;">
					<p style="padding-left: 50px;">You are an administrator.  Please <a href="registration/rso_registration_completion.jsp">click here</a> to complete user registration</p>
			</div>
			
			<%
				}
			%>
			<div id="banner-wrapper">
				<div id="on-duty-container">
					<div id="currently-on-duty" class="duty-container" style="">
						<form method="post" action="LoginServlet">
							<table width="75%">
								<tr>
									<td>
										<label for="date_input">Date:</label><input
											id="date_input" type="text" id="date" name="date"
											size="25" />
									</td>
								</tr>
								<tr>
									<td>
										<label for="startTime_input">Start time:</label><input
											id="startTime_input" type="text" id="startTime" name="startTime"
											size="25" />
									</td>
								</tr>
								<tr>
									<td>
										<label for="stopTime_input">Date:</label><input
											id="stopTime_input" type="text" id="stopTime" name="stopTime"
											size="25" />
									</td>
								</tr>
								<tr>
									<td>
										<input type="submit" name="submit" value="Submit" />
									</td>
								</tr>
							
							</table>
						</form>
					</div>
				</div>

			</div>

		</div>
	</div>
	<div id="footer">
		<p>
			Copyright (c) 2012 frederickiwla.org. All rights reserved. Design by
			<a href="http://www.freecsstemplates.org">FCT</a>.
		</p>
	</div>
	<!-- end #footer -->
</body>
</html>

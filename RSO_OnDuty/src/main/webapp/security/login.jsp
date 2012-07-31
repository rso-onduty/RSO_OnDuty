<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Frederick IWLA RSO OnDuty</title>
<link href="http://fonts.googleapis.com/css?family=Abel" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
<div id="wrapper">
	<div id="wrapper2">
		<div id="header" class="container">
			<div id="IWLA logo" style="float: left;">
				<img height="80" src="../images/iwla.png"></img>
			</div>
			<div id="logo" style="width: 500px">
				<h1><a href="#">RSO OnDuty LOGIN PAGE</a></h1>
			</div>
		</div>
		<!-- end #header -->
		<div id="rso-login-bar">
			<form method="post" action="j_security_check">
	        	<div id="login" style="float: left;">LOGIN:</div>
				<div id="usename-prompt" style="float: left;"><label for="username">USERNAME:</label><input id="username" type="text" id="username" name="j_username" size="25"/></div>
				<div id="password-prompt" style="float: left;"><label for="username">PASSWORD:</label><input id="username" type="password" id="password" name="j_password" size="15"/></div>
				<div id="password-prompt" style="float: right;"><input type="submit" name="submit" value="Login"/></div>
			</form>     				
		</div>
		</div>
		</div>
<div id="footer">
	<p>Copyright (c) 2012 Sitename.com. All rights reserved. Design by <a href="http://www.freecsstemplates.org">FCT</a>.</p>
</div>
</body>
</html>
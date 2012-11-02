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
			<div id="logo" style="width: 300px">
				<h1><a href="../index.jsp">RSO OnDuty</a></h1>
			</div>
			<div id="errorText" style="float: left; width: 500px; background-color: gray; color: #FFFFFF;">
				<h1>LOGIN ERROR PAGE</h1>
			</div>
		</div>
		<!-- end #header -->
		<div id="rso-login-bar" style="height: 150px">
			<h1>The username or password you entered was incorrect.</h1>    				
			<h3>Click <a href="../index.jsp">here</a> to go back to login page.</h3>    				
		</div>
		</div>
		</div>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>
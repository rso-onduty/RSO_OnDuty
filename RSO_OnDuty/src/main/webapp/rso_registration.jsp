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
	<script type="text/javascript" src="js/livevalidation_standalone.js"></script>
	
	
	<script type="text/javascript">
		var requestURL = "<%= request.getContextPath() %>";
		
		function isUsernameAvailable(username) { 

			var isAvailable = false;

			if (username.length == 0) return false;
			$("#username-good-spinner").toggleClass("invisible");
			var url = requestURL+'/api/RSOList/rso/isUsernameAvailable/'+username;
			$.ajax({
				'url' : url,
				'success' : function(data) { 
					isAvailable = (data === 'true');
					$("#username-good-spinner").toggleClass("invisible");
				 },
				'error' : function(data) {
					$("#username-good-spinner").toggleClass("invisible");
				 },
				 'async' : false
				}
			);

			return isAvailable;
			
		};

		$(
			$("#createAccount_submit").button()
		);
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
			    <jsp:param name="currentPage" value="Account Settings" />
			</jsp:include>
			
			<div id="everything_content">
				<div class="secondaryNav">
					<div id="sideNav">
						<ul>
							<li class="nav-title"><a href="#">RSO Account</a></li>
							<li class="nav-first"><a href="#">Create Account</a></li>
							<li class="nav-first"><a href="reset_password.jsp">Forgot Password?</a></li>
						</ul>
					</div>
				</div>
				<div id="sidenav-content" class="main-content">
						<h1>Enter your RSO Profile information</h1>
						<p>Welcome! Please enter the information requested to create an account below.<br/>
						This is a new RSO site and only certified Range Safety Officers can register.<br/>
						Once you register here, the RSO On Duty administrators will validate and verify your information.<br/>
						When your validation is complete, you will get an email informing you that your registration is complete.
						</p>
						<p><b>All Fields are required.</b></p>
					<div class="loginoptions">
					<form id="createAccount" action="RSORegistration" class="basic" method="post">
						<fieldset style="margin: 5px 0px 15px 0px; border-bottom: gray solid 1px;">
							<span class="invisible" id="username-good-spinner" style="margin: 0px 0px 0px 10.5em; vertical-align: middle;"><img src="images/ajax-loader.gif"></img>   Determining if username is available ...</span><br/>
							<label for="createAccount_username" class="classic">Username</label>
							<fieldset>
								<input class="inpu" id="createAccount_username" name="username"/>
							</fieldset>
							<script type="text/javascript">
							var createAccount_username = new LiveValidation('createAccount_username', { 'wait ' : 3000, 'validMessage' : 'Username is avaialable!' });
							createAccount_username.add( Validate.Custom, { against: function(value,args) {
							     return isUsernameAvailable( value ); 
							    }, failureMessage: 'Username not available' } );
							
							</script>
						</fieldset>
						<fieldset style="margin: 5px 0px 15px 0px; border-bottom: gray solid 1px;">
							<label for="createAccount_password" class="classic">Password</label>
							<fieldset>
								<input class="inpp" id="createAccount_password" name="password" type="password" value="" autocomplete="off"/>
							</fieldset>
							<label for="createAccount_passwdcf" class="classic"><span style="letter-spacing:-.03em">Confirm&nbsp;password</span></label>
							<fieldset>
								<input class="inpp" id="createAccount_passwdcf" name="passwdcf" type="password" value="" autocomplete="off"/>
							</fieldset>
							<script type="text/javascript">
					            var createAccount_passwdcf = new LiveValidation('createAccount_passwdcf', { validMessage: 'Passwords match!'});
					            createAccount_passwdcf.add(Validate.Confirmation, { match: 'createAccount_password', failureMessage: "Your passwords don't match!" });
					            createAccount_passwdcf.add( Validate.Presence );
					            var createAccount_password = new LiveValidation('createAccount_password', { 'validMessage' : 'Thank you!' } );
					            createAccount_password.add( Validate.Length, { minimum: 6 } );
					            createAccount_password.add( Validate.Presence );
				 		 	</script>
						</fieldset>
						<fieldset style="margin: 5px 0px 15px 0px; border-bottom: gray solid 1px;">
							<label for="createAccount_firstname" class="classic">First name</label>
							<fieldset>
								<input class="inpp" id="createAccount_firstname" name="firstname"/>
							</fieldset>
							<label for="createAccount_lastname" class="classic">Last name</label>
							<fieldset>
								<input class="inpp" id="createAccount_lastname" name="lastname"/>
							</fieldset>
							<label for="createAccount_email" class="classic">Email</label>
							<fieldset>
								<input class="inpp" id="createAccount_email" name="email"/>
							</fieldset>
							<label for="createAccount_phone" class="classic">Phone</label>
							<fieldset>
								<input class="inpp" id="createAccount_phone" name="phone"/>
							</fieldset>
							<script type="text/javascript">
								var createAccount_firstname = new LiveValidation('createAccount_firstname', { 'validMessage' : ' ' } );
								createAccount_firstname.add( Validate.Presence );
								var createAccount_lastname = new LiveValidation('createAccount_lastname', { 'validMessage' : ' ' } );
								createAccount_lastname.add( Validate.Presence );
								var createAccount_phone = new LiveValidation('createAccount_phone', { 'validMessage' : ' ' } );
								createAccount_phone.add( Validate.Presence );
								var createAccount_email = new LiveValidation('createAccount_email', { 'validMessage' : 'Valid email address!' } );
								createAccount_email.add( Validate.Email );
								createAccount_email.add( Validate.Presence );
		         		 	</script>
						</fieldset>
						<fieldset style="margin: 5px 0px 15px 0px; border-bottom: gray solid 1px;">
							<label for="createAccount_rsoid" class="classic">RSO Number</label>
							<fieldset>
								<input class="inpp" id="createAccount_rsoid" name="rsoid"/>
							</fieldset>
							<label for="createAccount_rsoidcf" class="classic">Confirm RSO Number</label>
							<fieldset>
								<input class="inpp" id="createAccount_rsoidcf" name="rsoidcf"/>
							</fieldset>
							<script type="text/javascript">
								var createAccount_rsoid = new LiveValidation('createAccount_rsoid', { 'validMessage' : '' } );
								createAccount_rsoid.add( Validate.Presence );
								createAccount_rsoid.add( Validate.Numericality, { onlyInteger: true } );
					            var createAccount_rsoidcf = new LiveValidation('createAccount_rsoidcf');
					            createAccount_rsoidcf.add(Validate.Confirmation, { match: 'createAccount_rsoid', failureMessage: "Your RSO IDs don't match!", 'validMessage' : 'RSO IDs match!'} );
					            createAccount_rsoidcf.add( Validate.Presence );
					            createAccount_rsoidcf.add( Validate.Numericality, { onlyInteger: true } );
							</script>
						</fieldset>
						<fieldset>
							<fieldset style="margin: 0px 0px 0px 9.5em;">
								<input value="1" type="checkbox" name="accept" id="createAccount_accept_1">&nbsp;<label for="createAccount_accept_1">I accept the <a href="/legal/acceptable-use-policy/">RSO OnDuty Services Agreement</a> and RSO OnDuty's <a  href="/legal/dyn-privacy-policy/">Privacy Policy</a>.</label><br>
							</fieldset>
							<script type="text/javascript">
								var createAccount_accept_1 = new LiveValidation('createAccount_accept_1');
								createAccount_accept_1.add(Validate.Acceptance);
							</script>
						</fieldset>
						<fieldset style="margin-top:15px" class="submit">
							<input type="submit" name="submit" id="createAccount_submit" value="Create Account"/>
						</fieldset>
					</form>
					
					</div>
				</div>

			</div>

		</div>
	</div>
	<jsp:include page="footer.jsp" /></body>
</html>

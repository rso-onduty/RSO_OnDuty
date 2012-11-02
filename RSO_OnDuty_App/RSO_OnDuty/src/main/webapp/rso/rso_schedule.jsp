
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
	<link href="../css/ui-lightness/jquery-ui-1.8.21.custom.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="../js/jquery-ui-1.8.21.custom.min.js"></script>
<script type="text/javascript" src="../js/onDutyList.js"></script>
<script type="text/javascript" src="../js/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../js/jquery-ui-sliderAccess.js"></script>
<script type="text/javascript" src="../js/livevalidation_standalone.js"></script>
	
<%@ page import="org.frederickiwla.utils.*" %>
<%
	RSODataUtils utils = new RSODataUtils();		
	String username = request.getRemoteUser();

	String isOnDuty = utils.isOnDuty(request.getRemoteUser());
	// This is a comment
%>

<script type="text/javascript">
	var username = "<%= request.getRemoteUser() %>";
	var requestURL = "<%= request.getContextPath() %>";
	setInterval(function() { loadScheduleDiv(username); },100000);
	var isOnDuty = "<%= isOnDuty%>";


	$(
		function() {
			loadScheduleDiv(username);	
			$('#logoutButton').button();
			$('#scheduleDate').datetimepicker({
				ampm: true,
				addSliderAccess: true,
				stepMinute: 15,
				hourGrid: 4,
				minuteGrid: 15,
				hourMin: 6,
				hourMax: 20,
				hour: 12,
				minute: 0,
				sliderAccessArgs: { touchonly: true }
			});
		}

	);

	function scheduleRSO(form) {
//		$('#onDutyListContainer').fadeOut('slow');
		//$('#scheduleResult').toggle('invisible');

		var inputs = $("#scheduleDuty :input");
		var rsoData = {};
		$.map(inputs, function(n, i)
		{
			if (n.type == 'radio') {
				if (n.checked) {
					rsoData[n.name] = $(n).val();
				}
			} else {
		    	rsoData[n.name] = $(n).val();
			}
		});		
		
		$.ajax({
			'type': 'post',
			'url': requestURL + "/api/OnDutyList/schedule/"+username,
			'data' : rsoData,
			'success' : function(data) {
//				$('#scheduleResult').toggle('invisible');
//				$('#onDutyListContainer').toggle('invisible');
//				$('#scheduleResult').fadeIn('slow');
//				setTimeout("$('#onDutyListContainer').fadeIn('slow'); ", 5000);
				loadScheduleDiv(username);
			},
//			'error' : function(data) {
//				alert("Something went wrong: "+data.toString());
//			},
			'async' : false
		});
	
		
	} 
	
</script>


</head>


<body>


	<div id="wrapper">
		<div id="wrapper2">
			<jsp:include page="../header.jsp">
			    <jsp:param name="currentPage" value="RSO Scheduling" />
			</jsp:include>
			
			<div id="rso-login-bar">
				<%
						String fullName = utils.getRSOFullName(request.getRemoteUser());
						boolean isVetted = utils.isRSOVetted(request.getRemoteUser());
				%>
				<div id="username">
					<div style="float: left;" >
						<h2 id="fullUserName" style="font-size: 1.6em;padding: 5px 50px 10px 10px;" >
							Welcome, <%=fullName%></h2>
					</div>
					<div style="float: right;">
						<form method="post" action="<%= request.getContextPath() %>/LoginServlet">
							<div>
								<input type="hidden" name="function" value="logout" />
								<input id="logoutButton" type="submit" value="Logout"/>
							</div>
						</form>
					</div>
				</div>
			</div>

			<div id="schedule-wrapper" style="height: 420px">
					<div id="currently-on-duty" class="schedule-container" style="border-style: none; float: left; ">
						<div>
							<h3 id="onDutyListCount" style="text-align: center; margin-top: 35px">Schedule Duty Time</h3>
						</div>
						<div id="onDutyListContainer" style="height: 90%; padding: 20px">
							<div class="loginoptions">
							<form class="basic" id="scheduleDuty" method="post" onsubmit="scheduleRSO(this);">							
							<fieldset style="margin: 5px 0px 15px 0px; border-bottom: gray solid 1px;">
								<input type="hidden" id="createAccount_username" name="username" value="<%= username %>"/>
								<label for="scheduleDate" class="classic">Schedule Date</label>
								<fieldset><input class="inpp" id="scheduleDate" name="scheduleDate"/></fieldset>
								<script type="text/javascript">
									var scheduleDate = new LiveValidation('scheduleDate', { 'validMessage' : 'OK' } );
									scheduleDate.add( Validate.Presence );
								</script>
								<label class="classic" for="hours">How many hours?</label>
								<fieldset>
									<select class="inpp" id="hours" name="hours">
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
								</fieldset>
								<label for="scheduleRadio" class="classic">Schedule Type</label>
									<fieldset >
									<div id="scheduleRadio" >
										<input type="radio" value="P" id="personalType" name="scheduleType" checked="checked" style="vertical-align: baseline" /><label for="personalType">Personal</label>
										<input type="radio" value="C" id="clubObligationType" name="scheduleType"  style="vertical-align: baseline" /><label for="clubObligationType">Club</label>
									</div>
									</fieldset>
							</fieldset>
							<fieldset style="margin-top:15px" class="submit">
								<input type="submit" name="submit" id="schedule_submit" value="Schedule Duty"/>
							</fieldset>
							</form>
							<script type="text/javascript">
									$('#schedule_submit').button();
							</script>
							</div>
						</div>
						<div class="invisible" id="scheduleResult" style="height: 90%; padding: 20px">
							<div style="height=200px; text-align: center; vertical-align: middle;">
								<h1>Successful Schedule submission</h1>
							</div>
						</div>
					</div>
					<div id="on-duty-schedule" class="schedule-container" style="float: left">
						<div>
							<h3 style="text-align: center;">Duty Schedule</h3>
						</div>
						<div id="scheduleListContainer" style="height: 90%; overflow: auto; "></div>
					</div>
				</div>
		</div>
		<div id="legend" style="width: 1000px; margin: auto; height: 50px">
			<div style="float: right"><p> = Club Obligation</p></div>
			<div style="float: right"><img style='padding-left: 20px' src="/images/club.png"/></div>
			<div style="float: right"><p> = Personal Schedule</p></div>
			<div style="float: right"><img src="/images/personal.png"/></div>
		</div>

	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>

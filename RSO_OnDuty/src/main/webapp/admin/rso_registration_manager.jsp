
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

%>

<script type="text/javascript">
	var username = "<%= request.getRemoteUser() %>";
	var requestURL = "<%= request.getContextPath() %>";
	setInterval(function() { loadVettedDiv(); loadUnvettedDiv(); },60000);


	$(
		function() {
			loadUnvettedDiv();	
			loadVettedDiv();
			$('#logoutButton').button();
		}

	);

	function loadUnvettedDiv() {
		$("#unvettedListContainer").html("");
		$.getJSON(requestURL+"/api/OnDutyList/unvettedRSOList", function(rsoList) {
			
	         $("#unvettedListCount").html("Unvetted RSO Registrations: " + rsoList.length);
			jQuery.each(rsoList, function(rsoEntryIndex) {
				var rsoName = "rsoNameLine"+rsoEntryIndex;
				var rsoId = this._id.$oid;
				var regDate = new Date(this.dateRegistered.$date);
				var regDateFormatted = regDate.toLocaleTimeString();
				
				$("#unvettedListContainer").append("<div id='"+rsoName+"UnvActions' class='vetting-line-item'><div style='float: left;'><table id='"+rsoName+"Unv'></table></div></div>");
				var rsoTable = $("#"+rsoName+"Unv");
				var rsoActionsDiv = $("#"+rsoName+"UnvActions");


				rsoTable.append("<tr><td class='rso-vetting-table-label' align='right'>Name:</td><td class='rso-table-value' >"+this.firstName+" "+this.lastName+"</td></tr>");
				rsoTable.append("<tr><td class='rso-vetting-table-label' align='right'>Username:</td><td class='rso-table-value' >"+this.username+"</td></tr>");
				rsoTable.append("<tr><td class='rso-vetting-table-label' align='right'>RSO Number:</td><td class='rso-table-value' >"+this.rsoID+"</td></tr>");
				rsoTable.append("<tr><td class='rso-vetting-table-label' align='right'>Date Registered:</td><td class='rso-table-value' >"+regDateFormatted+"</td></tr>");
				rsoTable.append("<tr><td class='rso-vetting-table-label' align='right'>Phone:</td><td class='rso-table-value' >"+this.phone+"</td></tr>");
				rsoTable.append("<tr><td class='rso-vetting-table-label' align='right'>Email:</td><td class='rso-table-value' >"+this.email+"</td></tr>");

				
				rsoActionsDiv.append("<div style='float: right; padding: 5px'><a href='#' onclick='vetRSO(\""+rsoId+"\")'><img src='"+requestURL+"/images/add-rso.png'/></a></div>");
				

	    	});
		});

	}
	
	function loadVettedDiv() {
		$("#vettedListContainer").html("");
		$.getJSON(requestURL+"/api/OnDutyList/vettedRSOList", function(rsoList) {
			
	         $("#vettedListCount").html("Vetted RSO List: " + rsoList.length);
			jQuery.each(rsoList, function(rsoEntryIndex) {
				var rsoName = "rsoNameLine"+rsoEntryIndex;
				var rsoId = this._id.$oid;
				var vettedDate = new Date(this.dateVetted.$date);
				var vettedDateFormatted = vettedDate.toLocaleTimeString();
				
				$("#vettedListContainer").append("<div id='"+rsoName+"Actions' class='vetting-line-item'><div style='float: left;'><table id='"+rsoName+"'></table></div></div>");
				var rsoTable = $("#"+rsoName);
				var rsoActionsDiv = $("#"+rsoName+"Actions");


				rsoTable.append("<tr><td class='rso-vetting-table-label' align='right'>Name:</td><td class='rso-table-value' >"+this.firstName+" "+this.lastName+"</td></tr>");
				rsoTable.append("<tr><td class='rso-vetting-table-label' align='right'>Username:</td><td class='rso-table-value' >"+this.username+"</td></tr>");
				rsoTable.append("<tr><td class='rso-vetting-table-label' align='right'>RSO Number:</td><td class='rso-table-value' >"+this.rsoID+"</td></tr>");
				rsoTable.append("<tr><td class='rso-vetting-table-label' align='right'>Date Vetted:</td><td class='rso-table-value' >"+vettedDateFormatted+"</td></tr>");
				rsoTable.append("<tr><td class='rso-vetting-table-label' align='right'>Phone:</td><td class='rso-table-value' >"+this.phone+"</td></tr>");
				rsoTable.append("<tr><td class='rso-vetting-table-label' align='right'>Email:</td><td class='rso-table-value' >"+this.email+"</td></tr>");

				
				rsoActionsDiv.append("<div style='float: right; padding: 5px'><a href='#' onclick='unvetRSO(\""+rsoId+"\")'><img src='"+requestURL+"/images/delete-x.png'/></a></div>");
				

	    	});
		});
		
	}	
		
	function vetRSO(rsoId) {
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
			    <jsp:param name="currentPage" value="" />
			</jsp:include>
			
			<div id="rso-login-bar">
				<%
						String fullName = utils.getRSOFullName(request.getRemoteUser());
				%>
				<div id="username">
					<div style="float: left;" >
						<h2 id="fullUserName" style="font-size: 1.6em;padding: 5px 50px 10px 10px;" >
							Welcome, <%=fullName%></h2>
					</div>
					<div style="float: left">
						<h1>RSO Vetting</h1>
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

			<div id="schedule-wrapper" style="height: 410px">
					<div id="unvetted-rso-list" class="schedule-container" style="float: left; ">
						<div>
							<h3 id="unvettedListCount" style="text-align: center;">Unvetted RSO Registrations</h3>
						</div>
						<div id="unvettedListContainer" style="height: 90%; overflow: auto; "></div>
					</div>
					<div id="unvetted-rso-list" class="schedule-container" style="float: left">
						<div>
							<h3 id="vettedListCount" style="text-align: center;">Vetted RSO List</h3>
						</div>
						<div id="vettedListContainer" style="height: 90%; overflow: auto; "></div>
					</div>
				</div>
		</div>

	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>

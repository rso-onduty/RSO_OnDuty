

function switchDuty(button, username) {
	if (isOnDuty == "true") {
		imOffDuty(button, username);
	} else {
		imOnDuty(button, username);
	}
	loadOnDutyDiv(titleText);
	
}


function imOnDuty(button, username) {
	
	var duration = $("#hours").val();
	var rsoData = { "duration" : duration };
	
	$.ajax({
			'type': 'post',
			'url': requestURL + "/api/OnDutyList/goOnDuty/"+username,
			'data' : rsoData,
			'success' : function(data) {
//				alert(username + " is On Duty now for " + duration + " hours");
				$("#onDutyButton").button("option", "label", "I'm Off Duty");
				$("#extendDutyButton").attr("style","display: block");
				isOnDuty = "true"; },
			'error' : function(data) {
//				alert("Something went wrong: "+data.toString());
			},
			'async' : false
	});
}


function extendDuty(button, username) {
	
	var duration = $("#hours").val();
	var rsoData = { "duration" : duration };
	
	
	$.ajax({
		'type': 'post',
		'url': requestURL + "/api/OnDutyList/extendDuty/"+username,
		'data' : rsoData,
		'success' : function(data) {
			loadOnDutyDiv(titleText);
		},
//		'error' : function(data) {
//			alert("Something went wrong: "+data.toString());
//		},
		'async' : false
	});
	
}


function imOffDuty(button, username) {
	
	var rsoData = { "username" : username };
	$.ajax({
		'type': 'post',
		'url': requestURL + "/api/OnDutyList/goOffDuty/"+username,
		'data' : rsoData,
		'success' : function(data) {
//			alert(username + " is Off Duty");
			$("#onDutyButton").button("option", "label", "I'm On Duty");
			$("#extendDutyButton").attr("style","display: none");
			isOnDuty = "false"; },
		'error' : function(data) {
//			alert("Something went wrong: "+data.toString());
		},
		'async' : false
	});
	
}


function createOnDutyButton() {
	$("#onDutyButton").click(function(){ switchDuty(this, username);  });
	if (isOnDuty == "true") {
		$("#onDutyButton").button({"label": "I'm Off Duty"});
	} else {
		$("#onDutyButton").button({"label": "I'm On Duty"});
	};
	
	
}


function createExtendDutyButton() {
	$("#extendDutyButton").click(function(){ extendDuty(this, username);  });
	$("#extendDutyButton").button({"label": "Extend Duty"});
	if (isOnDuty == "true") {
		$("#extendDutyButton").attr("style","display: block");
	} else {
		$("#extendDutyButton").attr("style","display: none");		
	};
	
	
}

function loadOnDutyDiv(titleText) {

	$("#onDutyListContainer").html("");
	$.getJSON(requestURL+"/api/OnDutyList/onDuty", function(onDutyList) {
		
		var refreshDate = new Date();
	    var onDutyListSize = onDutyList.length;
         $("#onDutyListCount").html(titleText + onDutyListSize + " as of "+refreshDate.toLocaleTimeString());
		jQuery.each(onDutyList, function(dutyEntry) {
			var rsoName = "rsoNameLine"+dutyEntry;
			$("#onDutyListContainer").append("<div class='duty-line-item'><table width=100%><tr><td style='width: 60%'><table id='"+rsoName+"'></table></td><td style='width: 40%'><table class='rso-remain-table' id='"+rsoName+"Remain'></table></td></tr></table></div>");
			var rsoTable = $("#"+rsoName);
			var remainTable = $("#"+rsoName+"Remain");
			var onDutyDate = new Date(this.onDutyAt.$date);
			var offDutyDate = new Date(this.offDutyAt.$date);
			var onDutyFormatted = onDutyDate.toLocaleTimeString();
			var offDutyFormatted = offDutyDate.toLocaleTimeString();
			rsoTable.append("<tr><td class='rso-table-label' align='right'>Name:</td><td class='rso-table-value' >"+this.firstName+" "+this.lastName+"</td></tr>");
			rsoTable.append("<tr><td class='rso-table-label' align='right'>On Duty at:</td><td class='rso-table-value' >"+onDutyFormatted+"</td></tr>");
			rsoTable.append("<tr><td class='rso-table-label' align='right'>Off duty at:</td><td class='rso-table-value' >"+offDutyFormatted+"</td></tr>");

			var timeRemaining = offDutyDate.getTime() - refreshDate.getTime();
			var timeRemainingHours = Math.floor(timeRemaining / 3600000);
			var timeRemainingMinutes = Math.floor((timeRemaining % 3600000) / 60000);
			var timeRemainingFormatted = timeRemainingHours + " hrs "+timeRemainingMinutes+" mins";
			
			
			remainTable.append("<tr><td class='rso-remain-table-label'><b>Time Remaining</b></td></tr>");
			remainTable.append("<tr><td class='rso-remain-table-value'>"+timeRemainingFormatted+"</td></tr>");

    	});
	});
	
//	window.status = "RSO OnDuty List refreshed at "+refreshDate.toLocaleTimeString();

}
	
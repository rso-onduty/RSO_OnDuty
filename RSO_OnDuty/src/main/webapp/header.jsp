<div id="header" class="container">
	<div id="IWLA logo" style="float: left;">
		<img height="80" src="<%= request.getContextPath() %>/images/iwla.png"></img>
	</div>
	<div id="logo">
		<h1>
			<a href="#">RSO OnDuty </a>
		</h1>
	</div>
	<div id="menu">
		<ul>
			<% if (request.getParameter("currentPage").equals("Homepage")) { %>
				<li class="current_page_item">
			<% } else { %>
				<li>
			<% } %>
			<a href="<%= request.getContextPath() %>/index.jsp">Homepage</a></li>
			<% if (request.getParameter("currentPage").equals("RSO Scheduling")) { %>
				<li class="current_page_item">
			<% } else { %>
				<li>
			<% } %>
			<a href="<%= request.getContextPath() %>/rso/rso_schedule.jsp">RSO Scheduling</a></li>
			<% if (request.getParameter("currentPage").equals("Account Settings")) { %>
				<li class="current_page_item">
			<% } else { %>
				<li>
			<% } %>
			<%
				if (request.getAuthType() == null) {
			%>
				<a href="<%= request.getContextPath() %>/rso_registration.jsp">RSO Registration</a></li>
			<% } else { %>
				<a href="<%= request.getContextPath() %>/rso/account_settings.jsp">Account Settings</a></li>
			<% } %>
			<li><a href="http://frederickiwla.org">Frederick IWLA</a></li>
		</ul>
	</div>
</div>
<!-- end #header -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.apr.model.User" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Set" %>
<%@page import="java.util.Map" %>
	<%
		User user=null;
		if(session.getAttribute("user")==null){ %>
		<jsp:forward page="index.jsp"/> 
	<%}
		else
			user=(User)session.getAttribute("user");
		
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Welcome <%=user.getFirstName()%></title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	
	<link href="css/style.css" rel="stylesheet">
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="js/script.js"></script>
</head>
<body>
	<div class="main-wrapper">
		<jsp:include page="header.jsp" />
		<div id="playlist-container">
			<%
				Map<Integer,List<String>> recommendations=(Map<Integer,List<String>>)request.getAttribute("rcom");
				if(recommendations!=null){ 
					int numberOfPlaylists=recommendations.size();
					Set<Integer> playlists=recommendations.keySet();
					int playlistCounter=0;
					for(Integer playlist:playlists){
						playlistCounter++;
						List<String> songs=recommendations.get(playlist);
				%>
					<div class="plalist-panel">
						<ul class="list-group">
							<% if(request.getAttribute("searched_song")!=null){ %>
								<li class="list-group-item active">Playlist for <%=request.getAttribute("searched_song") %></li>
							<%} else { %>
		  						<li class="list-group-item active">Playlist <%=playlistCounter %></li>
		  					<%} %>
						<%
						for(int i=0;i<songs.size();i++){ %>
						
						  <li class="list-group-item list-group-item-default"><%=songs.get(i) %></li>
							
						<%}%>
					
						</ul>
					</div>
					
				<% }
				
				}%>
			</div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
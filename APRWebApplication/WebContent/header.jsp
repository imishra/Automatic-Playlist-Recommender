<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="com.apr.model.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title></title>
	<link href="css/header.css" rel="stylesheet">
</head>
<body>
	<%
		User user=null;
		String name="";
		if(session.getAttribute("user")!=null){  
			user=(User)session.getAttribute("user");
			name=user.getFirstName()+" "+user.getLastName();
		%>
		<div id="header">
			<div class="name-banner"><a href="<%=request.getContextPath()%>/home" class="header-link" title="home"><%=name%></a></div> 
			
			<div class="container" id="search-container">
				<div class="row">
					<div class="col-md-12">
			            <div class="input-group" id="adv-search">
			            	<form class="form-horizontal" role="form" method="post" action="search" name="search-form" id="search-form">
			                	<input type="text" name="ctrack" class="form-control" placeholder="Enter a song name" id="searchbox" />
			                	<input type="hidden" name="rcom" id="rcom" value="mbcf">
			                </form>
			                <div class="input-group-btn">
			                    <div class="btn-group" role="group">
			                        <div class="dropdown dropdown-lg" id="search-dd">
			                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" id="search-ul" ><span class="caret"></span></button>
			                            <div class="dropdown-menu dropdown-menu-right" id="dropdown-menu-search" role="menu">
			                                <div class="form-group">
			                                    <label for="filter">Filter by</label>
			                                    <select class="form-control" id="rcom-label">
			                                        <option value="0" selected>Personalized</option>
			                                        <option value="1">Most popular</option>
			                                    </select>
			                                  </div>
			                            </div>
			                        </div>
			                        <button type="button" class="btn btn-primary" id="search-btn"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
			                    </div>
			                </div>
			            </div>
			          </div>
			        </div>
				</div>
			
			<a href="logout" class="logout-banner header-link">Logout</a>
			
		</div>
		<% }else{ %>
		<div id="header"></div>
	<%}%>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.apr.model.User" %>
	<%
	User user=null;
	if(session.getAttribute("user")!=null){ 
		response.sendRedirect("home");  
	 } %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Automatic Playlist Recommender</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	
	<link href="css/style.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="js/script.js"></script>
	<script src="js/validator/validator.min.js"></script>
</head>
<body>
	<div class="main-wrapper">
		<jsp:include page="header.jsp" />
		<div class="container">
			<div id="loginbox"
				class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 page-center-panel">
				<div class="panel" id="login-panel">
					<div class="panel-heading custom-heading">
						<div class="panel-title">Sign In</div>
						<div style="float: right; font-size: 80%; position: relative; top: -10px">
							<a href="#">Forgot password?</a>
						</div>
					</div>
					<div style="padding-top: 30px" class="panel-body">
						<div style="display: none" id="login-alert" class="alert alert-danger col-sm-12"></div>
						<form id="loginform" action="login" class="form-horizontal" role="form" method="post" data-toggle="validator">
							<div class="form-group has-feedback">
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
									<input id="login-username" pattern="^[A-z0-9]{1,}$" type="text" class="form-control" name="username" value="" required placeholder="username">
								</div>
								<span class="glyphicon form-control-feedback" aria-hidden="True"></span>
	                            <div class="help-block with-errors"></div>
	                        </div>
	                        <div class="form-group has-feedback" style="margin-bottom: 10px">
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span> 
									<input id="login-password" type="password" class="form-control" name="password" required placeholder="password">
								</div>
								<span class="glyphicon form-control-feedback" aria-hidden="True"></span>
	                            <div class="help-block with-errors"></div>
	                        </div>
							<div style="margin-top: 10px" class="form-group">
								<div class="col-sm-12 controls">
									<input type="submit" id="btn-login" value="Login" class="btn btn-primary btn-block">
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12 control">
									<div style="border-top: 1px solid #888; padding-top: 15px; font-size: 85%">
										Don't have an account! 
										<a href="#" onClick="$('#loginbox').hide(); $('#signupbox').show()">Sign Up Here </a>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div id="signupbox" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 page-center-panel">
				<div class="panel panel-info">
					<div class="panel-heading custom-heading">
						<div class="panel-title">Sign Up</div>
						<div style="float: right; font-size: 85%; position: relative; top: -10px">
							<a id="signinlink" href="#" onclick="$('#signupbox').hide(); $('#loginbox').show()">Sign In</a>
						</div>
					</div>
					<div class="panel-body">
						<form id="signupform" class="form-horizontal" role="form" action="signup" method="post" data-toggle="validator">
							<div id="signupalert" style="display: none"
								class="alert alert-danger">
								<p>Error:</p>
								<span></span>
							</div>
							<div class="form-group has-feedback">
								<label for="username" class="col-md-3 control-label">Username</label>
								<div class="col-md-9 input-group">
									<input type="text" class="form-control" pattern="^[A-z0-9]{1,}$" name="username" required  placeholder="Pick a username">
								</div>
								<span class="glyphicon form-control-feedback" aria-hidden="True"></span>
			                    <div class="help-block with-errors"></div>
							</div>
							<div class="form-group has-feedback">
								<label for="email" class="col-md-3 control-label">Email</label>
								<div class="col-md-9">
									<input type="text" class="form-control" pattern="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" name="email" required placeholder="Email Address">
								</div>
								<span class="glyphicon form-control-feedback" aria-hidden="True"></span>
			                    <div class="help-block with-errors"></div>
							</div>
							<div class="form-group">
								<label for="firstname" class="col-md-3 control-label">First Name</label>
								<div class="col-md-9">
									<input type="text" class="form-control" pattern="^[A-z]{1,}$" name="firstname" required placeholder="First Name">
								</div>
								<span class="glyphicon form-control-feedback" aria-hidden="True"></span>
			                    <div class="help-block with-errors"></div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-md-3 control-label">Last Name</label>
								<div class="col-md-9">
									<input type="text" class="form-control" pattern="^[A-z]{1,}$" name="lastname" required placeholder="Last Name">
								</div>
								<span class="glyphicon form-control-feedback" aria-hidden="True"></span>
			                    <div class="help-block with-errors"></div>
							</div>
							
							<div class="form-group relative sex-dropdown">
							<input type="hidden" name="sex" id="sex-input" class ="hidden-input" value="">
								<label for="Sex" class="col-md-3 control-label">Sex</label>
								<button class="col-md-3 btn btn-default btn-small dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">
	                                <span class="selected" data="Select">Select</span>
	                                <span class="caret"></span></button>
	                            <ul class="dropdown-menu" id="sex-menu" role="menu" aria-labelledby="menu1">
	                                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Male</a></li>
	                                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Female</a></li>
	                                <li role="presentation" class="divider"></li>
	                                <li role="presentation"><a role="menuitem" class="dropdown-reset"tabindex="-1" href="#">Reset Selection</a></li>
	                            </ul>
	                        </div>
	                        
							<div class="form-group">
								<label for="Street Address" class="col-md-3 control-label">Street Address</label>
								<div class="col-md-9">
									<input type="text" class="form-control" name="address" required placeholder="Street Address">
								</div>
								<span class="glyphicon form-control-feedback" aria-hidden="True"></span>
			                    <div class="help-block with-errors"></div>
							</div>
							<div class="form-group">
								<label for="City" class="col-md-3 control-label">City</label>
								<div class="col-md-9">
									<input type="text" class="form-control" pattern="^[A-z]{1,}$" name="city" required placeholder="City">
								</div>
								<span class="glyphicon form-control-feedback" aria-hidden="True"></span>
			                    <div class="help-block with-errors"></div>
							</div>
							
							<div class="form-group relative country-dropdown">
								<input type="hidden" name="country" id="country-input" class ="hidden-input" value="">
								<label for="Country" class="col-md-3 control-label">Country</label>
	                            <button class="col-md-3 btn btn-default btn-small dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">
	                                <span class="selected" data="Select">Select</span>
	                                <span class="caret"></span></button>
	                            <ul class="dropdown-menu" id="country-menu" role="menu" aria-labelledby="menu1">
	                                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">United States</a></li>
	                                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Others</a></li>
	                                <li role="presentation" class="divider"></li>
	                                <li role="presentation"><a role="menuitem" class="dropdown-reset"tabindex="-1" href="#">Reset Selection</a></li>
	                            </ul>
	                        </div>
							<div class="form-group">
								<label for="password" class="col-md-3 control-label">Password</label>
								<div class="col-md-9">
									<input type="password" class="form-control" name="passwd" placeholder="Password">
								</div>
							</div>

							<div class="form-group">
								<div class="col-md-offset-3 col-md-9">
									<button id="btn-signup" type="submit" class="btn btn-primary btn-block"><i class="icon-hand-right"></i> &nbsp Sign Up</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
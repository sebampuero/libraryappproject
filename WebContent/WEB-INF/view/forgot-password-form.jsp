<!DOCTYPE>
<html>
<head>
<title>
	Forgot password
</title>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.css" />
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/login-page.css" />
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</head>
<body style="overflow-x:hidden;">
<div class="blur"></div>
<div class="container-fluid">
	<div class="row">
		<div class="wrapper">
			<div class="col-lg-12 col-md-12 col-xs-12">
			<h2 style="color:#ffffff;"><strong>Reset password</strong></h2>
			
			<form action="forgotPassword" method="POST">
				<div class="form-group">
					<font color="#ffffff"><label>Email</label></font>
					<input  class="form-control" type="email" name="email" placeholder="Johndoe@email.com">
				</div>
				<div class="form-group">
					<button class="btn btn-default"type="submit">Send</button>
				</div>
			</form>
			<a href="login">Login</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>
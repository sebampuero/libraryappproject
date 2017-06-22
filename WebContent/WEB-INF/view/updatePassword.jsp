<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE>
<html>
<head>
<title>
	Update password
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
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
</head>
<body style="overflow-x:hidden;">
<div class="blur"></div>
<div class="container-fluid">
	<div class="row">
		<div class="wrapper">
			<div class="col-lg-12 col-md-12 col-xs-12">
			<sec:authorize access="hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
				
				<form action="savePassword" method="POST" id="theForm">
				
					<div class="form-group">
						<font color="#ffffff"><label>Password</label></font>
						<input type="password" class="form-control" name="password" id="password">
					</div>
					<div class="form-group">
						<font color="#ffffff"><label>Confirm password</label></font>
						<input type="password" class="form-control" id="password_repeat" name="password_repeat">
					</div>
					<button type="submit" class="btn btn-default">Submit</button>
				</form>
				
			</sec:authorize>
			</div>
		</div>
	</div>
</div>
<script lang="text/javascript">
	$( '#theForm' ).validate({
		rules: {
	    	password: "required",
	    	password_repeat: {
	      		equalTo: "#password"
	    	}
		},
	    messages: {
	    	password: 'Passwords must be equal!',
	    	password_repeat: {
	    		equalTo: jQuery.validator.format('Passwords must be equal!')
	    	}
	    }
	});
</script>
</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE>
<html>
<head>
<title>
	Edit profile
</title>
<meta  name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, maximum-scale=1.0, minimum-scale=1.0, shrink-to-fit=no"/>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.css" />
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/editprofileform.css" />
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<link type="text/css"
		  rel="stylesheet"
		  href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
</head>
<body style="background-color: #e8eae9 !important;overflow-x:hidden;">
<%@include file="header-user-sep.jsp" %>
<div class="wrapper">
	<div class="container-fluid">
		<div class="row">
		<!-- How to center a grid in Bootstrap: centered div = (12 - size of div)/2 -->
			<div class="col-lg-8 col-lg-offset-2 col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2 col-xs-8 col-xs-offset-2">
			<h2 style="text-align:center;">Edit profile</h2>
				<div class="parent-container">
					<form:form action="editProfile" method="POST" modelAttribute="form" class="form-horizontal" id="editForm">
						<form:hidden path="userName"/>
						<div class="form-group">
							<label for="Name" class="text-label col-sm-4 control-label">New name </label>
							<div class="col-sm-6">
								<form:input type="text" name="name" class="form-control" path="name"/><form:errors path="name" cssClass="error"/>
							</div>
						</div>
						<div class="form-group">
							<label for="Name" class="text-label col-sm-4 control-label">New last name </label>
							<div class="col-sm-6">
								<form:input type="text" name="lastName" class="form-control" path="lastName"/><form:errors path="lastName" cssClass="error"/>
							</div>
						</div>
						<div class="form-group">
							<label for="Name" class="text-label col-sm-4 control-label">New email </label>
							<div class="col-sm-6">
								<form:input type="email" name="email" class="form-control" path="email"/><form:errors path="email" cssClass="error"/>
							</div>
						</div>
						<div class="form-group">
							<label for="Name" class="text-label col-sm-4 control-label">New password(Or actual one) </label>
							<div class="col-sm-6">
								<form:input type="password" name="password" class="form-control" path="password" id="password"/><form:errors path="password" cssClass="error"/>
							</div>
						</div>
						<div class="form-group">
							<label for="Name" class="text-label col-sm-4 control-label">Confirm password </label>
							<div class="col-sm-6">
								<input type="password" class="form-control" name="password_repeat" id="password_repeat">
							</div>
						</div>
						<div class="col-sm-3 col-sm-offset-5">
							<button type="submit" class="btn btn-default">Save changes</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>
<script lang="text/javascript">
	$( "#editForm" ).validate({
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
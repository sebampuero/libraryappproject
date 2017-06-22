<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE>
<html>
<head>
<title>
	Administrators control panel
</title>
<meta  name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, maximum-scale=1.0, minimum-scale=1.0, shrink-to-fit=no"/>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.0.min.js"></script>
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.css" />
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/adminscontrolpanel.css" />
</head>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<body style="background-color: #e8eae9 !important;overflow-x:hidden;">
	<%@include file="header-admin-sep.jsp" %>
	<div class="wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<h2 style="text-align:center;">Create a new admin</h2>
						<div class="col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3 col-xs-12">
							<form:form action="createAdmin" method="POST" modelAttribute="regForm" id="admin-form">
								<div class="form-group">
									<label for="name">Name</label>
									<form:input type="text" class="form-control" name="name" path="name"/><form:errors path="name"/>
								</div>
								<div class="form-group">
									<label for="name">Last name</label>
									<form:input type="text" class="form-control" name="lastName" path="lastName"/><form:errors path="lastName"/>
								</div>
								<div class="form-group">
									<label for="name">Username</label>
									<form:input type="text" class="form-control" name="userName" path="userName"/><form:errors path="userName"/>
								</div>
								<div class="form-group">
									<label for="name">Email</label>
									<form:input type="email" class="form-control" name="email" path="email"/><form:errors path="email"/>
								</div>
								<div class="form-group">
									<label for="name">Password</label>
									<form:input type="password" class="form-control" name="password" path="password"/><form:errors path="password"/>
								</div>
								<button type="submit" class="btn btn-primary btn-lg btn-block">Create admin</button>
							</form:form>
						</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
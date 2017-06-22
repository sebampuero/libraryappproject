<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html style="overflow-x:hidden">
<head>
<meta  name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, maximum-scale=1.0, minimum-scale=1.0, shrink-to-fit=no"/>
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
<body>
<div class="blur"></div>
<div class="container-fluid">
	<div class="row">
		<div class="wrapper">
			<div class="col-lg-12 col-md-12 col-xs-12">
			<h2 style="color:#ffffff;"><strong>Library App V1</strong></h2>
			<form:form action="registerUser" method="POST" modelAttribute="form">
				<div class="form-group">
					<label for="Name" class="text-label">Name</label><form:errors path="name" cssClass="error"/>
					<form:input type="text" class="form-control theInput" placeholder="Name" path="name"/>
				</div>
				<div class="form-group">
					<label for="Lastname" class="text-label">Lastname</label><form:errors path="lastName" cssClass="error"/>
					<form:input type="text" class="form-control theInput" placeholder="Lastname" path="lastName"/>
				</div>
				<div class="form-group">
					<label for="Username" class="text-label">Username</label><form:errors path="userName" cssClass="error"/>
					<form:input type="text" class="form-control theInput" placeholder="Username" path="userName"/>
				</div>
				<div class="form-group">
					<label for="Password" class="text-label">Email</label><form:errors path="email" cssClass="error"/>
					<form:input type="email" class="form-control theInput" placeholder="Email" path="email"/>
				</div>
				<div class="form-group">
					<label for="Password" class="text-label">Password</label><form:errors path="password" cssClass="error"/>
					<form:input type="Password" class="form-control theInput" placeholder="Password" path="password"/>
				</div>
				<button class="btn btn-default" type="submit">Register</button>
			</form:form>
			<a href="/LibraryApp">Back to main page</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>
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
			
			<form:form action="login" method="POST" modelAttribute="user">
				<font color="red">
					${SPRING_SECURITY_LAST_EXCEPTION.message }
				</font>
				<c:if test="${logout != null }">
					<font color="red">
						<label>${logout }</label>
					</font>
				</c:if>
				<c:if test="${passwordMsg != null }">
					<font color="red">
						<label>${passwordMsg }</label>
					</font>
				</c:if>
				<div class="form-group">
					<label for="Username" class="text-label">Username </label><%-- <form:errors path="userName" cssClass="error"/> --%>
					<%-- <form:input type="text" class="form-control theInput" placeholder="Username" path="userName"/> --%>
					<input type="text" name="username" class="form-control theInput" placeholder="Enter username">
				</div>
				<div class="form-group">
					<label for="Password" class="text-label">Password </label><%-- <form:errors path="password" cssClass="error"/> --%>
					<%-- <form:input type="Password" class="form-control theInput" placeholder="Password" path="password"/> --%>
					<input type="password" name="password" class="form-control theInput" placeholder="Enter password">
				</div>
				<button type="submit" class="btn btn-default" data-loading-text="Login in...">Log in</button>
				<button class="btn btn-default" onclick="window.location.href='${home}showRegistrationForm'; return false;">Register</button><br>
				<a href="${home}forgotPassword">Forgot your password?</a>
			</form:form>
			
			</div>
		</div>
	</div>
</div>
</body>
</html>
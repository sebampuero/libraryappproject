<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE>
<html>
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
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #e8eae9 !important;">
<%@include file="header-user-sep.jsp" %>
<div class="wrapper">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-md-12">
				<h1>Lately added books:</h1>
				<h1>Lately registered users:</h1>
				<h1>Highest ranked books:</h1>
			</div>
		</div>
	</div>
</div>

</body>
</html>
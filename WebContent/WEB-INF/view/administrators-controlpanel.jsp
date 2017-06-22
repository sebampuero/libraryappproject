<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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
<body style="background-color: #e8eae9 !important;">
	<%@include file="header-admin-sep.jsp" %>
	<div class="wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<h2 style="text-align:center;">List of admins</h2>
						<div class="col-md-12 col-sm-12 col-xs-12">
								<form action="searchAdmin" method="GET" class="form-inline">
									<div class="form-group">
										<label>Search by name</label>
										<input type="text" class="form-control" name="adminName" placeholder="Search by name">
									</div>
								</form>	
							<div class="contents">
								<table class="table table-hover" id="admins-table">
									<thead>
										<tr>
											<th>Id</th>
											<th>Name</th>
											<th>Last name</th>
											<th>Username</th>
											<th>Picture</th>
											<th>Since</th>
											<th>Email</th>
										</tr>
									</thead>
									<tbody id="contents">
										<c:forEach var="admin" items="${admins }">
											<tr>
												<td>${admin.id}</td>
												<td>${admin.name}</td>
												<td>${admin.lastName}</td>
												<td>${admin.userName}</td>
												<td><c:if test="${admin.image!=null}"><img src="../retrieveProfilePic?userId=${admin.id}" class="img-responsive" height=45 width=35></c:if></td>
												<td><fmt:formatDate value="${admin.created_at}" dateStyle="short"/></td>
												<td>${admin.email}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<c:if test="${fn:length(admins)==0 }">
									<h4 style="text-align:center;">No admins found</h4>
								</c:if>
							</div>
							<a href="createAdmin"><button class="btn btn-primary">Add a new admin</button></a>
						</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
					<h2 style="text-align:center;">List of users</h2>
						<div class="col-md-12 col-sm-12 col-xs-12">
							<form class="form-inline" id="searching-form" action="searchUserByName" method="GET">
								<div class="form-group">
									<label>Search by name</label>
									<input type="text" class="form-control" name="searchName">
								</div>	
							</form>
							<form class="form-inline" id="sorting-form" action="sortUsers" method="GET">
								<div class="form-group">
									<label>Sort</label>
									<select class="form-control" name="sortParam" >
										<option value="created_at">Date of registration</option>
										<option value="name">Name</option>
										<option value="lastName">Last name</option>
									</select>
								</div>
							</form>
							<div class="contents">
								<table class="table table-hover" id="users-table">
									<thead>
										<tr>
											<th>Id</th>
											<th>Name</th>
											<th>Last name</th>
											<th>Username</th>
											<th>Must return books</th>
											<th>Since</th>
											<th>Email</th>
											<th>Profile</th>
										</tr>
									</thead>
									<tbody id="contents">
										<c:forEach var="user" items="${users }">
											<tr>
												<td>${user.id}</td>
												<td>${user.name}</td>
												<td>${user.lastName}</td>
												<td>${user.userName}</td>
												<td>-</td>
												<td><fmt:formatDate value="${user.created_at}" dateStyle="short"/></td>
												<td>${user.email}</td>
												<td><a href="showUserProfile?userName=${user.userName}">User profile</a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/booksview.css" />
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #e8eae9 !important; overflow-x:hidden;">
<%@include file="header-lib-sep.jsp" %>
<div class="wrapper">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-10 col-lg-offset-1 col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-md-10 col-md-offset-1">
				<h2 style="text-align:center;">Books</h2>
			
				
				<form class="form-inline" action="searchBooksByName" method="GET">
				
					<div class="form-group">
						<label for="search-book">Search</label>
						<input type="text" class="form-control" id="search-input" placeholder="Search by title" name="param">
					</div>
				
				</form>
				
<!-- 				<form class="form-inline" action="retriveBooksFilter" method="GET">
					<div class="form-group">
						<label for="sort-books">Sort by  </label>
							<select class="form-control" onchange="this.form.submit()" name="param">
								<option>Select an option</option>
								<option value="title">Title</option>
								<option value="no_copies desc">Number of copies</option>
							</select>
					</div>
				</form> -->
				
				
				<div class="books-container">
					<table class="table table-hover" id="books-table">
						<thead>
							<tr>
								<th>Image</th>
								<th>Author</th>
								<th>Title</th>
								<th>No. of copies</th>
								<th></th>
							</tr>
						</thead>
						<tbody id="contents">
						<c:if test="${books != null }">
							<c:forEach var="book" items="${books }">
							<tr>
								<td><img src="retrieveImage?id=${book.id }" height="45" width="35"/></td>
								<td>
									<c:forEach var="author" items="${book.authors}">
										${author.name}
									</c:forEach>
								</td>
								<td>${book.title }</td>
								<td>${book.no_copies }</td>
								<td><a href="showBookDetails?book-id=${book.id }">Details</a></td>
							</tr>
							</c:forEach>
						</c:if>
						</tbody>
					</table>
					<c:if test="${books == null }">
							<h4 style="text-align:center;">No elements</h4>
					</c:if>
				</div>
				<sec:authorize access="hasRole('ADMIN')">
					<a href="../admin/createBook"><button class="btn btn-default" id="add-book-button">Add a new book</button></a>
				</sec:authorize>
				
			</div>
		</div>
	</div>
</div>
</body>
</html>













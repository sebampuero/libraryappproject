<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE>
<html>
<head>
<title>
	My account
</title>
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
<link type="text/css"
		  rel="stylesheet"
		  href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
</head>
<body style="background-color: #e8eae9 !important;">
<!--  contents -->
<%@include file="header-lib-sep.jsp" %>
<div class="wrapper">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-10 col-lg-offset-1 col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-12">
				<h2 style="text-align:center;">My Books</h2>
				<c:if test="${ bookLoaned!=null}">
					<h5 style="text-align:center;color:green;"><i class="fa fa-check-circle-o" aria-hidden="true"></i>Book loaned! You can go now and pick it up in the Library</h5>
				</c:if>
				<c:if test="${bookNotLoaned!=null }">
					<h5 style="text-align:center;color:red;"><i class="fa fa-exclamation-circle" aria-hidden="true"></i><c:out value="${bookNotLoaned}"/></h5>
				</c:if>
				<form class="form-inline" action="searchBooksByName" method="GET">
				
					<div class="form-group">
						<label for="search-book">Search</label>
						<input type="text" class="form-control" id="search-input" placeholder="Search by title" name="param">
					</div>
				
				</form>
				<div class="books-container">
					<table class="table table-hover" id="books-table">
						<thead>
							<tr>
								<th>Image</th>
								<th>Author</th>
								<th>Title</th>
								<th>Date of return</th>
								<th></th>
							</tr>
						</thead>
						<tbody id="contents">
							<c:if test="${myBooks!=null }">
								<c:forEach var="book" items="${myBooks }">
									<tr>
										<td><img src="retrieveImage?id=${book.id }" height="45" width="35"/></td>
										<td>
										
										<c:forEach var="author" items="${book.authors}">
										
											<c:out value="${author.name}"/>
										
										</c:forEach>
										
										</td>
										<td>${book.title }</td>
										<td><fmt:formatDate value="${book.userReturnDate}" dateStyle="long"/></td>
										<td><a href="showBookDetails?book-id=${book.id }">Details</a></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<c:if test="${myBooks == null }">
							<h4 style="text-align:center;">You have no books</h4>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>










<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!-- helpful in order to retrieve list sizes in jsp -->
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

<!-- MODAL -->

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">Compose Message</h4>
      </div>
      <form method="POST" action="../composeMessage">
      <div class="modal-body">
        	<div class="form-group">
        		<label>Subject</label>
        		<input type="text" name="subject" class="form-control" placeholder="Subject">
        	</div>
        	<div class="form-group">
        		<label>Message</label>
        		<textarea rows=3 name="content" class="form-control"></textarea>
        	</div>
        	<div class="form-group">
        		<label>Recipient</label>
        		<input type="text" name="to" class="form-control" id="recipient" readonly>
        	</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Send message</button>
      </div>
      </form>
    </div>
  </div>
</div>
	<%@include file="header-admin-sep.jsp" %>
	<div class="wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-6 col-sm-12 col-xs-12">
					<h3>${user.userName}´s profile</h3>
					<img src="../retrieveProfilePic?userId=${user.id}" height=400 width=340 class="img-responsive">
				</div>
				<div class="col-md-6 col-sm-12 col-xs-12">
					<h3>User details</h3>
					<label>Name</label><c:out value="${user.name}"/><br>
					<label>Last name</label><c:out value="${user.lastName}"/><br>
					<label>Email</label><c:out value="${user.email}"/><br>
					<label>Member since</label><fmt:formatDate value="${user.created_at }" dateStyle="short"/><br>
					<label>Number of books loaned</label>${fn:length(books)}<br>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<h3 style="text-align:center;">Books loaned by this user</h3>
					<div class="contents">
						<table class="table table-hover" id="admins-table">
									<thead>
										<tr>
											<th>Image</th>
											<th>Author</th>
											<th>Title</th>
											<th>No. of copies</th>
											<th>Return date</th>
											<th></th>
										</tr>
									</thead>
									<tbody id="contents">
										<c:forEach var="book" items="${books}">
											<tr>
												<td><img src="../library/retrieveImage?id=${book.id}" height=45 width=45></td>
												<td>
												
												<c:forEach var="author" items="${book.authors}">
													<c:out value="${author.name}"/>
												</c:forEach>
												
												</td>
												<td><c:out value="${book.title}"/></td>
												<td><c:out value="${book.no_copies}"/></td>
												<td><fmt:formatDate value="${book.userReturnDate}" dateStyle="short"/></td>
												<td><a href="../library/showBookDetails?book-id=${book.id}">Details</a></td>
											</tr>
										</c:forEach>
									</tbody>
						</table>
					</div>
					<div class="col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3 col-xs-6 col-xs-offset-3">
							<div class="btn-container">
								<button class="btn btn-primary btn-lg btn-block responsive-width" data-toggle="modal" data-target="#exampleModal" 
							data-recipient="${user.userName}">Send a private message to ${user.name}</button>
							</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script lang="javascript">
	$('#exampleModal').on('show.bs.modal', function(event){
		var btn = $(event.relatedTarget);
		var recipient = btn.data('recipient');
		var modal = $(this);
		modal.find('input#recipient').val(recipient);
	})
</script>
</html>







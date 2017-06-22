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
		  
<style>
	.error{
		color:red;
     }
</style>
</head>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<body style="background-color: #e8eae9 !important;">
	<%@include file="header-admin-sep.jsp" %>
	<div class="wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<h2 style="text-align:center;">Create a new book</h2>
						<div class="col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3 col-xs-12">
							<form method="POST" action="createBook" enctype="multipart/form-data" id="theForm">
								<div class="form-group">
									<label for="title">Title</label>
									<input type="text" class="form-control" name="title" placeholder="Book title" id="title">
								</div>
								<div class="form-group">
									<label for="title">Description</label>
									<textarea  class="form-control" name="description" placeholder="Book description" id="description"></textarea>
								</div>
								<div class="form-group">
									<label for="title">Author(s)</label>
									<input type="text" class="form-control" name="author" 
									placeholder="In case of more than one author, please specify them separated by comma" id="authors">
								</div>
								<div class="form-group">
									<label for="title">Number of available copies</label>
									<input type="text" class="form-control" name="copies" placeholder="Number of copies" id="copies">
								</div>
								<div class="form-group">
									<label for="title">Image</label>
									<input type="file" class="form-control" name="image" id="image">
								</div>
								<button type="submit" class="btn btn-default btn-lg btn-block">Save</button>
							</form>
						</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script lang="text/javascript">
	$( "#theForm" ).validate({
		rules: {
	    	title : 'required',
	    	description : 'required',
	    	author : 'required',
	    	copies : 'required',
	    	image : 'required',
		} //if i18n is required, add custom messages
	});
</script>
</html>
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
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.css" />
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/myaccount.css" />
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<link type="text/css"
		  rel="stylesheet"
		  href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
</head>
<body style="background-color: #e8eae9 !important;overflow-x:hidden;">
<!-- Update profile pic modal -->
<div class="modal fade" id="pictureFormModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Upload profile picture</h4>
      </div>
      <form method="POST" action="../uploadPicture" enctype="multipart/form-data" id="pictureForm">
      	<input type="hidden" value="${currentUser.userName }" name="username">
      	<div class="modal-body">
       		<label>Upload picture</label><br>
       		<input type="file" name="image" id="image">
      	</div>
      	<div class="modal-footer">
        	<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        	<button type="submit" class="btn btn-primary">Upload</button>
      	</div>
      </form>
    </div>
  </div>
</div>
<!--  contents -->
<%@include file="header-lib-sep.jsp" %>
<div class="wrapper">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="col-lg-4 col-md-4 col-sm-10 col-xs-10">
					<div class="profile-pic">
						<c:if test="${currentUser.image!=null}">
							<img src="../retrieveProfilePic?userId=${currentUser.id}" height=400 width=320>
						</c:if>
						<c:if test="${currentUser.image==null}">
							<h4>No image available,</h4>
							<h4>upload one !</h4>
						</c:if>
					</div>
					<div class="picture-upload-link">
						<label><a href="#" data-toggle="modal" data-target="#pictureFormModal">Upload a profile picture</a></label><i class="fa fa-file-image-o" aria-hidden="true"></i><br>
					</div>
					<div class="upload-status-message">
						<c:if test="${pictureUploaded!=null}">
						<font color="green">
							<label><c:out value="${pictureUploaded}"/></label>
						</font>
					</c:if>
					<c:if test="${profileEditedSuccess!=null}">
						<i class="fa fa-check-circle-o fa-2x" aria-hidden="true"></i>
						<font color="green" size="3pt">
							<label><c:out value="${profileEditedSuccess}"/></label>
						</font>
					</c:if>
					</div>
				</div>
				<div class="col-lg-4 col-md-4 col-sm-10 col-xs-10">
					<h2>My profile</h2>
						<label>Name: </label>${currentUser.name}<br>
						<label>Last name:</label> ${currentUser.lastName}<br>
						<label>Username:</label> ${currentUser.userName}<br>
						<label>Email:</label> ${currentUser.email}<br>
						<label>Member since:</label> <fmt:formatDate type="date" value="${currentUser.created_at}" dateStyle="long"/><br>
						<label><a href="../editProfile?userName=${currentUser.userName}">Edit profile</a><i class="fa fa-pencil" aria-hidden="true"></i></label>
						<sec:authorize access="hasRole('ADMIN')">
							<br><span class="label label-info">You are admin</span>
						</sec:authorize>
				</div>
			</div>
		</div>
	</div>
</div>
<script lang="javascript">

$( "#pictureForm" ).validate({
	rules: {
    	image : 'required'
	},
    messages: {
    	image : 'Upload a file!'
    }
});

</script>
</body>
</html>
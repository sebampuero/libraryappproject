<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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
		  href="${pageContext.request.contextPath}/resources/css/privatemessages-styles.css" />
<link type="text/css"
		  rel="stylesheet"
		  href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #e8eae9 !important; overflow-x:hidden;">
<%@include file="header-user-sep.jsp" %>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Message subject</h4>
      </div>
      <div class="modal-body">
      	<label>Message: </label>
        <p id="message-body"></p>
        <label>Sender username: </label>
        <p id="sender-username"></p>
      </div>
      <div class="modal-footer">
        <button  id="delete-btn" type="button" class="btn btn-danger">Delete</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="replybtn">Reply</button>
      </div>
    </div>
  </div>
</div>
<!-- CONTENTS -->
<div class="wrapper">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2 col-xs-8 col-xs-offset-2">
			<h3>Private messages</h3>
			<c:if test="${messageSuccess!=null}">
				<font color="green"><i class="fa fa-check" aria-hidden="true"></i>${messageSuccess}</font>
			</c:if>
			<div class="compose-btn"><a href="composeMessage"><button class="btn btn-primary"><span class="btn-text">Compose</span><i class="fa fa-pencil" aria-hidden="true"></i></button></a></div>
				<div class="container">
				<!-- Each message should be a row -->
					<c:forEach var="message" items="${messages }">
						<div class="row">
							<div class="message-card" data-toggle="modal" data-target="#myModal" data-subject="${message.subject}" 
											data-content="${message.content}" data-id="${message.id}" data-senderusername="${message.sender.userName }">
								<div class="col-md-2 col-sm-3 col-xs-3">
									<c:if test="${message.sender.role=='ROLE_ADMIN'}">
										<span class="label label-info">Admin</span>
									</c:if>
									<font size="1pt"><label><c:out value="${message.sender.name }"/></label></font><br>
									<c:if test="${message.sender.image!=null}">
										<img src="retrieveProfilePic?userId=${message.sender.id}" height=30 width=28>
									</c:if>
								</div>
								<div class="col-md-8 col-sm-6 col-xs-6">
									<label><c:out value="${message.subject}"/></label>
								</div>
								<div class="col-md-2 col-sm-3 col-xs-3">
									<div class="send-date"><span id="date-text"><fmt:formatDate value="${message.created_at}" pattern="dd-MM-yyyy HH:MM"/></span></div>
									<div class="see-message" id="open-message">
										<c:if test="${message.is_read==1}">
											<i class="fa fa-eye" aria-hidden="true"></i>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<c:if test="${fn:length(messages)==0}">
					You have no messages!
				</c:if>
			</div>
		</div>
	</div>
</div>
<script lang="javascript">
	$('#myModal').on('show.bs.modal',function(event){
		var card = $(event.relatedTarget);
		var subject = card.data('subject');
		var content = card.data('content');
		var senderUsername = card.data('senderusername');
		var id = card.data('id');
		var modal = $(this);
		modal.find('.modal-title').text('Subject: ' + subject);
		modal.find('p#message-body').text(content);
		modal.find('p#sender-username').text(senderUsername);
		modal.find('button#delete-btn').attr('data-id',id);
 		$.ajax({
			type: 'GET',
			url : '${home}readMessage',
			data : {msgId : id}
		}); 
	});
	$('button#delete-btn').on('click',function(e){
		var messageId = $(this).data('id');
		if(!confirm('Are you sure you want to delete this message?'))
			return false;
		else{
			$.get('${home}deleteMsg',{msgId : messageId},function(callback){
				alert(callback);
				setTimeout(function(){
					location.replace('${home}showPMs');
				},500);
			});
		}
	});
	$('button#replybtn').on('click',function(){
		//fix
		var modal = $('#myModal');
		var messageToReply = modal.find('p#message-body').text();
		var subject = modal.find('#myModalLabel').text();
		var senderUsername = modal.find('#sender-username').text();
		location.href="composeMessage?reply="+messageToReply+"&sender="+senderUsername+"&subject="+subject;
	});
</script>
</body>
</html>
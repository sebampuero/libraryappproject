<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE>
<html>
<head>
<title>
	Send message
</title>
<meta  name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, maximum-scale=1.0, minimum-scale=1.0, shrink-to-fit=no"/>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.css" />
<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/message-composal-style.css" />
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/typeahead.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<link type="text/css"
		  rel="stylesheet"
		  href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
</head>
<body style="background-color: #e8eae9 !important;overflow-x:hidden;">
<%@include file="header-user-sep.jsp" %>
<div class="wrapper">
	<div class="container-fluid">
		<div class="row">
		<!-- How to center a grid in Bootstrap: centered div = (12 - size of div)/2 -->
			<div class="col-lg-8 col-lg-offset-2 col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2 col-xs-8 col-xs-offset-2">
				<h3 style="text-align:center;">Compose message</h3>
					<form method="POST" action="composeMessage" id="theForm">
						<div class="from-group">
							<label>Subject</label>
							<input type="text" class="form-control" name="subject" placeholder="Enter a subject" value="${subject}">
						</div>
						<div class="from-group">
							<label>Body</label>
							<textarea rows=6 class="form-control" name="content" id="content"><c:if test="${replyMessage!=null}"><c:out value="${replyMessage}"/>__Response:</c:if></textarea>
						</div>
						<div class="from-group">
							<label>Send to</label>
							<input type="text" class="form-control" id="typeahead" name="to" placeholder="Search by username" value="${senderUsername}">
						</div><br>
						<button type="submit" class="btn btn-primary btn-block">Send message</button>
					</form>
			</div>
		</div>
	</div>
</div>
<script lang="text/javascript">

var usernames = new Bloodhound({
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('userName'),
    remote: {
        url: 'retrieveUsers?query=%QUERY',
        wildcard: '%QUERY'
    }
});
//Select the Bloodhound object and display the data
$('input#typeahead').typeahead(null,{
    name: 'usernames',
    display: 'userName',
    source: usernames
});
$( "#theForm" ).validate({
	rules: {
    	content : 'required',
    	to : 'required'
	},
    messages: {
    	content : 'You have to provide a message!',
    	to : 'You need to declare who to send this message to'
    }
});
</script>
</body>
</html>
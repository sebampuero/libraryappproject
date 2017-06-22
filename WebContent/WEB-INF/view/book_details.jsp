<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="java.util.Date" %>
<c:set var="now" value="<%=new Date() %>"/>

<!DOCTYPE>
<html>
<head>
<title>
	${book.title}
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
		  href="${pageContext.request.contextPath}/resources/css/book_details.css" />
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #e8eae9 !important;overflow-x:hidden;">
<!-- Loan modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <form action="loanBook" method="POST" enctype="multipart/form-data">
      	<input type="hidden" value="${book.id}" name="bookId">
      	<div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Confirm book loan</h4>
      </div>
      <div class="modal-body">
        <h4>${book.title}</h4>	
        <table>
        	<tr>
        		<td><label>Date of loan*</label></td>
        		<td><input name="loan_date" type="date" class="form-control" id="loan_date" min="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>" required></td>
        	</tr>
        	<tr>
        		<td><label>Approximate date of return:</label></td>
        		<td><input type="text" class="form-control" name="return_date" id="calc_return_date" readonly></td>
        	</tr>
        </table>
      </div>
      <small>(*)This is the date when you can pick up the book</small>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Loan</button>
      </div>
      </form>
    </div>
  </div>
</div>
<!-- Review modal -->
<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      	 <form method="POST" action="saveBookReview">
      	<input type="hidden" value="${book.id}" name="book-id">
      	<div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Send a review for ${book.title }</h4>
      </div>
      <div class="modal-body">
      	<label>Leave a rank for this book</label>
       <label class="radio-inline">
  			<input type="radio" name="radioOption" id="inlineRadio1" value="1"> 1
		</label>
		<label class="radio-inline">
  			<input type="radio" name="radioOption" id="inlineRadio2" value="2"> 2
		</label>
		<label class="radio-inline">
  			<input type="radio" name="radioOption" id="inlineRadio3" value="3"> 3
		</label>
		<label class="radio-inline">
  			<input type="radio" name="radioOption" id="inlineRadio4" value="4"> 4
		</label>
		<label class="radio-inline">
  			<input type="radio" name="radioOption" id="inlineRadio5" value="5"> 5
		</label>
        <br><label>Write a review</label>
        <div class="form-group">
        	<textarea rows="3" class="form-control" name="review"></textarea>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Send</button>
      </div>
      </form>
    </div>
  </div>
</div>
<!-- Contents -->
<%@include file="header-lib-sep.jsp" %>
<div class="wrapper">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">
				<div class="book-container">
					<h2>Title</h2>
					<h3><c:out value="${book.title}"/></h3>
					<h2>Description</h2>
					<h3><c:out value="${book.description}"/></h3>
					<h2>Author(s)</h2>
					<h3>
					
					<c:forEach var="author" items="${book.authors}">
						<c:out value="${author.name}"/>
					</c:forEach>
					
					</h3>
					<h2>Average ranking given by users</h2>
					<h3>
					
					<c:if test="${rankingAvg!='NaN'}">
						<c:out value="${rankingAvg}"/> out of 5
					</c:if>
					<c:if test="${rankingAvg=='NaN'}">
						No ranking yet
					</c:if>
					
					</h3>
					<div class="image">
						<img src="retrieveImage?id=${book.id}" height=240 width=160><br>
						<font color="red"><label id="no_more_copies_msg"></label></font><br>
						<button type="button" class="btn btn-default loan" data-toggle="modal" data-target="#myModal" id="loan_book_button">Loan Book</button>
						<sec:authorize access="hasRole('ADMIN')">
							<button type="button" class="btn btn-default loan">Edit</button>
						</sec:authorize>
						<button type="button" class="btn btn-default loan" data-toggle="modal" data-target="#reviewModal" id="review_btn">Add a review</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<script lang="text/javascript">
	$(document).ready(function(){
		var bookNumberOfCopies = ${book.no_copies};
		if(bookNumberOfCopies === 0){
			$('#loan_book_button').addClass('disabled').attr('disabled',true);
			$('label#no_more_copies_msg').text('This book has no more copies!');
		}
	});
	//cache the dom elements
	var loanDateInput = $('input#loan_date');
	var calcReturnDateInput = $('input#calc_return_date');
	//on change for the date input because the return date is calculated according to the loan date
	loanDateInput.on('input propertychange',function(){
		var loanDate = $(this).val();
		var returnDate = forwardDateByOneMonth(new Date(loanDate));
		calcReturnDateInput.val(returnDate);
	});
	//receive a date as parameter and calculate the date one month forward
	//return the date in this pattern: dd.MM.yyy
	function forwardDateByOneMonth(date){
		var inOneMonth = new Date(date.getTime() + 1000*24*60*60*30);
		var day = inOneMonth.getDate();
		var month = inOneMonth.getMonth()+1;
		var year = inOneMonth.getFullYear();
		return day + '.' + '0' + month + '.' + year;
	}
</script>
</html>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="thisUser" property="principal"/>
<div class="navbar navbar-default navbar-static-top">
        <div class="container-fluid">
            <div class="navbar-brand">Administrators page, welcome ${thisUser.username }</div>
            <button class="navbar-toggle" data-toggle="collapse" data-target=".navHeaderCollapse">
                <span class="icon-bar"></span>                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="collapse navbar-collapse navHeaderCollapse">
                <ul class="nav navbar-nav navbar-right">
                	<li><a href="../library/myBooks" >My Books</a> </li>
                    <li><a href="../library/showBooks" >Books</a> </li>
                    <li><a href="../library/myAccount" >My Account</a> </li>
                    <li><a href="showUsers" >Users control page</a> </li>
                    <li><a href="adminsControlPage" >Administrators control page</a> </li>
                    <li><a href="../showPMs"><span id="messages"></span></a></li>
                    <li><a href="../logout">Logout</a></li>
                </ul>
            </div>
        </div>
	</div>
<script lang="javascript">
	$(document).ready(function(){
		$.get( "${home}../unread-msg-num", 
				{username : '${thisUser.username}'},
				function( numOfMessages ) {
			  		$('span#messages').append('Private messages <span class="label label-info">'+numOfMessages+'</span>');
			});
	});
</script>
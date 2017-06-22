<sec:authentication var="thisUser" property="principal"/>
<div class="navbar navbar-default navbar-static-top">
        <div class="container-fluid">
            <div class="navbar-brand">Welcome ${thisUser.username}</div>
            <button class="navbar-toggle" data-toggle="collapse" data-target=".navHeaderCollapse">
                <span class="icon-bar"></span><span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="collapse navbar-collapse navHeaderCollapse">
                <ul class="nav navbar-nav navbar-right">
                	<sec:authorize access="hasRole('ADMIN')">
						<li><a href="admin/adminsControlPage">Go to admin control page</a></li>
				    </sec:authorize>
                    <li><a href="library/myBooks" >My Books</a> </li>
                    <li><a href="library/showBooks" >Books</a> </li>
                    <li><a href="library/myAccount" >My Account</a> </li>
                    <li><a href="showPMs"><span id="messages"></span></a></li>
                    <li><a href="logout">Logout</a></li>
                </ul>
            </div>
        </div>
</div>
<script lang="javascript">
	$(document).ready(function(){
		$.get( "${home}unread-msg-num", 
				function( numOfMessages ) {
			  		$('span#messages').append('Private messages <span class="label label-info">'+numOfMessages+'</span>');
			});
	});
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %> <!-- add -->
<%@ include file="../include/login_check1.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유로운 커뮤니티 Board's</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.css">

<script type="text/javascript">

$(function(){
	$("#btnSave").click(function(){
		document.form1.submit();
	});
});

</script>
</head>
<body>
<nav class="navbar navbar-inverse">
	<div class="container-fluid">
   		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        		<span class="icon-bar"></span>
        		<span class="icon-bar"></span>
        		<span class="icon-bar"></span>                        
      		</button>
			<%if(userid==null){ %>
				<a class="navbar-brand" href="<%=context %>/web_servlet/index.do">Board's</a>
			<%}else { %>
				<a class="navbar-brand" href="<%=context %>/web_servlet/main.do">Board's</a>
			<%} %>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav">
				<li><a href="<%=context %>/board_servlet/list.do">게시판</a></li>
				<li><a href="<%=context %>/board0_servlet/list.do">게시판0</a></li>
				<li><a href="<%=context %>/board1_servlet/list.do">게시판1</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
	        	<%if(userid==null){ %>
	        	<li><a href="<%=context %>/web_servlet/signIn.do">
	        	<span class="glyphicon glyphicon-log-in"></span> Login</a></li>
				<%}else {%>
				<li><a id="userid"><%=userid %> 접속중</a></li>
				<li><a href="<%=context %>/web_servlet/edit.do">개인정보 수정</a></li>
				<li><a href="<%=context %>/web_servlet/logOut.do">로그아웃</a></li>
			<%} %>
      		</ul>
		</div>
	</div>
</nav>
	
<div class="container-fluid text-center">    
	<section class="section">
		<div class="col-sm-2 sidenav">
			<h4>category 1</h4>
				<p><a href="<%=context %>/board_servlet/list.do">게시판</a></p>
				<p><a href="<%=context %>/board0_servlet/list.do">게시판0</a></p>
				<p><a href="<%=context %>/board1_servlet/list.do">게시판1</a></p>
			<hr>
			<h4>category 2</h4>
				<p><a href="<%=context %>/board2_servlet/list.do">게시판2</a></p>
				<p><a href="<%=context %>/board3_servlet/list.do">게시판3</a></p>
				<p><a href="<%=context %>/board4_servlet/list.do">게시판4</a></p>
		</div>

		<div class="col-sm-8 text-left"> 
			<div class="article-content">
					<h3>Board Content</h3>
					<h2>답변쓰기</h2>
					<form name="form1" method="post" action="${path}/board_servlet/insertReply.do">
					<table border="1" width="100%">
						<tr>
					    	<td>이름</td>
					    	<td><input name="writer" id="writer"></td>
						</tr>
					  	<tr>
						    <td>제목</td>
					    	<td><input name="subject" id="subject" value="Re: ${dto.subject}" size="60"></td>
					  	</tr>
					  	<tr>
						    <td>본문</td>
					    	<td><textarea rows="5" cols="60" name="content" id="content">${dto.content}</textarea></td>
					  	</tr>
					  	<tr>
						    <td>첨부파일</td>
					    	<td><input type="file" name="file1"></td>
					  	</tr>
					  	<tr>
						    <td>비밀번호</td>
					    	<td><input type="password" name="passwd" id="passwd"></td>
					  	</tr>
					  	<tr>
						    <td colspan="2" align="center">
					    		<!-- 게시물 번호 -->
					    	  	<input type="hidden" name="num" value="${dto.num}">
					      		<input type="button" value="확인" id="btnSave">
					    	</td>
					  	</tr>
					</table>
					</form>
			</div>
		</div>
		
		<div class="col-sm-2 sidenav">
      		<div class="well">
        		<p>광고1</p>
      		</div>
      		<div class="well">
        		<p>광고2</p>
      		</div>
    	</div>
	</section>
</div>
	
<footer class="container-fluid text-center">
	<p>Footer Text</p>
</footer>
</body>
</html>
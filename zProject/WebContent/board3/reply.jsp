<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %> <!-- add -->
<%@ include file="../include/login_check1.jsp" %>
<%@ include file="../include/login_check2.jsp" %>
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
<%
int num=(int)request.getAttribute("num");
String subject=(String)request.getAttribute("subject");
String content=(String)request.getAttribute("content");
%>
<script type="text/javascript">

$(function(){
	$("#btnSave").click(function(){
		
		if(document.getElementById("subject").value==''){
			alert("제목을 입력해주세요.");
			document.getElementById('subject').focus();
			exit;
		}if(document.getElementById("content").value==''){
			alert("내용을 입력해주세요.");
			document.getElementById('content').focus();
			exit;
		}
		document.form1.submit();
	});
	
	$("#btnEdit").click(function() {
		document.form1.action="${path}/board3_servlet/update.do";
		document.form1.submit();
	});
	
	$("#btnDelete").click(function() {
		var result=confirm("정말로 게시물을 삭제하시겠습니까?\n삭제된 게시물은 복구할 수 없습니다.");
		if(result){
			document.form1.action="${path}/board3_servlet/delete.do";
			document.form1.submit();
			alert("게시물이 정상적으로 삭제되었습니다.");
		}else {
			exit;
		}
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
			<h3>Board3 Content</h3>
					<h2>수정 및 삭제</h2>
					<form name="form1" method="post">
						<table border="1" width="100%">
						  <tr>
						    <td>작성자</td>
						    <td>
						    	<input type="hidden" id="num" name="num" value="<%=num %>">
						    	<input name="writer" id="writer" value="<%=userid %>" readonly>
						    </td>
						  </tr>
						  <tr>
						    <td>제목</td>
						    <td><input name="subject" id="subject" size="60" placeholder="" value="<%=subject %>"></td>
						  </tr>
						  <tr>
						    <td>본문</td>
						    <td><textarea style="width: 100%" rows="5" cols="60" name="content" id="content"><%=content %></textarea></td>
						  </tr>
						  <tr>
						    <td colspan="2" align="center">
						    	<input type="button" value="수정" id="btnEdit">
						    	<input type="button" value="삭제" id="btnDelete">
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
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
<%
String writer=(String)request.getAttribute("writer");
%>
<script type="text/javascript">
$(function() {
	comment_list();
	
	$("#btnList").click(function() {
		location.href="${path}/board0_servlet/list.do";
	});
	
	$("#edit").click(function() {
		if(document.getElementById('writer1').value!=document.getElementById('userid').value){
			alert('권한이 없습니다.');
			exit;
		}
		var form1=document.getElementById('form1');		
		form1.submit();
	});
	
	$("#btnReply").click(function(){
		document.form1.action="${path}/board0_servlet/reply.do";
		document.form1.submit();
	});
	
	$("#btnWrite").click(function(){
		location.href="${path}/board0/write.jsp";
	});
	
	$("#up").click(function() {
		var result=confirm("해당 게시물을 추천하시겠습니까?\n(추천 후 목록페이지로 이동합니다.)");
		if(result){
			var form2=document.getElementById('form2');		
			form2.submit();
		}else {
			exit;
		}
	});
	
	$("#btnSave").click(function(){
		if(document.getElementById('content').value==""){
			alert("댓글을 입력해주세요.");
			document.getElementById('content').focus();			
			exit();
		}
		
		comment_add();
	});
	
});

function comment_add(){
	var param="board_num=${dto.num}&writer="+$("#writer").val()
	+"&content="+$("#content").val();
	$.ajax({
		type: "post",
		url: "${path}/board0_servlet/comment_add.do",
		data: param,
		success: function(){
			$("#writer").val("");
			$("#content").val("");
			comment_list();
		}
	});
}
function comment_list(){
	$.ajax({
		type: "post",
		url: "${path}/board0_servlet/commentList.do",
		data: "num=${dto.num}",
		success: function(result){
			$("#commentList").html(result);
		}
	});
}

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
			<h1>Board0 Content</h1>
					<h2>${dto.subject}</h2>
					<table border="1" width="100%;">
						<tr style="border-bottom: 1px solid">
							<td>${dto.writer}</td>
							<td>조회 : ${dto.readcount}</td>
							<td>추천 : ${dto.up}</td>
							<td>${dto.reg_date}</td>
						</tr>
						<tr>
							<td colspan="4">
								<div style="width: 100%; min-height: 400px;">
									${dto.content}
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<form style="display: inline">
								<input type="hidden" name="num" value="${dto.num}">
								<input type="hidden" name="subject" value="${dto.subject}">
								<input type="button" value="답변" id="btnReply">
								</form>
								
								<input type="button" value="글쓰기" id="btnWrite">
				      			<input type="button" value="목록" id="btnList">
				      			<input type="button" value="이전" onclick="history.back()">
			      				
			      				<form style="display: inline;" method="post" action="<%=context %>/board0_servlet/edit.do" id="form1" name="form1">
									<input type="hidden" name="num" value="${dto.num}">
									<input type="hidden" name="subject" value="${dto.subject}">
									<input type="hidden" name="content" value="${dto.content}">
									<input type="hidden" id="writer1" name="writer" value="${dto.writer }">
									<input type="hidden" id="userid" name="userid" value="<%=userid %>">
				      				<button type="button" id="edit" name="edit">수정/삭제</button>
								</form>
								
								<form style="display: inline;" method="post" action="<%=context %>/board0_servlet/up.do" id="form2" name="form2">
									<input type="hidden" name="num" value="${dto.num}">
									<button type="button" id="up" name="up">추천</button>
								</form>
							</td>
						</tr>
					</table>
					<%-- <h4>댓글(${dto.comment_count})</h4> --%>
					<h4>댓글</h4>
					<div style="background-color: #e1e1e1; width: 100%; height: auto">
					
					<!-- 댓글 목록을 출력할 영역 -->
					<div id="commentList"></div>
					
					<!-- 댓글 쓰기 폼 -->
					<table>
				  		<tr>
				    		<td><input type="hidden" id="writer" value="<%=userid %>"></td>
				  		</tr>
				  		<tr>
				    		<td><textarea rows="5" cols="100" placeholder="내용을 입력하세요" id="content"></textarea></td>
				    		<td><button id="btnSave" type="button">등록</button></td>
						</tr>
					</table>
					</div>
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
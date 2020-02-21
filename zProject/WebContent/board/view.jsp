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
	comment_list();
	$("#btnSave").click(function(){
		if(document.getElementById('content').value==""){
			alert("댓글을 입력해주세요.");
			document.getElementById('content').focus();			
			exit();
		}
		
		comment_add();
	});
	$("#btnList").click(function(){
		location.href="${path}/board_servlet/menu3.do";
	});
	$("#btnReply").click(function(){
		document.form1.action="${path}/board_servlet/reply.do";
		document.form1.submit();
	});
	$("#btnEdit").click(function(){
		document.form1.action="${path}/board_servlet/pass_check.do";
		document.form1.submit();
	});
});

function comment_add(){
	var param="board_num=${dto.num}&writer="+$("#writer").val()
	+"&content="+$("#content").val();
	$.ajax({
		type: "post",
		url: "${path}/board_servlet/comment_add.do",
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
		url: "${path}/board_servlet/commentList.do",
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
			<h3>Board Content</h3>
					<h2>상세화면</h2>
					<form name="form1" method="post">
					<table class="table">
				  		<tr>
						    <td>날짜</td>
						    <td>${dto.reg_date}</td>
						    <td>조회수</td>
						    <td>${dto.readcount}</td>
				  		</tr>
				  		<tr>
						    <td>이름</td>
						    <td colspan="3">${dto.writer}</td>
				  		</tr>
						<tr>
							<td>제목</td>
						    <td colspan="3">${dto.subject}</td>
						</tr>
				  		<tr>
				    		<td>본문</td>
				    		<td colspan="3"><textarea rows="10" cols="60" style="width: 100%">${dto.content}</textarea></td>
				  		</tr>
				  		<tr>
				    		<td>비밀번호</td>
				    		<td colspan="3">
				      			<input type="password" name="passwd" id="passwd">
				        		<c:if test="${param.message == 'error'}">
				          			<span style="color: red">비밀번호가 일치하지 않습니다.</span>
				        		</c:if>
				    		</td>
				  		</tr>	
				  		<tr>
							<td>첨부파일</td>
						    <td colspan="3">
							    <c:if test="${dto.filesize > 0}">
							    ${dto.filename}( ${dto.filesize} bytes )
							    <a href="${path}/board_servlet/download.do?num=${dto.num}">
							    [다운로드]</a>
							    </c:if>
						    </td>
				  		</tr>
				  		<tr>
				    		<td colspan="4" align="center">
				      			<input type="hidden" name="num" value="${dto.num}">
				      			<input type="button" value="수정/삭제" id="btnEdit">
				      			<input type="button" value="답변" id="btnReply">
				      			<input type="button" value="목록" id="btnList">
							</td>  
						</tr>
					</table>
					</form>
					<h4>댓글</h4>
					<div id="commentList" style="width: 100%"></div>
					<!-- 댓글 쓰기 폼 -->
					<table class="table">
				  		<tr>
				    		<td><input type="hidden" id="writer" value="<%=userid %>"></td>
				    		<td><textarea style="width: 100%;" rows="5" cols="80" placeholder="내용을 입력하세요" id="content"></textarea></td>
				    		<td rowspan="2"><button id="btnSave" type="button">확인</button></td>
				  		</tr>
					</table>
					<br>
					<!-- 댓글 목록을 출력할 영역 -->
					
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
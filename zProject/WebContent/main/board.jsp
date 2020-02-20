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
	$("#btnWrite").click(function(){
		location.href="${path}/board/write.jsp";
	});
});
// 클릭한 페이지로 이동
function list(page) {
	location.href="${path}/board_servlet/menu3.do?curPage="+page;
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
					<h2>게시판</h2>
					<div style="display: inline; float: right;">
						<form action="${path}/board_servlet/search.do" method="post" name="form1">
							<select name="search_option">
								<option value="writer">이름</option>
								<option value="subject">제목</option>
								<option value="content">내용</option>
								<option value="all">이름+제목+내용</option>
							</select>
							<input name="keyword">
							<button id="btnSearch">검색</button>
							<!-- button 태그는 기본값이 type="submit"이다.
							type="button"하면 js를 써야한다. -->
						</form>
					</div>
					<button id="btnWrite">글쓰기</button>
					<!-- 게시판 영역 -->
					<table class="table">
							<tr>
						    	<th style="width: 10%; text-align: center">번호</th>
						    	<th style="width: 40%;">제목</th>
						    	<th style="width: 10%; text-align: center">작성자</th>
						    	<th style="width: 15%; text-align: center">작성일자</th>
						    	<th style="text-align: center">조회수</th>
						    	<th style="text-align: center">첨부파일</th>
						    	<th style="text-align: center">다운로드</th>
							</tr>
						 	<c:forEach var="dto" items="${list}">
						 	<c:choose>
						    <c:when test="${dto.show == 'y'}">
						  	<tr>
								<td style="text-align: center; font-size: 12px;">${dto.num}</td>
						    	<td style="font-weight: bold">
					       			<c:forEach var="i" begin="1" end="${dto.re_level}">
					       			&nbsp;&nbsp;
						   			</c:forEach>
						   			<a href="${path}/board_servlet/view.do?num=${dto.num}">${dto.subject}</a>
						   			<!-- 댓글갯수 표시 -->
									<c:if test="${dto.comment_count > 0}">
						   			<span style="color: red;">(${dto.comment_count})</span>
						   			</c:if>
						   		</td>
						  		<td style="text-align: center; font-size: 12px;">${dto.writer}</td>
						   		<td style="text-align: center; font-size: 12px;">${dto.reg_date}</td>
						   		<td style="text-align: center; font-size: 12px;">${dto.readcount}</td>
						   		<td style="text-align: center; font-size: 12px;">
						   		<c:if test="${dto.filesize > 0}">
						   			<a href="${path}/board_servlet/download.do?num=${dto.num}"><img src="../images/file.gif"></a> 
						   		</c:if>
						   		</td>
						   		<td id="reload" style="text-align: center; font-size: 12px;">${dto.down}</td>
						  	</tr>
						  	</c:when>
						  	
						  	<c:otherwise>
						    <tr>
						      	<td style="text-align: center; font-size: 12px;">${dto.num}</td>
						      	<td colspan="6" align="center">삭제된 게시물입니다.</td>
						    </tr>
						  	</c:otherwise>
						  	</c:choose>
						 	</c:forEach> 
						 <!-- 페이지 네비게이션 출력 -->
						 <tr>
						 	<td colspan="7" align="center">
						 		<c:if test="${page.curBlock > 1}"><a href="#" onclick="list('1')">[처음]</a></c:if>
						 		<c:if test="${page.curBlock > 1}"><a href="#" onclick="list('${page.prevPage}')">[이전]</a></c:if>
						 		<c:forEach var="num" begin="${page.blockStart}" end="${page.blockEnd}">
						 			<c:choose >
						 				<c:when test="${num == page.curPage}">
						 					<span style="color: red">${num}</span>
						 				</c:when>
						 				<c:otherwise>
						 					<a href="#" onclick="list('${num}')">${num}</a>
						 				</c:otherwise>
						 			</c:choose>
						 		</c:forEach>
						 		<c:if test="${page.curBlock < page.totBlock}">
						 			<a href="#" onclick="list('${page.nextPage}')">[다음]</a>
						 		</c:if>
						 		<c:if test="${page.curBlock < page.totBlock}">
						 			<a href="#" onclick="list('${page.totPage}')">[끝]</a>
						 		</c:if>
						 	</td>
						 </tr> 
					</table>
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
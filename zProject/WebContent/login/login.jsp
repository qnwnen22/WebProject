<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %> <!-- add -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유로운 커뮤니티 Board's</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../css/login.css">
<%
request.setCharacterEncoding("utf-8");
String context = request.getContextPath();
String message = request.getParameter("message");
%>

</head>
<body>
<div class="container">
	<header class="header">
		<a href="<%=context %>/web_servlet/index.do"><img src="../images/logo.png"></a>
	</header>
	
	<div class="content">
		<section class="section">
			<article class="article">
				<div class="article-content">
					<h2>로그인</h2>
					<hr>
					<form action="<%=context %>/web_servlet/login.do" method="post">
					아이디<br>
					<input name="userid" id="id"><br>
					<%if(message != null){ %>
					<a style="color: red"><%=message %></a><br>
					<%} %>
					<br>
					비밀번호<br>
					<input name="userpw" type="password" id="passwd"><br><br>
					<input class="login" id="login" type="submit" value="로그인"><br><br>
					</form>
					<hr>
					<ul>
						<li><a href="signUp.jsp">회원가입</a></li>
						<li>|</li>
						<li><a href="find_id.jsp">아이디 찾기</a></li>
						<li>|</li>
						<li><a href="find_pw.jsp">비밀번호 찾기</a></li>
					</ul>
				</div>
			</article>
		</section>
	</div>
	
	<footer class="footer">
		<div class="footerContent">
		<p>Footer Text</p>
		</div>
	</footer>
</div>
</body>
</html>
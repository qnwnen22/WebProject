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
String context = request.getContextPath();
String message = request.getParameter("message");
String userid=(String)request.getAttribute("userid");
String result=(String)request.getAttribute("result");
%>
<link rel="stylesheet" href="../css/login.css">
<script type="text/javascript">
</script>
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
					<h2>비밀번호 변경</h2>
					<hr>
					<%if(userid!=null) {%>
						<form id="form1" action="<%=context %>/web_servlet/find_pw_result.do" method="post">
						아이디<br>
						<input id="userid" name="userid" value="<%=userid %>"><br>
						<br>
						이름<br>
						<input id="username" name="username" required><br><br>
						연락처<br>
						<input id="hp" name="hp" required>
						<br><br>
						<input class="update_pw" type="submit" value="비밀번호 변경"><br><br>
						</form>
					<%}
					else {%>
						<form id="form2" action="<%=context %>/web_servlet/find_pw_result.do" method="post">
						아이디<br>
						<input id="userid" name="userid" placeholder="아이디를 입력하세요." required><br><br>
						이름<br>
						<input id="username" name="username" required><br><br>
						연락처<br>
						<input id="hp" name="hp" required>
						<br><br>
						<input class="update_pw" type="submit" value="비밀번호 변경"><br><br>
						</form>
					<%} %>
					<br>
					<%if(result!=null) {%>
						<a style="color: red"><%=result %></a>
					<%} %>
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
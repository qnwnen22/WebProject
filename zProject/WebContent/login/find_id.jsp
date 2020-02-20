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
					<h2>아이디 찾기</h2>
					<hr>
					<form action="<%=context %>/web_servlet/find_id.do" method="post">
					이름<br>
					<input id="username" name="username" placeholder="이름을 입력하세요." required><br><br>
					email<br>
					<input id="email" name="email" placeholder="이메일을 입력하세요." required><br><br>
					<input class="find_id" type="submit" value="아이디 찾기"><br><br>
					</form>
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
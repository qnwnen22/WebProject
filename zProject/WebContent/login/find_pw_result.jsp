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
String username=(String)request.getAttribute("username");
String hp=(String)request.getAttribute("hp");

%>
<link rel="stylesheet" href="../css/login.css">
<script type="text/javascript">
$(function() {
	$("#btn").click(function() {
		if(document.getElementById('userpw').value==''){
			alert('비밀번호를 입력해주세요.');
			document.getElementById('userpw').focus();
			exit();
		}
		if(document.getElementById('userpw_check').value==''){
			alert('비밀번호를 입력해주세요.');
			document.getElementById('userpw_check').focus();
			exit();
		}
		if(document.getElementById('userpw').value!=document.getElementById('userpw_check').value){
			document.getElementById('userpw').focus();
			document.getElementById('pwC_txt').innerHTML="비밀번호가 일치하지 않습니다.";
			document.getElementById('pwC_txt').style.color="red";
			exit();
		}
		
		var form1=document.getElementById('form1');
		form1.submit();
		alert("비밀번호가 변경되었습니다.")
	});
});
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
					<form id="form1" name="form1" action="<%=context %>/web_servlet/update_pw.do" method="post">
						<input type="hidden" id="userid" name="userid" value="<%=userid %>">
						<input type="hidden" id="username" name="username" value="<%=username %>">
						<input type="hidden" id="hp" name="hp" value="<%=hp %>">
						비밀번호<br>
						<input type="password" id="userpw" name="userpw" placeholder="변경할 비밀번호를 입력하세요." required><br><br>
						비밀번호 확인<br>
						<input type="password" id="userpw_check" name="userpw_check" placeholder="변경할 비밀번호를 입력하세요." required><br>
						<a id="pwC_txt"></a><br>
						<br><br>
						<button type="button" id="btn" name="btn" class="update_pw" style="width: 100%">비밀번호 변경</button><br><br>
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
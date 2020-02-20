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
String result=request.getParameter("result");

String message=(String)request.getAttribute("message");

String userid=(String)request.getAttribute("userid");

String a=(String)request.getAttribute("a");
if(userid==""){
	message="아이디를 입력해주세요.";
}
if(a=="0"){
	userid="";
}
%>
<link rel="stylesheet" href="../css/login.css">
<script type="text/javascript">
$(function() {
	$("#ck").click(function() {
		var	regex_id = new RegExp("[a-zA-z0-9]{6,20}");
		if(!(regex_id.test(document.getElementById('id').value))){
			alert("6~20자의 영문 소문자, 숫자만 사용 가능합니다.");
			document.getElementById('id').value="";
			document.getElementById('userid').value="";
			document.getElementById('id_result').innerHTML="";
			document.getElementById('id').focus();
			exit;
		}
		var form=document.getElementById('form');		
		form.submit();
	});
	
});
$(function() {
	$("#signUp").click(function() {
	var	regex_pwd = new RegExp("[a-zA-z0-9]{6,20}");
	var regex_name = new RegExp("[가-힣]{2,10}");
	var regex_hp = new RegExp("(01)[0-9]{9}");
		if(document.getElementById('userid').value==''){
			/* document.getElementById('id_result').innerHTML="아이디를 입력해주세요."; */
			alert('아이디를 입력 후 중복확인을 해주세요.');
			document.getElementById('id').focus();
			exit;
		}
		if(document.getElementById('userpw').value==''){
			alert("비밀번호를 입력하세요.")
			document.getElementById('userpw').focus();
			exit;
		}else if(!(regex_pwd.test(document.getElementById('userpw').value))){
			alert("6~20자의 영문 소문자, 숫자만 사용 가능합니다.");
			document.getElementById('userpw').focus();
			exit;
		}
		if(document.getElementById('userpw_check').value==''){
			alert("비밀번호확인을 입력하세요.");
			document.getElementById('userpw_check').focus();
			exit;
		}
		if(document.getElementById('userpw').value!=document.getElementById('userpw_check').value){
			alert("비밀번호를 확인해주세요.");
			document.getElementById('pwC_result').innerHTML="비밀번호가 일치하지 않습니다.";
			document.getElementById('pwC_result').style.color="red";
			exit;
		}else{
			document.getElementById('pwC_result').innerHTML="";
		
		}if(document.getElementById('username').value==''){
			alert("이름을 입력하세요.");
			document.getElementById('username').focus();
			exit;
		}else if(!(regex_name.test(document.getElementById('username').value))){
			alert("2~10자의 한글만 사용 가능합니다.");
			document.getElementById('username').focus();
			exit;
		}if(document.getElementById('email').value==''){
			alert("이메일을 입력하세요.");
			document.getElementById('email').focus();
			exit;
		}else if(!(regex_pwd.test(document.getElementById('email').value))){
			alert("6~20자의 영문 소문자, 숫자만 사용 가능합니다.");
			document.getElementById('email').focus();
			exit;
		}if(document.getElementById('select_email').value==''){
			alert("이메일을 선택하세요.")
			document.getElementById('select_email').focus();
			exit;
		}if(document.getElementById('hp').value==''){
			alert("전화번호를 확인하세요.");
			document.getElementById('hp').focus();
			exit;
		}else if(!(regex_hp.test(document.getElementById('hp').value))){
			alert("형식에 맞지않는 번호입니다.\nex) 01#-####-####");
			document.getElementById('hp').focus();
			exit;
		}
		var form1=document.getElementById('form1');		
		form1.submit();
		
	});
});
$(function () {
	document.getElementById('userid').value=document.getElementById('id').value;
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
					<h2>회원가입</h2>
					<hr>
					<form id="form" name="form" method="post" action="<%=context %>/web_servlet/id_check.do">
					아이디<br>
					<input type="text" id="id" name="id" style="width: 73%;"
					
					<%if(userid!=null){ %> value="<%=userid %><%}%>">
					<input type="button" id="ck" name="ck" value="중복확인" style="width: 25%;"><br>
					<%if(message!=null){ %><a id="id_result"<%if(a=="0"){ %>style="color: red"
					<%}else if(a=="1") {%>style="color: blue"<%} %>>
					<%=message %></a><%} %>
					</form>
					<form id="form1" name="form1" method="post" action="<%=context %>/web_servlet/signUp.do">
					<input type="hidden" id=userid name="userid" value="<%=userid %>">
					비밀번호<br>
					<input type="password" id="userpw" name="userpw">
					<a id="pw_result"></a>
					<br><br>
					비밀번호 확인<br>
					<input type="password" id="userpw_check" name="userpw_check"><br>
					<a id="pwC_result"></a>
					<br><br>
					
					이름<br>
					<input type="text" id="username" name="username">
					<a id="name_result"></a>
					<br><br>
					
					이메일<br>
					<input type="email" id="email" name="email" style="width:65%;">@
					<select id="select_email" name="select_email" style="width:28%; height: 30px;">
						<option value="">이메일 선택</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="hanmail.net">hanmail.net</option>
					</select>
					<a id="email_result"></a>
					<br><br>
					
					전화번호<br>
					<input type="text" id="hp" name="hp" placeholder=" '-' 부호를 제외한 전화번호" >
					<a id="hp_result"></a>
					<br><br>
					<button type="button" class="signUp" id="signUp" name="signUp" style="width: 100%;">회원가입</button>
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
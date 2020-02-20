<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="web.dto.WebDTO" %>
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
Map<String,Object> map=(Map<String,Object>)request.getAttribute("map");
List<WebDTO> list=(List<WebDTO>)map.get("list");
int count=(int)map.get("count");

//List<String> list=(List<String>)request.getAttribute("list");

%>
<link rel="stylesheet" href="../css/login.css">
<script type="text/javascript">
$(function() {
	$("#btn").click(function() {
		location.href="<%=context %>/web_servlet/find_pw.do";
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
					<h2>아이디 찾기</h2>
					<hr>
					<form action="<%=context %>/web_servlet/find_pw.do" method="post">
					<table style="width: 100%" class="table">
					<tr>
						<th>선택</th>
						<th>아이디</th>
						<th>가입일자</th>
					</tr>
						<%if(count>0){ %>
							<%for(WebDTO dto : list){ %>
							<tr>
								<td><input style="height: 15px; width: 15px;" type="radio" name="userid" id="userid" value="<%=dto.getUserid() %>"></td>
								<td><%=dto.getUserid() %></td>
								<td><%=dto.getSignUp_date() %></td>
							</tr>
							<%} %>
							<tr>
								<td colspan="3"><input type="submit" class="update_pw" id="btn" name="btn" value="비밀번호 변경"></td>
							</tr>
						<%}else {%>
							<tr>
								<td style="text-align: center" colspan="3"><a style="color: red;">가입된 아이디가 없습니다.</a></td>
							</tr>
							<tr>
								<td colspan="3"><a style="float: right" href="#" onclick="history.back()">뒤로</a></td>
							</tr>
						<%} %>
					</table>
					<hr>
					<ul>
						<li><a href="<%=context %>/web_servlet/login_page.do">로그인</a></li>
						<li>|</li>
						<li><a href="<%=context %>/web_servlet/signUp_page.do">회원가입</a></li>
					</ul>
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
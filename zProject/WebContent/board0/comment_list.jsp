<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script src="../include/jquery-3.4.1.min.js"></script>
</head>
<body>
<table border="1" width="100%">
<c:forEach var="row" items="${list}">
	<tr>
		<td style="width: 100%;">
			<a style="font-size: 18px; font-family: Georgia, '맑은 고딕', serif;">${row.writer}</a>
			<a style="color: gray; font-size: 12px;">( <fmt:formatDate value="${row.reg_date}"
				pattern="yyyy-MM-dd hh:mm:ss" /> )</a><br>
			${row.content}
		</td>
	</tr>
</c:forEach>
</table>
</body>
</html>



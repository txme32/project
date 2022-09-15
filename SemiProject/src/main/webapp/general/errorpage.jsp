<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
</head>
<body>
<%
int status = response.getStatus();

if (status == 404) {
	out.print("Error 404");
	out.print("페이지에 문제가 발생했습니다. 관리자에게 문의하세요");
}
if (status == 405) {
	out.print("Error 405");
	out.print("페이지에 문제가 발생했습니다. 관리자에게 문의하세요.");
}
if (status == 500) {
	out.print("Error 500");
	out.print("페이지에 문제가 발생했습니다. 관리자에게 문의하세요.");
}
%>
</body>
</html>
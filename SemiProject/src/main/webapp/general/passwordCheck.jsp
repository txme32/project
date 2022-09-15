<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
div#title {
	color: white;
	width: 100%;
	height: 50%;
	background-color: gray;
}
</style>
<script type="text/javascript">
$(function() {
	$("#btnCheck").click(function() {
		document.form1.action = "${path}/service_servlet/passwordCheck.do";
		document.form1.submit();
	});
	
	if ($('#result').val() == "성공") {
		window.opener.passok("${num}");
		window.close();
	}
});
</script>
</head>
<body>
<div id="popup">
	<div id="title">
		<h3>비밀번호를 입력하세요.</h3>
	</div>
	<div id="subject">
		<form name="form1" method="post">
			<input type="hidden" name="num" id="num" value="${ param.num }">
			<input type="hidden" name="result" id="result" value="${ result }">
			<input type="password" name="passwd" id="passwd">
			<input type="button" name="btnCheck" id="btnCheck" value="확인">
		</form>
	</div>
</div>
</body>
</html>
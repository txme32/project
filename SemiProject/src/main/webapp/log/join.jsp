<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<c:set var="path" value="${pageContext.request.contextPath}" />
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
  </style>
<style type="text/css">
table {
	margin: 0 auto;
}
table tr {
	height: 50px;
}
table tr td:first-child {
	text-align: right;
}
table tr td:nth-child(3) {
	width: 600px;
}
</style>
<script type="text/javascript">
function idkeyup() {
	var id = document.getElementById("userid");
	var result1 = document.getElementById("result1");
	var exp1 = /^[a-z0-9]{6,14}$/;
	if(!exp1.test(id.value)) {
		result1.style.color = "red";
	} 
	if(exp1.test(id.value)) {
		result1.style.color = "white";
	}
}

function pwd1keyup() {
	var pwd1 = document.getElementById("passwd");
	var result2 = document.getElementById("result2");
	var exp2 = /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^*=+-]){8,20}/;
	if(!exp2.test(pwd1.value)) {
		result2.style.color = "red";
		result2.innerHTML = "비밀번호는 8~20자리의 영어대소문자, 숫자, 특수문자를 반드시 사용해야 합니다.";
	}
	if(exp2.test(pwd1.value)) {
		result2.innerHTML = "사용가능한 비밀번호입니다.";
		result2.style.color = "green";
	}
}

function pwd2keyup() {
	var pwd1 = document.getElementById("passwd");
	var pwd2 = document.getElementById("passcheck");
	var result3 = document.getElementById("result3");
	if(pwd1.value == pwd2.value) {
		result3.innerHTML = "비밀번호와 일치합니다.";
		result3.style.color = "green";
	}
	if(pwd1.value != pwd2.value) {
		result3.innerHTML = "비밀번호와 일치하지 않습니다.";
		result3.style.color = "red";
	}
	if(pwd2.value == "") {
		result3.innerHTML = "";
	}
}

$(function() {
	$("#join").click(function() {
		var id = document.getElementById("userid");
		var pwd1 = document.getElementById("passwd");
		var pwd2 = document.getElementById("passcheck");
		var email = document.getElementById("email");
		var exp1 = /^[a-z0-9]{6,14}$/;
		var exp2 = /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^*=+-]){8,20}/;
		
		if(!exp1.test(userid.value)) {
			alert("아이디 형식이 올바르지 않습니다.");
			id.focus();
			return;
		}
		if(!exp2.test(passwd.value)) {
			alert("비밀번호 형식이 올바르지 않습니다.");
			pwd1.focus();
			return;
		}
		if(passwd.value != passcheck.value) {
			alert("비밀번호가 일치하지 않습니다.");
			pwd2.focus();
			return;
		}
		if(email.value == "") {
			alert("이메일을 입력하지 않았습니다.");
			email.focus();
			return;
		}
	
		document.form1.action = "${path}/memberlist_servlet/join.do";
		document.form1.submit();
	});
});
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
      <a class="navbar-brand" href="../general/index.jsp"><img src="../images/nonamelogoremove.png" width="30px"></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="../general/index.jsp">Home</a></li>
        <li><a href="../general/company.jsp">회사소개</a></li>
        <li><a href="../general/curriculum.jsp">커리큘럼</a></li>
        <li><a href="../general/serviceDefault.jsp">고객센터</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      <c:if test="${ loginId == null }">
  	  	<li><a href="../log/login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
			</c:if>
			<c:if test="${ loginId != null }">
				<li><a href="../log/login.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
			</c:if>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-2 sidenav">
    </div>
    <div class="col-sm-8 text-left" style="padding-top: 25px;">
			<form method="post" name="form1">
				<table>
					<tr>
						<td>아이디</td>
						<td><input id="userid" name="userid" maxlength="14" onkeyup="idkeyup(this)"></td>
						<td id="result1">아이디는 6~14자리의 영소문자와 숫자만 사용할 수 있습니다.</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" id="passwd" name="passwd" maxlength="20" onkeyup="pwd1keyup(this)"></td>
						<td id="result2">비밀번호는 8~20자리의 영어대소문자, 숫자, 특수문자를 반드시 사용해야 합니다.</td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td><input type="password" id="passcheck" name="passcheck" maxlength="20" onkeyup="pwd2keyup(this)"></td>
						<td id="result3"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" id="email" name="email"></td>
					</tr>
					<tr>
						<td></td>
						<td style="text-align: right;"><input type="button" value="등록하기" id="join"></td>
					</tr>
				</table>
			</form>
    </div>
    <div class="col-sm-2 sidenav">
    </div>
  </div>
</div>

<footer class="container-fluid text-center">
  <p><img src="../images/mainprofilelongremove.png" style="width: 100px;"></p>
</footer>

</body>
</html>

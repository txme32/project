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
<script type="text/javascript">
function edit() {
	var passCheck = $("#passCheck").val();
	if (passCheck == "") {
		alert("비밀번호를 입력하세요.");
		$("#passwd").focus();
		return;
	}
	if (passCheck != $("#passwd").val()) {
		alert("비밀번호가 일치하지 않습니다.");
		$("#passwd").focus();
		return;
	}
	
	document.form1.action = "${path}/memberlist_servlet/edit.do";
	document.form1.submit();
}

function del() {
	var passCheck = $("#passCheck").val();
	if (passCheck == "") {
		alert("비밀번호를 입력하세요.");
		$("#passwd").focus();
		return;
	}
	if (passCheck != $("#passwd").val()) {
		alert("비밀번호가 일치하지 않습니다.");
		$("#passwd").focus();
		return;
	}
	if(confirm("회원 탈퇴 시 모든 정보가 삭제됩니다. 계속하시겠습니까?")) {
		document.form1.action = "${path}/memberlist_servlet/delete.do";
		document.form1.submit();
	}
}
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
						<td>${ dto.userid }<input type="hidden" name="userid" id="userid" value="${ dto.userid }"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="passwd" id="passwd" value="${ dto.passwd }" readonly></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input name="email" id="email" value="${ dto.email }" readonly></td>
					</tr>
					<tr>
						<td>가입일자</td>
						<td><fmt:formatDate value="${ dto.join_date }" type="both" pattern="yyyy년 MM월 dd일 hh:mm:ss"/>
					</tr>
					<tr>
						<td colspan="2" style="text-align: right;"><input type="password" name="passCheck" id="passCheck"><button type="button" onclick="edit();">수정하기</button><button type="button" onclick="del();">탈퇴하기</button></td>
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

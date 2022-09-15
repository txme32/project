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
$(function() {
	$("#btnApply").click(function() {
		var studentName = $("#studentName").val();
		var studentGrade = $("#studentGrade").val();
		var studentTel = $("#studentTel").val();
		var studentLevel = $('input:radio[name=studentLevel]').is(':checked');
		var telCheck = /^[0-9]{7,8}$/;
		
		if(studentName == "") {
			alert("이름을 입력하지 않았습니다.");
			$('#studentName').focus();
			return false;
		}
		if(studentGrade == "") {
			alert("학년을 선택하지 않았습니다.");
			return false;
		}
		if(studentTel == "") {
			alert("전화번호를 입력하지 않았습니다.");
			return false;
		}
		if(!telCheck.test(studentTel)) {
			alert("전화번호를 올바르게 입력하세요.");
			$('#studnetTel').focus();
			return false;
		}
		if(!studentLevel) {
			alert("수준을 선택하지 않았습니다.");
			return false;
		}
		
		document.form.submit();
	});
});
</script>
<style type="text/css">
tr:nth-child(even) {
	background-color: #F7F9FC;
}

td:nth-child(odd) {
	width: 200px;
}

td:nth-child(even) {
	width: 300px;
}
</style>
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
      <a class="navbar-brand" href="index.jsp"><img src="../images/nonamelogoremove.png" width="30px"></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="index.jsp">Home</a></li>
        <li><a href="company.jsp">회사소개</a></li>
        <li><a href="curriculum.jsp">커리큘럼</a></li>
        <li><a href="serviceDefault.jsp">고객센터</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="../log/login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-2 sidenav">
      
    </div>
    <div class="col-sm-8 text-left" style="padding-top: 50px; padding-left: 100px;"> 
      <h2>상담신청서</h2>
			<form action="${ path }/apply_servlet/apply.do" method="post" name="form">
			<table>
				<tr>
					<td style="font-size: 20px;">이름</td>
					<td><input name="studentName" id="studentName" maxlength="10"></td>
				</tr>
				<tr>
					<td style="font-size: 20px;">학년</td>
					<td>
						<select name="studentGrade" id="studentGrade">
							<optgroup label="학년을 선택하세요.">
								<option value="9">중3이하</option>
								<option value="10">고1</option>
								<option value="11">고2</option>
								<option value="12">고3/n수</option>
								<option value="0">기타</option>
							</optgroup>
						</select>
					</td>
				</tr>
				<tr>
					<td style="font-size: 20px;">전화번호</td>
					<td>010&nbsp;-&nbsp;<input type="text" name="studentTel" id="studentTel" maxlength="8" placeholder="'-'없이 작성하세요"></td>
				</tr>
				<tr>
					<td style="font-size: 20px;">학업성취평가<br><a href="../examCloud/testFile.txt" download>[예시문제 다운로드]</a></td>
					<td>
						<input type="radio" name="studentLevel" id="highLevel" value="high">
						<label for="highLevel">상</label>
						<input type="radio" name="studentLevel" id="midLevel" value="mid">
						<label for="midLevel">중</label>
						<input type="radio" name="studentLevel" id="lowLevel" value="low">
						<label for="lowLevel">하</label>
					</td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" id="btnApply" value="신청하기"/>
				</tr>
			</table>
			</form>
   	</div>
    <div class="col-sm-2 sidenav">
  	  <c:if test="${ loginId == null }">
  	  	<p><a href="../log/login.jsp">로그인</a></p>
			</c:if>
			<c:if test="${ loginId != null }">
				<p>${ loginId }님 환영합니다.</p>
				<div class="well">
  	     	<p><a href="${ path }/memberlist_servlet/logout.do">로그아웃</a></p>
				</div>
				<div class="well">
					<p><a href="${ path }/memberlist_servlet/userInfo.do">회원정보</a></p>
				</div>
				<c:if test="${ loginAdmin == 'Y' }">
					<p><a href="../admin/listadapt.jsp">등록정보 확인하기</a></p>
				</c:if>
			</c:if>
    </div>
  </div>
</div>

<footer class="container-fluid text-center">
  <p><img src="../images/mainprofilelongremove.png" style="width: 100px;"></p>
</footer>

</body>
</html>

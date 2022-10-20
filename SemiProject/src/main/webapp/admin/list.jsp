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
function list(page){
	location.href="${path}/apply_servlet/list.do?pageScale=10&curPage=" + page;
}
</script>
</head>
<body>
push
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
      <p><a href="../general/apply.jsp">등록하기</a></p>
    </div>
    <div class="col-sm-8 text-left"> 
      <div align="center" style="padding-top: 28px;">
      	<table border="1">
					<tr>
						<td>번호</td>
						<td>이름</td>
						<td>학년</td>
						<td>전화번호</td>
						<td>평가점수</td>
						<td>등록일</td>
					</tr>
					<c:forEach var="list" items="${ list }">
					<tr>
						<td>${ list.num }</td>
						<td>${ list.student_name }</td>
						<td>${ list.student_grade }</td>
						<td>${ list.student_tel }</td>
						<td>${ list.student_level }</td>
						<td>${ list.reg_date }</td>
					</tr>
					</c:forEach>
					<tr>
						<td colspan="8" align="center">
							<c:if test="${pager.curPage > 1}">
								<a href="#" onclick="list('1')">[처음]</a>
							</c:if>
							<c:if test="${pager.curBlock > 1}">
								<a href="#" onclick="list('${pager.prevPage}')">[이전]</a>
							</c:if>
							<c:forEach var="num" begin="${pager.blockStart}" end="${pager.blockEnd}">
								<c:choose>
									<c:when test="${num == pager.curPage}">
 										<span style="color: red;">${num}</span>
									</c:when>
									<c:otherwise>
										<a href="#" onclick="list('${num}')">${num}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${pager.curBlock < pager.totBlock}">
								<a href="#" onclick="list('${pager.nextPage}')">[다음]</a>
							</c:if>
							<c:if test="${pager.curPage < pager.totPage}">
								<a href="#" onclick="list('${pager.totPage}')">[끝]</a>
							</c:if>
						</td>
					</tr>
				</table>
			</div>
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
수정된 파일 변경작업
</body>
</html>

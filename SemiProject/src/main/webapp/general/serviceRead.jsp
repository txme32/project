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
    
    table {
    	border: none;
    }
    
    table tr td {
    	border-bottom-color: black;
    	height: 25px;
    }
    
    table tr:last-child {
			border-bottom-color: white;
		}
  </style>
<script type="text/javascript">
function edit() {
	document.form1.action = "${path}/service_servlet/write.do?mode=edit";
	document.form1.submit();
}

function del() {
	if(confirm("삭제하시겠습니까?")) {
		document.form1.action = "${path}/service_servlet/delete.do";
		document.form1.submit();
	}
}

function reple() {
	document.form1.action = "${path}/service_servlet/write.do?mode=reple";
	document.form1.submit();
}

function list() {
	location.href = "${path}/service_servlet/list.do";
}

function edit2() {
	document.form2.action = "${path}/service_servlet/write.do?mode=edit";
	document.form2.submit();
}

function del2() {
	document.form2.action = "${path}/service_servlet/delete.do";
	document.form2.submit();
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
      <p><a href="../general/apply.jsp">등록하기</a></p>
    </div>
    <div class="col-sm-8" style="padding-top: 30px;"> 
      <div style="float: right;">
				<button type="button" onclick="list()">목록</button>
			</div>
			<table border="1" style="width: 100%;">
				<tr>
					<td colspan="4" align="right">번호 : ${ dto.ref }</td>
				</tr>
				<tr>
					<td rowspan="2" style="width: 15%; text-align: center; background-color: #F7F7F7;">제목</td>
					<td rowspan="2" style="width: 50%;">${ dto.title }</td>
					<td style="width: 15%; text-align: right; background-color: #F7F7F7;">조회수</td>
					<td style="width: 20%;">${ dto.readcount }</td>
					</tr>
				<tr>
					<td style="text-align: right; background-color: #F7F7F7;">작성일자</td>
					<td>
						<fmt:formatDate value="${ dto.reg_date }" type="both" pattern="yyyy-MM-dd hh:mm:ss"/>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="padding-left: 25px; text-align: left;">${ dto.content }</td>
				</tr>
				<tr>
					<td style="text-align: center;">첨부파일</td>
					<td colspan="3">
						<c:if test="${ dto.filesize > 0 }">
							<fmt:parseNumber value="${ dto.filesize/1024/1024*100 }" integerOnly="true" var="printSize"></fmt:parseNumber>
							${ dto.filename }(${ printSize/100 } MB)
							<a href="${path}/service_servlet/download.do?num=${dto.num}">[다운로드]</a>
						</c:if>
					</td>
				</tr>
			</table>
			<form name="form1" method="post" enctype="multipart/form-data">
			<table style="float: right;">
				<tr>
					<td colspan="4" style="text-align: right;">
						<input type="hidden" name="num" id="num" value="${ dto.num }">
						<button type="button" onclick="edit();">수정하기</button>
						<c:if test="${ loginAdmin == 'Y' }">
							<button type="button" onclick="reple();">답변하기</button>
						</c:if>
						<button type="button" onclick="del();">삭제하기</button>
					</td>
				</tr>
			</table>
			</form>
			<c:if test="${ returnReple == 'yes' }">
			<br>
			<br>
			<br>
			<br>
			<table border="1" style="width: 100%;">
				<tr>
					<td style="width: 15%; background-color: #F7F7F7;">제목</td>
					<td style="width: 50%;">${ dto2.title }</td>
					<td style="width: 15%; background-color: #F7F7F7;">작성자</td>
					<td style="width: 20%;">${ dto2.writer }</td>
				</tr>
				<tr>
					<td colspan="4">${ dto2.content }</td>
				</tr>
			</table>
			<c:if test="${ loginAdmin == 'Y' }">
			<form name="form2" method="post">
			<table style="float: right;">
				<tr>
					<td colspan="4" style="text-align: right;">
						<input type="hidden" name="num2" id="num2" value="${ dto2.num }">
						<button type="button" onclick="edit2();">수정하기</button>
						<button type="button" onclick="del2();">삭제하기</button>
					</td>
				</tr>
			</table>
			</form>
			</c:if>
		</c:if>
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

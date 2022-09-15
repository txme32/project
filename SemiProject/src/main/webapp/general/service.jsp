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
    
    tr:nth-child(even) {
			background-color: #F7F9FC;
		}
		
		tr:last-child {
			background-color: white;
		}
		
		table td {
			height: 40px;
		}
  </style>
<script type="text/javascript">
$(function() {
	$(".btnWrite").click(function() {
		location.href = "${path}/general/serviceWrite.jsp?mode=new";
	});
	
	$(".btnService").click(function() {
		location.href = "${path}/service_servlet/list.do";
	});
});

function list(page){
	location.href("${path}/service_servlet/list.do?curPage=" + page);
}

function popup(num) {
	var url = "popUpPage.do?num=" + num;
	var name = "_blank";
	var option = "width = 500, height = 200, top = 300, left = 300, location = no, scrollbars = no, resizable = no";
	window.open(url, name, option);
}

function passok(num) {
	window.location.assign("${path}/service_servlet/view.do?num=" + num);
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
    <div class="col-sm-8 text-left" style="padding-top: 20px; padding-bottom: 30px;">
    	<h2>고객센터</h2>
    	<p><span><button class="btnWrite">글쓰기</button></span><span style="float: right;"><button class="btnService">목록</button></span></p>
			<table border="1" style="width: 100%;">
				<tr>
					<th style="text-align: center; border-right-color: white; width: 10%;">번호</th>
					<th style="text-align: center; border-right-color: white; width: 50%;">제목</th>
					<th style="text-align: center; border-right-color: white; width: 15%;">작성자</th>
					<th style="text-align: center; border-right-color: white; width: 15%;">등록일</th>
					<th>조회수</th>
				</tr>
				<c:forEach var="list" items="${ list }">
					<c:choose>
						<c:when test="${ list.del eq 78 }">
							<c:if test="${ list.re_num == '1' }">
								<tr>
									<td style="border-right-color: white;">${ list.ref }<input type="hidden" name="num" id="num" value="${ list.num }"></td>
									<td style="border-right-color: white;">
										<a href="" onclick="popup(${ list.num })">
											${ list.title }
											<c:if test="${ list.filesize > 0 }">
												<img src="../images/disk.png" style="width: 20px;">
											</c:if>
										</a>
									</td>
									<td style="border-right-color: white;">${ list.writer }</td>
									<td style="border-right-color: white;">
										<fmt:formatDate value="${ list.reg_date }" type="date" pattern="yyyy-MM-dd"/>
									</td>
									<td>${ list.readcount }</td>
								</tr>
							</c:if>
							<c:if test="${ list.re_num == '2' }">
								<tr>
									<td style="border-right-color: white;"></td>
									<td style="border-right-color: white;">
										re : ${ list.title }<input type="hidden" name="num" id="num" value="${ list.num }">
										<c:if test="${ list.filesize > 0 }">
											<img src="../images/disk.png" style="width: 20px;">
										</c:if>
									</td>
									<td style="border-right-color: white;">${ list.writer }</td>
									<td style="border-right-color: white;">
										<fmt:formatDate value="${ list.reg_date }" type="date" pattern="yyyy-MM-dd"/>
									</td>
									<td>${ list.readcount }</td>
								</tr>
							</c:if>
						</c:when>
					</c:choose>
				</c:forEach> 

				<tr style="background-color: #CCCCCC;">
					<td colspan="8" align="center">
						<c:if test="${ pager.curPage > 1}">
							<a href="#" onclick="list('1')">[처음]</a>
						</c:if>
						<c:if test="${ pager.curBlock > 1}">
							<a href="#" onclick="list('${ pager.prevPage }')">[이전]</a>
						</c:if>
						<c:forEach var="num" begin="${ pager.blockStart }" end="${ pager.blockEnd }">
							<c:choose>
								<c:when test="${ num == pager.curPage }">
									<span style="color: red;">${ num }</span>
								</c:when>
								<c:otherwise>
									<a href="#" onclick="list('${ num }')">${ num }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${ pager.curBlock < pager.totBlock }">
							<a href="#" onclick="list('${ pager.nextPage }')">[다음]</a>
						</c:if>
						<c:if test="${ pager.curPage < pager.totPage }">
							<a href="#" onclick="list('${ pager.totPage }')">[끝]</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="text-align: center; border-right-color: white;">
						<form name="form1" method="post" action="${path}/service_servlet/search.do">
							<select name="search_option">
								<option value="writer">작성자</option>
								<option value="title">제목</option>
								<!-- <option value="content">내용</option> -->
							</select>
							<input name="keyword" id="keyword">
							<button id="btnSearch">검색</button>
						</form>
					</td>
					<td style="text-align: right;">
						<button class="btnWrite">글쓰기</button>
					</td>
				</tr>
			</table>
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

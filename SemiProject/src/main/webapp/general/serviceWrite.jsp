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
		
		textarea {
			resize: none;
		}
  </style>
<script type="text/javascript">
$(function() {
	$("#btnSave").click(function() {
		if ($("#mode").val() == "new") {
			document.form.action = "${path}/service_servlet/save.do";
			document.form.submit();
		}
		if ($("#mode").val() == "edit") {
			document.form.action =  "${path}/service_servlet/update.do";
			document.form.submit();
		}
		if ($("#mode").val() == "reple") {
			document.form.action = "${path}/service_servlet/reple.do";
			document.form.submit();
		}
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
        <li><a href="../general/company.jsp">????????????</a></li>
        <li><a href="../general/curriculum.jsp">????????????</a></li>
        <li><a href="../general/serviceDefault.jsp">????????????</a></li>
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
      <p><a href="apply.jsp">????????????</a></p>
    </div>
    <div class="col-sm-8 text-left" style="padding-top: 20px; padding-bottom: 30px;">
    	<form name="form" method="post" enctype="multipart/form-data">
	<c:if test="${ param.mode == 'new' }"><!-- ??? ?????? ????????? ?????? ??? hidden?????? ????????? ??? -->
		<input type="hidden" name="mode" id="mode" value="${ param.mode }">
	</c:if>
	<c:if test="${ param.mode == 'edit' }">
		<input type="hidden" name="mode" id="mode" value="${ param.mode }">
		<input type="hidden" name="num" id="num" value="${ dto.num }">
	</c:if>
	<c:if test="${ param.mode == 'reple' }">
		<input type="hidden" name="mode" id="mode" value="${ param.mode }">
		<input type="hidden" name="re_num" id="re_num" value="2">
		<input type="hidden" name="ref" id="ref" value="${ ref }">
	</c:if>
	<table>
		<tr>
			<td>?????????</td>
			<td><input name="writer" id="writer" value="${ dto.writer }"></td>
		</tr>
		<tr>
			<td>?????????</td>
			<td><input name="email" id="email" value="${ dto.email }"></td>
		</tr>
		<tr>
			<td>??????</td>
			<td><input name="title" id="title" size="60" value="${ dto.title }"></td>
		</tr>
	<tr>
		<td>??????</td>
		<td><textarea rows="20" cols="100" name="content" id="content">${ dto.content }</textarea></td>
	</tr>
	<tr>
		<td>????????????</td>
		<td>
			<c:if test="${dto.filesize > 0}">
			${dto.filename}( ${dto.filesize / 1024} kb)
			<input type="checkbox" name="fileDel">???????????? ?????? <br>
		</c:if>
		<input type="file" name="file"></td>
	</tr>
	<tr>
		<td>????????????</td>
		<td><input type="password" name="passwd" id="passwd" value="${ dto.passwd }"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" value="????????????" id="btnSave">
		</td>
	</tr>
</table>
</form>
		</div>
		<div class="col-sm-2 sidenav">
			<c:if test="${ loginId == null }">
				<p><a href="../log/login.jsp">?????????</a></p>
			</c:if>
			<c:if test="${ loginId != null }">
				<p>${ loginId }??? ???????????????.</p>
				<div class="well">
					<p><a href="${ path }/memberlist_servlet/logout.do">????????????</a></p>
				</div>
				<div class="well">
					<p><a href="${ path }/memberlist_servlet/userInfo.do">????????????</a></p>
				</div>
				<c:if test="${ loginAdmin == 'Y' }">
					<p><a href="../admin/listadapt.jsp">???????????? ????????????</a></p>
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

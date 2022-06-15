<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "quest.*" %>
<%@ page import = "member.*" %>
<%@ page import = "java.util.*" %>


<%
	request.setCharacterEncoding("utf-8");
%>
<%@ include file="adminTop.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main</title>
	<link rel="stylesheet" href="css/bootstrap.css">
	<style>
		body{
			background-color:#EFF5FB;
			height : 100%;
		}
		
		<%@ include file="asideCss.jsp" %>
		#main{
			display:table-cell;
			border-spacing:0;
			width:1200px;
			height : 560px;
			display:table-cell;
			padding: 50px 10px;
			margin : 0 auto;
			text-align : left;
		}
		#form{
			width : 1100px;
			height : 500px;
		}
		#form th{
			width : 200px;
			height : 60px;
			font-size : 20px;
		}
	</style>
	<script type="text/javascript">
		function goBack(){
			var referer = document.referrer;
			location.replace(referer);
		}
		function InputCheck(){
			var writeForm = document.writeform;
			
			if(writeForm.subject.value==""){
			  alert("제목을 적어 주세요!");
			  writeForm.subject.focus();
			  return false;
			}
			
			if(writeForm.content.value==""){
			  alert("내용을 적어 주세요!");
			  writeForm.content.focus();
			  return false;
			}
		        
			if(writeForm.passwd.value==""){
			  alert("비밀버호를 적어 주세요!");
			  writeForm.passwd.focus();
			  return false;
			} 
			alert();
			return true;
		}
	</script>
</head>

<body>
	<div id="content">
		<aside>
			<div id="side">
				<span id="side_name">고객센터</span><br>
				
				
				<ul id="side_ul">
					<li onClick="location.href='noticeAdminList.jsp'" id="side_ul_now">공지사항</li>
					<li onClick="location.href='questAdminList.jsp'">Q & A</li>
				</ul>
			</div>
		</aside>
		<section>
			<div id="main">
				<p>공지사항</p>
			<form action="noticeRegProc.jsp" name="writeform" onSubmit="return InputCheck();">
				<table id="form" class="table">
					<tr>
						<td colspan=2 align=right>
							<input type=button value="글목록" class="btn btn-dark" onClick="goBack()">
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td align=left><input type=text class="form-control" size=50 maxlength=100 name=subject></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea rows="13" cols="120" class="form-control" name=content></textarea></td>
					</tr>
					<tr>
						<td colspan=2 align=center>
							<input type=submit class="btn btn-outline-primary" value="등록">
							<input type=reset class="btn btn-info" value="다시작성">
							<input type=button value="취소" class="btn btn-danger" onClick="goBack()">
						</td>
					</tr>
				</table>
			</form>
			</div>
		</section>
	</div>
</body>
</html>
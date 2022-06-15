<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "quest.*" %>
<%@ page import = "member.*" %>
<%@ page import = "java.util.*" %>


<%
	request.setCharacterEncoding("utf-8");
	String uId = "";
	if(request.getParameter("uId") != null)
		uId = request.getParameter("uId");
	
	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.getMembers();
	List<MemDataBean> myList = dbBean.searchMembers("uId", uId);
	MemDataBean member = null;
	
	if(myList != null){
		member = myList.get(0);
	}
%>
<%@ include file="top1.jsp" %>
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
		
		#go_list{
			width : 1100px;
			text-align:right;
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
<%
	if(member != null){
%>
				<ul id="side_ul">
					<li onClick="location.href='noticeList.jsp?uId=<%=member.getuId() %>'">공지사항</li>
					<li onClick="location.href='questList.jsp?uId=<%=member.getuId() %>'" id="side_ul_now">Q & A</li>
				</ul>
<%}else{ %>
				<ul id="side_ul">
					<li onClick="location.href='noticeList.jsp'">공지사항</li>
					<li onClick="location.href='questList.jsp'" id="side_ul_now">Q & A</li>
				</ul>
<%} %>
			</div>
		</aside>
		<section>
			<div id="main">
				<div id="go_list">
					<input type=button value="글목록" class="btn btn-dark" onClick="goBack()">
				</div>	
				<br>
			<form action="questProc.jsp" name="writeform" onSubmit="return InputCheck();">
				<table id="form" class="table">
					<tr>
						<th>제목</th>
						<td align=left><input type=text class="form-control" size=50 maxlength=100 name=subject></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type=password size=12 class="form-control" maxlength=12 name=passwd></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea rows="13" cols="120" class="form-control" name=content></textarea></td>
					</tr>
					<tr>
						<td colspan=2 align=center>
							<input type=submit value="등록" class="btn btn-outline-primary">
							<input type=reset value="다시작성" class="btn btn-info">
							<input type=button value="취소" onClick="goBack()" class="btn btn-danger">
							<input type=hidden name="uId" value="<%=uId %>">
						</td>
					</tr>
				</table>
			</form>
			</div>
		</section>
	</div>
</body>
</html>
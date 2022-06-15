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
<%
	int num = 0;
	
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));	
	}
	QuestDBBean questBean = QuestDBBean.getInstance();
	List<QuestDataBean> questList = questBean.detailQuests(num);
	QuestDataBean quest = questList.get(0);

	questList = questBean.detailQuests(num);
	quest = questList.get(0);

	List<MemDataBean> memList2 = dbBean.searchMembers("uId", quest.getuId());
	MemDataBean member2 = memList2.get(0);
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
		a{
			color : black;
		}
		a:hover{
			color : #0174DF;
			text-decoration:none;
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
					<li>공지사항</li>
					<li id="side_ul_now">Q & A</li>
				</ul>
			</div>
		</aside>
		<section>
			<div id="main">
				<p>Q & A</p>
			<form action="questUpdateProc.jsp" name="writeform" onSubmit="return InputCheck();">
				<table id="form" class="table">
					<tr>
						<td colspan=2 align=right>
							<input type=button class="btn btn-dark" value="글목록" onClick="goBack()">
							<input type=hidden name=uId value=<%=uId %>>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td align=left><input type=text class="form-control" size=50 value=<%=quest.getSubject() %> maxlength=100 name=subject></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type=password size=12 class="form-control" maxlength=12 name=passwd></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea rows="13" cols="120" class="form-control" name=content>
							<%=quest.getContent() %>
						</textarea></td>
					</tr>
					<tr>
						<td colspan=2 align=center>
							<input type=submit class="btn btn-outline-primary" value="등록">
							<input type=reset class="btn btn-info" value="다시작성">
							<input type=button value="취소" class="btn btn-danger" onClick="goBack()">
							<input type=hidden name=num value=<%=quest.getNum() %>>
						</td>
					</tr>
				</table>
			</form>
			</div>
		</section>
	</div>
</body>
</html>
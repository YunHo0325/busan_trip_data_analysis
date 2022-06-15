<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "quest.*" %>
<%@ page import = "member.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));	
	
	MemDBBean dbBean = MemDBBean.getInstance();
%>
<%
	QuestDBBean questBean = QuestDBBean.getInstance();
	System.out.println(num);
	List<QuestDataBean> questList = questBean.detailQuests(num);
	QuestDataBean quest = null;
	if(questList != null)	
		quest = questList.get(0);
	
	List<MemDataBean> memList2 = dbBean.searchMembers("uId", quest.getuId());
	MemDataBean member2 = memList2.get(0);
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
		#search_user_ul{
			list-style:none;
			width : 50%;
			height : 50px;
			line-height:43px;
			padding:0;
			margin:0 auto;
			text-align : center;
		}
		#filter_li{
			float : left;
			display : inline;
			width : 25%;
			height : 100%;
			padding : 0;
			margin : 0;
			text-align : center;
			color : black;
		}
		#filter{
			width : 95%;
			height : 80%;
			
			border-radius:10px;
		}
		#search_user_text_li{
			float : left;
			display : inline;
			width : 65%;
			height : 100%;
			padding : 0;
			margin : 0;
			text-align : center;
			color : black;
		}
		#search_user_text_li input[type=text]{
			width : 100%;
			height: 45px;
			border-radius:10px;
			border : 1px solid black;
		}
		#search_user_i_li{
			float : left;
			display : inline;
			width : 8.5%;
			height : 100%;
			padding : 0;
			margin : 0;
			text-align : center;
			color : black;
		}
		#search_user_ul input[type=image]{
			display : inline;
			width:100%;
			height:100%;
			text-align : center;
			margin:0 ;
			padding:0;
		}
		#user_table{
			width : 100%;
		}
		#user_table th{
			text-align : center;
			font-size : 25px;
		}
		#user_table td{
			font-size : 20px;
		}
		#element_subject{
			padding : 0 0 0 10px;
		}
		#idx, #element, #element_option{
			text-align : center;
			padding : 0;
		}
		
		#quest{
			width : 1100px;
			height : 500px;
			font-size : 20px;
		}
		#quest th{
			text-align : center;
			font-size : 23px;
			
			vertical-align : middle;
		}
		#quest td{
			padding : 10px;
		}
		#profile_i{
			margin : 5px 0 0 0;
			width : 100px;
			border: 3px solid black;
			border-radius: 1000px;
			-moz-border-radius: 1000px;
			-khtml-border-radius: 1000px;
			-webkit-border-radius: 1000px;
			margin : 0 auto;
		}
		#answer{
			width : 100%;
			height : 350px;
			font-size : 20px;
		}
		#answer th{
			text-align : center;
			font-size : 23px;
			padding : 10px 0 0 0;
		}
		#answer td{
			padding : 5px;
		}
		#profile_answer_i{
			margin : 5px 0 0 0;
			width : 100px;
			border: 3px solid black;
			border-radius: 1000px;
			-moz-border-radius: 1000px;
			-khtml-border-radius: 1000px;
			-webkit-border-radius: 1000px;
			margin : 0 auto;
		}
		#form{
			width : 1100px;
			height : 200px;
		}
		#form th{
			width : 200px;
			height : 60px;
			font-size : 20px;
		}
		#answer_span{
			font-size : 25px;
			font-weight : bold;
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
	</script>
</head>
<body onLoad="incRead()">
	<div id="content">
		<aside>
			<div id="side">
				<span id="side_name">고객센터</span><br>
				
				<ul id="side_ul">
					<li onClick="location.href='noticeAdminList.jsp'">공지사항</li>
					<li onClick="location.href='questAdminList.jsp'" id="side_ul_now">Q & A</li>
				</ul>
			</div>
		</aside>
		
		<section>
			<div id="main">
				<h2>Q&A</h2>		
				<table id="quest" class="table">
					<tr>
						<td colspan=2 align=right height=60px>
							<input type="button" value="삭제" class="btn btn-danger" onClick="location.href='questAdminDeleteProc.jsp''">
							<input type=button value="글목록" class="btn btn-dark" onClick="goBack()">
							<input type=hidden name=uId value=<%=quest.getuId() %>>
						</td>
					</tr>
					<tr>
						<th rowspan=2 width=12%>
							<img src="<%=member2.getImg() %>" id="profile_i">
						</th>
						<td height=15% style="vertical-align:bottom">
							<%=quest.getSubject() %>
						</td>
					</tr>
					<tr>
						<td height=15% style="vertical-align:top">
							<%=member2.getuName() %> | <%=quest.getReg_date() %>
							 | 조회수 <%=quest.getReadcount() %> | <span id="report">신고</span>
						</td>
					</tr>
					<tr>
						<td colspan=2 style="vertical-align:top">
							<%=quest.getContent() %>
						</td>
					</tr>
				</table>

				<br>
				<span id="answer_span">Answer</span>
				<br>

				<form action="questAnswerProc.jsp" name="writeform" onSubmit="return InputCheck();">
				<table id="form" class="table">
					<tr>
						<th>
							<input type=hidden name=num value=<%=quest.getNum() %>>
							내용
						</th>
<%
	if(quest.getAnswer() != null){
%>
						<td><textarea rows="13" cols="120" name=answer value=<%=quest.getAnswer() %>></textarea></td>
<%}else{%>
						<td><textarea rows="13" cols="120" name=answer></textarea></td>
<%} %>
					</tr>
				</table>
				<input type="submit" class="btn btn-dark" value="답변하기">
			</form>

			</div>
		</section>
		
	</div>

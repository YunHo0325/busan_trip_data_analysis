<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "quest.*" %>
<%@ page import = "member.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));	
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
	QuestDBBean questBean = QuestDBBean.getInstance();
	List<QuestDataBean> questList = questBean.detailQuests(num);
	QuestDataBean quest = questList.get(0);
	questBean.increaseReadCount(quest);

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
			border : solid;
			width : 100%;
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
			vertical-align : middle;
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
		#go_list{
			text-align:right;
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
				<h2>Q & A</h2>
				<div id="go_list">
					<input type=button value="글목록" class="btn btn-danger" onClick="goBack()">
				</div>			
				<br>
				
				<table id="quest" class="table">
					<tr>
						<th rowspan=2 width=12%>
							<input type=hidden name=uId value=<%=uId %>>
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
<%
		if(member != null && member2 != null){
			if(member.getuId().equals(member2.getuId())){
%>

				<div id="button">
					<form action="">
<%
				if(quest.getAnswer() == null){

%>
						<input type=button value="수정" id="update" class="btn btn-primary" onClick="location.href='questUpdateForm.jsp?num=<%=quest.getNum() %>&uId=<%=uId %>'">
<%} %>
						<input type=button value="삭제" id="delete" class="btn btn-danger" onClick="location.href='questDeleteProc.jsp?num=<%=quest.getNum() %>&uId=<%=uId %>'">
					</form>
				</div>
<%
		}}
%>
				<br>
				<span id="answer_span">Answer</span>
				<br>
<%
		if(quest.getAnswer() != null){
			List<MemDataBean> adminList = dbBean.getAdmin();
			MemDataBean admin=null;
			if(adminList != null)
				admin = adminList.get(0);
%>
				<table id="answer" class="table">
					<tr>
						<th rowspan=2 width=12% style="vertical-align:top">
							<img src="<%=admin.getImg() %>" id="profile_answer_i">
						</th>
						<td height=60px>
							<%=admin.getuName() %> | <%=quest.getReg_date() %>
						</td>
					</tr>
					<tr>
						<td style="vertical-align:top">
							<%=quest.getAnswer() %>
						</td>
					</tr>
				</table>
<%
		}
%>
			</div>
		</section>
		
	</div>

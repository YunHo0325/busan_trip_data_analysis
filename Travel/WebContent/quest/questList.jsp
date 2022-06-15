<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "quest.*" %>
<%@ page import = "java.util.*" %>
<%
	int pageSize = 5;	// 페이지 당 글의 갯수
	int pageBlock = 5;	// 페이지 블록 당 페이지 수
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
%>
<%
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
	
	QuestDBBean questBean = QuestDBBean.getInstance();
	int questCount = questBean.getAllQuest();
	List<QuestDataBean> questList = questBean.getQuests(startRow, pageSize);
	int count = questBean.getQuestCount();
	int number = count - (currentPage - 1)*pageSize;
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
		#content{
			display:table;
			width:1500px;
			height : 500px;
			margin: 0 auto;
			padding : auto;
			text-align : center;
			
			position : relative;
			top : 600px;
			left : 0;
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
		#paging_table{
			width : 100%;
		}
		#user_table th{
			text-align : center;
			font-size : 25px;
			height : 50px;
			vertical-align : middle;
			background:#c8c8c8;
		}
		#user_table td{
			font-size : 20px;
			
			vertical-align : middle;
			height : 50px;
		}
		#element_subject{
			padding : 0 0 0 10px;
		}
		#idx, #element, #element_option{
			text-align : center;
			padding : 0;
		}
		
		#write{
			border : solid;
			margin : 10px;
			width : 1200px;
			text-align : right;
		}
		a{
			color : black;
		}
		a:hover{
			color : #0174DF;
			text-decoration:none;
		}
		#tabs .section-title{
		    color: #eee;
		}
		#answer_complete{
			border-radius : 10px;
		}
		#answer_yet{
			border-radius : 10px;
		}
		.project-tab #tabs{
		    border-color: transparent transparent #f3f3f3;
		    border-bottom: 3px solid !important;
		    font-size: 16px;
		    font-weight: bold;
		}
	</style>
	<script type="text/javascript" src="fun_script.js"></script>
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
				<form action="questSearchProc.jsp" method="post">
					<input type="hidden" name="uId" value=<%=uId %>>
					<ul id="search_user_ul">
						<li id="filter_li">
							<select name="filter" id="filter" class="custom-select">
								<option value="subject">제목</option>
								<option value="content">내용</option>
							</select></li>
						<li id="search_user_text_li"><input type="text" class="form-control" name="search_text" ></li>
						<li id="search_user_i_li">
								<input type="image" src="img/serach.png">
						</li>
					</ul>
				</form>
				<br>
				
				<section id="tabs" class="project-tab">
				<table id="user_table" class="table" cellspacing=0>
					<tr>
						<th width=5%>IDX</th>
						<th>제목</th>
						<th width=10%>조회수</th>
						<th width=12%>작성자</th>
						<th width=20%>등록일</th>
						<th width=12%>OPTION</th>
					</tr>
					
<% if (questList != null) {%>
<%
		for(int i=0; i<questList.size(); i++) {
			QuestDataBean quest = questList.get(i);
%>
					<tr>
<%
			if(member != null){
%>
						<td id="idx">
							<a href="questDetail.jsp?num=<%=quest.getNum() %>&uId=<%=member.getuId() %>">
								<%=questCount - i - pageSize*(Integer.parseInt(pageNum)-1) %>
							</a>
						</td>
						<td id="element_subject">
							<a href="questDetail.jsp?num=<%=quest.getNum() %>&uId=<%=member.getuId() %>">
								<%=quest.getSubject() %>
							</a>
						</td>
					<%}else { %>
						<td id="idx">
							<a href="questDetail.jsp?num=<%=quest.getNum() %>">
								<%=questCount - i - pageSize*(Integer.parseInt(pageNum)-1) %>
							</a>
						</td>
						<td id="element_subject">
							<a href="questDetail.jsp?num=<%=quest.getNum() %>">
								<%=quest.getSubject() %>
							</a>
						</td>
					<% } %>
						
						<td id="element" align=center><%=quest.getReadcount() %></td>
						<td id="element"><%=quest.getuId() %></td>
						<td id="element"><%=quest.getReg_date() %></td>
						<td id="element_option">
<%
					if(quest.getAnswer() != null){
%>
							<input type=button class="btn btn-primary"value=답변완료 id="answer_complete">
<%
					}else{
%>
							<input type=button class="btn btn-danger" value="답변 대기중" id="answer_yet">
<%
					}
%>
						</td>
					</tr>	
					
					<% }}else{ %>
					<%} %>	
				</table>
				</section>
				<section id="tabs" class="project-tab">
				<table id="paging_table">
					<tr>
						<td></td>
<%if(member != null) {%>
						<td align=center width=98%>
<%
	if (count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1;
		//int pageBlock = 2;
		
		if(currentPage % pageBlock != 0){
			startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
		}else{
			startPage = ((int)(currentPage/pageBlock)-1)*pageBlock + 1;
		}
		
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		
		if(startPage > pageBlock){
%>
							<a href = "questList.jsp?pageNum=<%=startPage - pageBlock %>&uId=<%=uId %>">[이전]</a>
<%			
		}
		
		for(int i=startPage; i <= endPage; i++){
%>
							<a href = "questList.jsp?pageNum=<%=i%>&uId=<%=uId %>">[<%=i %>]</a>			
<%
		}
		
		if(endPage < pageCount){
%>
							<a href = "questList.jsp?pageNum=<%=startPage + pageBlock %>&uId=<%=uId %>">[다음]</a>
<%		
		}
		
	}
%>
						</td>
<%} else{ %>
						<td align=center width=98%>
<%
	if (count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1;
		//int pageBlock = 2;
		
		if(currentPage % pageBlock != 0){
			startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
		}else{
			startPage = ((int)(currentPage/pageBlock)-1)*pageBlock + 1;
		}
		
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		
		if(startPage > pageBlock){
%>
							<a href = "questList.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</a>
<%			
		}
		
		for(int i=startPage; i <= endPage; i++){
%>
							<a href = "questList.jsp?pageNum=<%=i%>">[<%=i %>]</a>			
<%
		}
		
		if(endPage < pageCount){
%>
							<a href = "questList.jsp?pageNum=<%=startPage + pageBlock %>">[다음]</a>
<%		
		}
		
	}
%>
						</td>
<%} %>						<td>
						</td>
					</tr>
				</table>
				</section>
					
<%
			if(member != null){
%>
				<input type=button value="글쓰기" id="write_button" class="btn btn-dark" onClick="location.href='questForm.jsp?uId=<%=member.getuId() %>'">
<%
			}else{
%>
				<input type=button value="글쓰기" id="write_button" class="btn btn-dark" disabled onClick="not_login()">
<%}%>
			</div>
		</section>
		
	</div>

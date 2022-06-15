<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "notice.*" %>
<%@ page import = "member.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));	
	
	
	MemDBBean dbBean = MemDBBean.getInstance();
	
%>
<%
	NoticeDBBean noticeBean = NoticeDBBean.getInstance();
	List<NoticeDataBean> noticeList = noticeBean.detailNotices(num);
	NoticeDataBean notice = noticeList.get(0);
	System.out.println(notice.getnNum());
	noticeBean.increaseReadCount(notice);

	noticeList = noticeBean.detailNotices(num);
	notice = noticeList.get(0);
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
		
		#notice{
			width : 100%;
			height : 500px;
			font-size : 20px;
		}
		#notice th{
			padding : 10px;
			font-size : 23px;
			height : 30px;
		}
		#notice td{
			padding : 10px;
			vertical-align : top;
		}
		#info{
			text-align:right;
			height : 20px;
			vatical-align : center;
		}
		#go_list {
			text-align:right;
			height : 40px;
			vatical-align : center;
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
					<li onClick="location.href='noticeAdminList.jsp'" id="side_ul_now">공지사항</li>
					<li onClick="location.href='questAdminList.jsp'">Q & A</li>
				</ul>
			</div>
		</aside>
		
		<section>
			<div id="main">
				<h2>공지사항</h2>	
				<div id="go_list">
					<input type=button value="글목록" class="btn btn-dark" onClick="goBack()">
				</div>	
				<table id="notice" class="table">
					<tr>
						<th>
							<%=notice.getSubject() %>
						</th>
					</tr>
					<tr>
						<td id="info">
							조회수 <%=notice.getReadcount() %> | 
							작성일 <%=notice.getReg_date() %>
						</td>
					</tr>
					<tr>
						<td>
							<%=notice.getContent() %>
						</td>
					</tr>
				</table>
				<br>
				<div id="button">
					<input type=button value="수정" class="btn btn-info" id="update" onClick="location.href='noticeUpdateForm.jsp?nNum=<%=notice.getnNum() %>'">
					<input type=button value="삭제" class="btn btn-danger" id="delete" onClick="location.href='noticeDelete.jsp?nNum=<%=notice.getnNum() %>'">
				</div>
			</div>
		</section>
		
	</div>

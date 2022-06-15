<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String filter = request.getParameter("filter");
	String search_text = request.getParameter("search_text");	
%>
<%
	String uId = null;
	if(request.getParameter("uId") != null)
		uId = request.getParameter("uId");
	
	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> myList = dbBean.getMembers();
	
	List<MemDataBean> memList = dbBean.searchMembers(filter, search_text);
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
		#content{
			display:table;
			width:100%;
			height : 500px;
			margin: 0 auto;
			padding : auto;
			text-align : center;
			
			position : relative;
			top : 600px;
			left : 0;
		}
		<%@ include file="asideCss.jsp" %>
		section{
			margin : 0 auto;
		}
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
			height : 50px;
			vertical-align : middle;
			background:#c8c8c8;
		}
		#user_table td{
			font-size : 20px;
			
			vertical-align : middle;
			height : 50px;
		}
		#element, #element_email{
			padding : 0 0 0 10px;
		}
		#idx, #element_option{
			text-align : center;
			padding : 0;
		}
		#idx{
			width : 70px;
		}
		#element{
			width : 190px;
		}
		#element_option{
			width : 150px;
		}
	</style>
	<script>
		function search_user(){
			var filter = document.getElementById("filter");
			var search_text = documnet.getElementById("search_user");
			
			location.href="memSearchProc.jsp?fileter="+filter+"+search_text="+search_text;
		}
	</script>
</head>
<body>
	<div id="content">
		<aside>
			<div id="side">
				<span id="side_name">ADMIN</span><br>
				
				<ul id="side_ul">
					<li onClick="location.href='admin_user.jsp'" id="side_ul_now">사용자 관리</li>
					<li onClick="location.href='questAdminList.jsp'">고객센터</li>
				</ul>
			</div>
		</aside>
		<section>
			<div id="main">
				<form action="memSearchProc.jsp">
					<ul id="search_user_ul">
						<li id="filter_li"><select name="filter" id="filter" class="custom-select">
							<option value="uId">ID</option>
							<option value="uName">NAME</option>
						</select></li>
						<li id="search_user_text_li"><input type="text" class="form-control" name="search_text" ></li>
						<li id="search_user_i_li"><input type="image" src="img/serach.png" onClick="search_user()"></li>
					</ul>
				</form>
				<br>
				
				<% if (memList != null) {%>
				<table id="user_table" class="table">
					<tr>
						<th>IDX</th>
						<th>ID</th>
						<th>PASSWORD</th>
						<th>NAME</th>
						<th>E-MAIL</th>
						<th>OPTION</th>
					</tr>
					<%
					for(int i=0; i<memList.size(); i++){
						MemDataBean member = memList.get(i);
					%>
					<tr>
						<td id="idx">
							<a href="memDetailProc.jsp/?uId=<%=member.getuId() %>"><%=(i+1) %></a>
						</td>
						<td id="element"><%=member.getuId() %></td>
						<td id="element"><%=member.getPwd() %></td>
						<td id="element"><%=member.getuName() %></td>
						<td id="element_email"><%=member.getEmail() %></td>
						<td id="element_option">
							<input type=submit value=edit class="btn btn-info" onClick="location.href='memUpForm.jsp?userId=<%=member.getuId()%>'">
							<input type=submit value=delete class="btn btn-danger" onClick="location.href='memDelProc.jsp?userId=<%=member.getuId()%>'">
						</td>
					</tr>	
					
					<% }}else{ %>
					
					<%} %>	
				</table>
			</div>
		</section>
	</div>
	<footer>
	
	</footer>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>
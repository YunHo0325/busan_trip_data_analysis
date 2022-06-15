<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "place.*" %>



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
		#top{
			position : relative;
			top:0;
			left:0;
			width : 100%;
			heigth : 560px;
		}
		#top_i{
			position : absolute;
			top : 0;
			left : 0;
			width : 100%;
			height : 560px;
		}
		#top_i1{
			width : 100%;
			height : 560px;
		}
		#top_first{ 
			list-style:none;
			width : 100%;
			height : 100px;
			line-height:100px;
			padding:0;
			margin:0;

			position : absolute;
			top : 0;
			left : 0;
		}
		#logo{
			display : inline;
			float : left;
			width: 14%;
			height:100%;
			text-align : center;
			margin:0;
			padding:0;
		}
		#search_text_li{
			display : inline;
			float : left;
			width: 13%;
			height:100%;
			text-align : center;
			margin:0;
			padding:0;
		}
		#search_i_li{
			display : inline;
			width:13%;
			height:100%;
			text-align : center;
			margin:0;
			padding:0;
		}
		#first_right_li{
			display : inline;
			float : right;
			width:7%;
			height:100%;
			text-align : center;
			margin:0;
			padding:0;
			font-size : 20px;
			color : black;
		}
		#all_menu_li{
			display : inline;
			float : right;
			width:6%;
			height:100%;
			text-align : center;
			margin:0;
			padding:0;
		}
		#logo_i{
			width : 100%;
			heigth : 100%;
		}
		#search_i{
			height:50%;
			margin:0;
			padding:0;
		}
		#all_menu_i{
			height:50%;
			margin:0;
			padding:0;
		}
		input[type=text]{
			height: 30px;
			border-radius:10px;
			border : 1px solid black;
		}
		
		#top_second{ 
			list-style:none;
			width : 100%;
			height : 50px;
			line-height:43px;
			padding:0;
			margin:0;
			
			position : absolute;
			top : 120px;
			left : 0;
		}
		#second_button_li{
			float : left;
			display : inline;
			width : 10%;
			height : 100%;
			padding : 0;
			margin : 0;
			text-align : center;
			color : black;
		}
		#second_button1, #second_button2, #second_button3{
			width : 100%;
			height : 100%;
			padding : 0;
			margin : 0;
		}
		
		#top_third{ 
			list-style:none;
			width : 100%;
			height : 50px;
			line-height:43px;
			padding:0;
			margin:0;
			position : absolute;
			top : 200px;
			left : 0;
		}
		
		#top_fourth{  
			list-style:none;
			width : 100%;
			height : 360px;
			line-height:43px;
			padding:0;
			margin:0;
			display : table;
			overflow : hidden;
			
			position : absolute;
			top : 250px;
			left : 0;
		}
		#country_name_span{
			display : table-cell;
			text-align : center;
			vertical-align : bottom;
			color : white;
			font-size : 40px;
			padding : 0 0 150px 0;
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
		aside{
			width:300px;
			height : 500px;
			padding:0;
			margin: 0 auto;
			display:table-cell;
			border-spacing:0;
			text-align : left;
		}
		#side{
			width : 18%;
			height : 100%;
			padding: 50px 40px;
			margin: 0 auto;
			
			position:absolute;
			top : 0;
			left : 0;
		}
		#side_name{
			font-size : 30px;
		}
		#side_ul{
			list-style:none;
			width : 90%;
			line-height:45px;
			padding:0;
			margin:20px 0 0 20px;
			font-size : 18px;
			text-shadow : 0 0 1px black;
		}
		#side_ul li:hover{
			color : #0174DF;
		}
		#side_ul_now{
			color : #0174DF;
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
		#form{
			border : solid;
			width : 900px;
			height : 100%;
		}
	</style>
	<script>
		function answer(){
			var log =0;
			
			document.all.answer_complete.style.display="none";
			if(log==1){
				document.all.answer_yet.style.display="none";
				document.all.answer_comeplete.style.display="";
			}
		}
	</script>
</head>

<body>
	<header>
		<div id="top">
			<div id="top_i">
				<img src="img/uk/main/uk4.jpg" id="top_i1" alt="top_i1">
			</div>
			<ul id="top_first">
				<li id="logo">
					<img src="img/site_logo.png" id="logo_i" alt="logo">
				</li>
				<li id="search_text_li">
					<input type=text name="search_text" id="search_text" size="22" placeholder="input">
				</li>
				<li id="search_i_li">
					<img src="img/serach.png" id="search_i" alt="search_i">
				</li>
				<li id="all_menu_li">
					<img src="img/all_menu.png" id="all_menu_i" alt="all_menu_i">
				</li>
				<li id="first_right_li">
					join | login
				</li>
			</ul>
			<ul id="top_second">
				<li id="second_button_li"><button id="second_button1" class=”btn btn-default“>ticket</button></li>
				<li id="second_button_li"><button id="second_button2" class=”btn btn-default“>ticket</button></li>
				<li id="second_button_li"><button id="second_button3" class=”btn btn-default“>ticket</button></li>
			</ul>
			<div id="top_third">
				유럽 > <select>
					<option>uk</option>
					<option>france</option>
					<option>italy</option>
					<option>germany</option>
					<option>russia</option>
					<option>sweden</option>
				</select>
			</div>
			<div id="top_fourth">
				<span id="country_name_span">United Kingdom</span>
			</div>
		</div>
	</header>
	
	<div id="content">
		<aside>
			<div id="side">
				<span id="side_name">UK</span><br>
				
				<ul id="side_ul">
					<li id="side_ul_now">공지사항</li>
					<li>Q & A</li>
				</ul>
			</div>
		</aside>
		<section>
			<div id="main">
				<p>장소 등록</p>
			<form action="addPlaceProc.jsp">
				<table id="form">
					<tr>
						<td colspan=2 align=right>
							<input type=button value="장소 목록" onClick="location.hrfe='placeList.jsp'">
						</td>
					</tr>
					<tr>
						<th width=100>장소 이름</td>
						<td width=530 align=left><input type=text size=10 maxlength=10 name=pName></td>
						
						<th>장소 id</th>
						<td><input type=text size=10 maxlength=10 name=pId></td>
					</tr>
					<tr>
						<th width=100>나라이름</td>
						<td width=530 align=left>
							<select name=cId>
								<option value=uk>uk</option>
							</select>
							<input type=text size=10 maxlength=10 name=cId>
						</td>
						
						<th>장소 id</th>
						<td><input type=text size=10 maxlength=10 name=pId></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea rows="13" cols="40" name=content></textarea></td>
					</tr>
					<tr>
						<td colspan=2 align=center>
							<input type=submit value="등록">
							<input type=reset value="다시작성">
							<input type=button value="취소">
						</td>
					</tr>
				</table>
			</form>
			</div>
		</section>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ETRIP</title>
	<link rel="stylesheet" href="css/bootstrap.css">
	<style>
		html, body{
			position: absolute;
			width : 100%;
			height : 100%; 
			margin : 0 auto;
			padding : 0;
		}
		#top{
			position : relative;
			top : 0;
			left : 0;
		    width:100%;
		    height:150px;
		}
		#top_i{
			position : absolute;
			top : 0;
			left : 0;
			width : 100%;
			height : 150px;
			
			
			animation: fadein 6s;
			-webkit-animation: fadein 6s;
			animation-iteration-count : infinite;
		}
		#mainImage{
			width : 100%;
			height : 150px;
		}
		@keyframes fadein {
			0% {opacity:0.03;}
			5% {opacity:1;}
			95% {opacity:1;}
			100% {opacity:0.03;}
		}
		@-webkit-keyframes fadein { 
			0% {opacity:0.03;}
			5% {opacity:1;}
			95% {opacity:1;}
			100% {opacity:0.03;}
		}
		#overlayer{
			position : absolute;
			top : 0;
			left : 0;
			width : 100%;
			height : 600px;
			background-color:white;
			background-color: rgba( 255, 255, 255, 0.2 );
		}
		#top_first{
			position : absolute;
			top : 0;
			left : 0;
			width : 100%;
			hegiht : 200px;
		}
		#logo_i{
			width : 150px;
			
		}
		#top_first_table{
			width : 100%;
			height : 150px;
			margin : 0 auto;
		}
		#search_i{
			height:60px;
			margin:0;
			padding:0;
		}
		#login_name_th{
			line-height : 75px;
		}
		#login_name{
			width : 95%;
			height : 80px;
			text-align : right;
			font-size : 25px;
			color : withe;
		}
		#login_button, #join_button{
			width : 90px;
			height : 50px;
			line-height : 30px;
			margin : 0 auto;
			border-radius : 10px;
			font-size : 18px;
		}
		#logout_button{
			width : 110px;
			height : 50px;
			line-height : 30px;
			margin : 0 auto;
			border-radius : 10px;
			font-size : 18px;
		}
		
		#top_second{ 
			position : absolute;
			top : 170px;
		    width:100%;
		    height:80px;
		    margin:0 auto;
		}
		#top_second table{
			width : 100%;
			height : 80px;
			margin : 0 auto;
			line-height: 60px;
		}
		#top_second table button{
			width : 175px;
			height : 60px;
			font-size : 20px;
		}
		#top_third{ 
			position : absolute;
			top : 250px;
		    width:100%;
		    height:80px;
		    margin:0 auto;
		}
		#top_third table{
			width : 100%;
			height : 80px;
			margin : 0 auto;
			line-height: 60px;
		}
		#top_third table th{
			font-size : 20px;
			text-shadow : 0 0 1px black;
		}
		#top_fourth{ 
			position : absolute;
			top : 480px;
		    width:100%;
		    height:80px;
		    margin:0 auto;
			font-size : 45px;
			font-weight : bold;
			text-align : center;
		}
		a{
			color : black;
		}
		a:hover{
			color : #0174DF
		}
	</style>
	<script type="text/javascript" src="js/fun_script.js">
	</script>
	<script type="text/javascript">
		function logout_script(){
			<%
			session.removeAttribute("uId");%>
			alert("logout");
			location.replace("main1.jsp");
		}
	</script>
<body>
	<header>
		<div id="top">
			<div id="top_first">
				<table id="top_first_table">
					<tr>
						<td width=150px> 
							<img src="img/logo.png" id="logo_i" onClick="go_main()">
						</td>
						<td width=300px>
        					<input type=text name="search_text" class="form-control" id="search_text" placeholder="search text">
        				</td>
        				<td>
        					<img src="img/serach.png" id="search_i" alt="search_i" onClick="preSearch()">
        				</td>
        	<%
				if(uId != null){
			%>
					<th width=300px id="login_name_th">
						<div id="login_name"><a href="myPage.jsp?uId=<%=uId %>" ><%=uId %> 님</a></div>
					</th>
					<th width=120px>
						<button id="logout_button" onClick="logout_script()" class="btn btn-danger" >로그아웃</button>
					</th>
			<%
				}else{
			%>
					<th width=100px>
						<button id="login_button" onClick="location.href='login.jsp'" class="btn btn-primary" >login</button>
					</th>
					<th width=100px>
						<button id="join_button" onClick="location.href='join.jsp'" class="btn btn-secondary">join</button>
					</th>
			<%} %>
					</tr>
				</table>
			</div>
		</div>
		<script>
		</script>
	</header>
</body>
</html>
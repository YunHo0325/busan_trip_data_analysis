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
		    height:700px;
		}
		#top_i{
			position : absolute;
			top : 0;
			left : 0;
			width : 100%;
			height : 700px;
			
			
			animation: fadein 6s;
			-webkit-animation: fadein 6s;
			animation-iteration-count : infinite;
		}
		#mainImage{
			width : 100%;
			height : 700px;
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
		
		#top_first{
			position : absolute;
			top : 0;
			left : 0;
			width : 100%;
			hegiht : 200px;
		}
		#logo_i{
			width : 200px;
			
		}
		
		#search{ 
			position : absolute;
			top : 350px;
		    width:100%;
		    height:100px;
		    margin:0 auto;
		}
		#search_table{
			width : 600px;
			height : 100px;
			margin : 0 auto;
		}
		#search_table input[type=text]{
			width : 540px;
			height : 80px;
			font-size : 20px;
			padding : 10px;
		}
		#search_i{
			height:60px;
			margin:0;
			padding:0;
		}
		
		#login_div{ 
			position : absolute;
			top : 455px;
		    width:100%;
		    height:100px;
		    margin:0 auto;
		}
		#login_table{
			width : 450px;
			height : 100px;
			margin : 0 auto;
			line-height: 80px;
		}
		#login_table td{
			vertical-align : center;
		}
		#login_name{
			width : 225px;
			height : 80px;
			text-align : center;
			font-size : 25px;
			color : withe;
		}
		#login_button, #logout_button, #join_button{
			width : 200px;
			height : 60px;
			line-height : 40px;
			margin : 0 auto;
			border-radius : 50px;
			font-size : 20px;
		}
		a{
			color : black;
		}
		a:hover{
			color : #0174DF
		}
	</style>
	<script type="text/javascript" src="fun_script.js">
	</script>
	<script type="text/javascript">
		function logout_script(){
			alert("logout");
			location.replace("main1.jsp");
		}
	</script>
<body>
	<header>
		<div id="top">
			<div id="top_i">
				<img src="img/top1/img1.jpg" id="mainImage" >
			</div>
			<div id="top_first">
				<img src="img/logo.png" id="logo_i" onClick="location.href='admin_user.jsp'">
			</div>
    		<div id="search">
        		<table id="search_table">
        			<tr>
        				<td>
        					<input type=text name="search_text" class="form-control" id="search_text" placeholder="search text">
        				</td>
        				<td>
        					<img src="img/serach.png" id="search_i" alt="search_i" onClick="preSearch()">
        				</td>
        			</tr>
        		</table>
	    	</div>
	    	<div id="login_div">
	    		<table id="login_table">
					<tr>
						<th>
							<div id="login_name">Admin 님</div>
						</th>
						<th>
							<button id="logout_button" onClick="logout_script()" class="btn btn-danger" >로그아웃</button>
						</th>
					</tr>
	    		</table>
	    	</div>
		</div>
		<script>
			var myImage=document.getElementById("mainImage");
			var imageArray=["img/top1/img2.jpg","img/top1/img3.jpg","img/top1/img4.jpg","img/top1/img5.jpg", "img/top1/img6.jpg","img/top1/img7.jpg", "img/top1/img1.jpg"];
			var imageIndex=0;
			var i=5;

			function changeImage(){
				myImage.setAttribute("src",imageArray[imageIndex]);
				if(imageIndex == 4 || imageIndex == 0 || imageIndex == 1 || imageIndex == 3){
					var logoImg = document.getElementById("logo_i");
					logoImg.src = "img/logo2.png";
				}else{
					var logoImg = document.getElementById("logo_i");
					logoImg.src = "img/logo.png";
				}
				imageIndex++;
				if(imageIndex>=imageArray.length){
					imageIndex=0;
				}
				if(imageIndex == 5 || imageIndex == 1 || imageIndex == 6 ||imageIndex == 4 || imageIndex == 3){
					var userName = document.getElementById("login_name");
					userName.style.color = "white";
				}else{
					var userName = document.getElementById("login_name");
					userName.style.color = "black";
				}
			}
			setInterval(changeImage,6000);
		</script>
	</header>
</body>
</html>
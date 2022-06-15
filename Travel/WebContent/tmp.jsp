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
		    height:600px;
		}
		#top_i{
			position : absolute;
			top : 0;
			left : 0;
			width : 100%;
			height : 600px;
			
			
			animation: fadein 6s;
			-webkit-animation: fadein 6s;
			animation-iteration-count : infinite;
		}
		#mainImage{
			width : 100%;
			height : 600px;
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
			background-color: rgba( 255, 255, 255, 0.3 );
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
		#login_name{
			width : 225px;
			height : 80px;
			text-align : center;
			font-size : 25px;
			color : withe;
		}
		#login_button, #logout_button, #join_button{
			width : 90px;
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
			<div id="overlayer">
			</div>
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
				if(request.getParameter("uId") != null){
			%>
					<th width=100px>
						<div id="login_name"><%=request.getParameter("uId") %> 님</div>
					</th>
					<th width=100px>
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
	    	<div id="top_second">
	    		<table>
	    			<tr>
	    				<td width=1%></td>
	    				<td width=180px>
	    					<button id="second_button1" class="btn btn-dark">항공권</button>
	    				</td>
	    				<td width=180px>
	    					<button id="second_button1" class="btn btn-dark">숙박</button>
	    				</td>
	    				<td width=180px> 
	    					<button id="second_button1" class="btn btn-dark">티켓</button>
	    				</td>
	    				<td>
	    				</td>
	    			</tr>
	    		</table>
	    	</div>
	    	<div id="top_third">
	    		<table>
	    			<tr>
	    				<td width=1%></td>
	    				<th width=70px>유럽 </th>
	    				<th width=50px> > </th>
	    				<td width=170px>
	    					<select onchange="window.open(value,'_self');" class="custom-select">
	    						<option>나라</option>
								<option value="country_main.jsp?cId=100&uId=<%=request.getParameter("uId") %>">UK</option>
								<option value="country_main.jsp?cId=200&uId=<%=request.getParameter("uId") %>">France</option>
								<option value="country_main.jsp?cId=500&uId=<%=request.getParameter("uId") %>">Italia</option>
								<option value="country_main.jsp?cId=600&uId=<%=request.getParameter("uId") %>">Germany</option>
								<option value="country_main.jsp?cId=300&uId=<%=request.getParameter("uId") %>">Russia</option>
								<option value="country_main.jsp?cId=400&uId=<%=request.getParameter("uId") %>">Sweden</option>
							</select>
	    				</td>
	    				<td></td>
	    			</tr>
	    		</table>
			</div>
			<div id="top_fourth">
				<span>UK</span>
			</div>
		</div>
		<script>
			var myImage=document.getElementById("mainImage");
			var loc = document.getElementById("");
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
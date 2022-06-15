<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "place.*" %>
<%@ page import = "country.*" %>
<%@ page import = "city.*" %>
<%@ page import = "java.util.*" %>

<%
	String uId = "";
	if(request.getParameter("uId") != null)
		uId = request.getParameter("uId");

	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.searchMembers("uId", uId);
	MemDataBean searchMember = memList.get(0);
	

	PlaceDBBean placeBean = PlaceDBBean.getInstance();

	WishDBBean wishBean = WishDBBean.getInstance();
	
	List<WishDataBean> wishList = wishBean.getWish(uId);
	
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
			border : solid;
			display:table;
			width:1500px;
			height : 1500px;
			margin: 0 auto;
			padding : auto;
			text-align : center;
			
			position : relative;
			top : 600px;
			left : 0;
		}
		aside{
			width:20%;
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
		
		
		section{
			margin : 0 auto;
		}
		#main{
			display:table-cell;
			border-spacing:0;
			width:80%;
			height : 1500px;
			display:table-cell;
			padding: 50px 10px;
			margin : 0 auto;
			text-align : left;
		}
		#main_ul{
			border : solid;
			list-style:none;
			width : 100%;
			height : 100%;
			line-height:30px;
			padding:0;
			margin:0;
		}
		#main_ul li{
			border : solid;
			width : 1100px;
			height : 500px;
			text-align : left;
			margin:0;
			padding:10px;
		}
		#userInfo{
			border : solid;
			width : 100%;
			height : 470px;
			font-size : 20px;
		}
		#userInfo th{
			text-align : center;
			font-size : 23px;
		}
		#userInfo td{
			padding : 5px;
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
		#place_ul{
			list-style:none;
			width : 1500px;
			height : 1000px;
			line-height:45px;
			padding:0;
			margin:10px 0 0 10px;
			font-size : 18px;
			text-shadow : 0 0 1px black;
		}
		#place_ul li{
			border : solid;
			display : inline;
			float : left;
			width: 250px;
			height:350px;
			text-align : center;
			margin:0 0 0 10px;
			padding: 10px 0 0 0;
		}
		#element{
			width : 100%;
		}
		#element_name{
			font-size : 20px;
			padding : 10px 10px 0 10px;
		}
		#element_name img
		{	
			width : 33px;
			height : 33px;
			margin : 0 10px 0 0;
			float : right;
		}
		#element_explain, #element_hashtag, #element_grade{
			font-size : 15px;
			padding : 0 10px;
		}
		#place_ul input[type=button]{
			height : 35px;
			line-height : 31px;
		}
	</style>
	<script type="text/javascript">
		function wish_f(){
			
			var thisEle = event.target;
			if(thisEle.src=="http://39.115.48.106:8085/Travel/img/heart.png"){
				var paraUId = document.getElementById("uId").value;
				var paraPId = thisEle.alt;
				var paraCId = document.getElementById("cId").value;
				window.location.href="wishAdd.jsp?uId="+paraUId+"&pId="+paraPId+"&cId="+paraCId;
				document.getElementById("heart_i").src="img/heart_after.png";			
			}
			else if(thisEle.src=="http://39.115.48.106:8085/Travel/img/heart_after.png"){
				var paraUId = document.getElementById("uId").value;
				var paraPId = thisEle.alt;
				var paraCId = document.getElementById("cId").value;
				window.location.href="wishAdd.jsp?uId="+paraUId+"&pId="+paraPId+"&cId="+paraCId;
				document.getElementById("heart_i").src="img/heart.png";	
			}
		}
	</script>
</head>
<body>
	<div id="content">
		<aside>
			<div id="side">
				<span id="side_name">ADMIN</span><br>
				
				<ul id="side_ul">
					<li id="side_ul_now">사용자 관리</li>
					<li>여행지 관리</li>
					<li>고객센터</li>
				</ul>
			</div>
		</aside>
		<section>
			<div id="main">
				<ul id="main_ul">
					<li>
						<table id="userInfo">
							<tr>
								<th rowspan=2 width=150px>
									<img src="<%=searchMember.getImg() %>" id="profile_i">
								</th>
								<td height=15% style="vertical-align:bottom">
									<%=searchMember.getuName() %>
								</td>
							</tr>
							<tr>
								<td height=15% style="vertical-align:top">@ <%=searchMember.getuId() %></td>
							</tr>
							<tr>
								<th>age</th>
								<td><%=searchMember.getAge() %></td>
							</tr>
							<tr>
								<th>sex</th>
								<td><%=searchMember.getSex() %></td>
							</tr>
							<tr>
								<th>e-mail</th>
								<td><%=searchMember.getEmail() %></td>
							</tr>
							<tr>
								<th>phone</th>
								<td><%=searchMember.getPhone() %></td>
							</tr>
							<tr>
								<th>reg_Date</th>
								<td><%=searchMember.getReg_date() %></td>
							</tr>
						</table>
					</li>
					<li id="wish_li">
					 	<h3>위시리스트</h3>
						<ul id="place_ul">
<%
		if(wishList != null){
			for(int i=0; i<wishList.size(); i++){
				WishDataBean wish = wishList.get(i);
				
				List<PlaceDataBean> placeList = placeBean.detailPlace(wish.getpId());
				if(placeList != null){
					System.out.println(wish.getpId());
					for(int j=0; j<placeList.size(); j++){
						PlaceDataBean place = placeList.get(j);
%>
					<li>
					<table id="element">
						<tr height=80px >
							<th width=400px style="text-align:center;">
								<img src="<%=place.getpImg() %>" width=200px height=130px alt="place1">
							</th>
						</tr>
						<tr>
							<th id="element_name">
								<a href="placeDetail.jsp?uId=<%=request.getParameter("uId") %>&cId=<%=place.getcId() %>&pId=<%=place.getpId() %>"><%=place.getpName() %></a>									
<%
								if(uId.equals("null") || uId == null){%>
									<img src="img/heart.png" id="heart_i" width=33px onClick="not_login()">
<%
								}else{
%>									
									<input type="hidden" id="uId" value="<%=uId %>">
									<input type="hidden" id="cId" value="<%=place.getcId() %>">
									<img src="img/heart_after.png" id="heart_i" width=33px alt="<%=place.getpId() %>" onClick="wish_f()">
<%
								}
%>
							</th>
						</tr>
						<tr height=40px>
							<td id="element_hashtag">
<%
			HashTagDBBean hashTagBean = HashTagDBBean.getInstance();
			List<HashTagDataBean> hashTagList = hashTagBean.detailHashTags(place.getpId());
			int random[] = new int [6];
			
			for(int k=0; k<5; k++){
				random[k] = (int)(Math.random()*hashTagList.size());
				for(int l=0; l<k; l++){
					if(random[k] == random[l]){
						k--;
						break;
					}
				}
			}
			for(int k=0; k<5; k++){
				HashTagDataBean hashTag = hashTagList.get(random[k]);
%>
								<input type="button" value="#<%=hashTag.getHashTag() %>">	
<%} %>						
							</td>
						</tr>
						<tr height=50px>
<%
			GradeDBBean gradeBean = GradeDBBean.getInstance();
			List<GradeDataBean> gradeList = gradeBean.getGrades(place.getpId());
			int sum=0;
			float avg=0;
			if(gradeList != null){
				for(int k=0; k<gradeList.size(); k++){
					GradeDataBean grade = gradeList.get(k);
					sum += grade.getpGrade();
				}
				avg = (float)sum/gradeList.size();
			}
%>
							<td id="element_grade">평점 <%=avg %></td>
						</tr>
					</table>
					</li>
<%
	}}}}
%>
				</ul>
				</li>
				</ul>
			</div>
		</section>
	</div>
	<footer>
	
	</footer>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>


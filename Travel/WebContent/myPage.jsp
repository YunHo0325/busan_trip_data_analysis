<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "place.*" %>
<%@ page import = "country.*" %>
<%@ page import = "city.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String uId="";
	if(request.getParameter("uId") != null)
	   uId=request.getParameter("uId");

	
	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.searchMembers("uId", uId);
	MemDataBean searchMember = memList.get(0);
	List<MemDataBean> memList2 = dbBean.searchMembers("uId", uId);
	MemDataBean member = memList2.get(0);

	PlaceDBBean placeBean = PlaceDBBean.getInstance();

	WishDBBean wishBean = WishDBBean.getInstance();

	
	List<WishDataBean> wishList = wishBean.getWish(uId);

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

		section{
			margin : 0 auto;
		}
		#main{
			display:table-cell;
			border-spacing:0;
			width:1600px;
			height : 1500px;
			margin : 0 auto;
			text-align : left;
		}
		#sub_title{
			width: 100%;
			height : 70px;
			vertical-align:bottom;
		}	
		#edit_span{
			text-align : right;
			vertical-align:bottom;
			margin : auto;
			padding : auto;
		}
		#subject{
			font-size : 40px;
			width : 500px;
			vertical-align:bottom;
		}
		#main_ul{
			list-style:none;
			width : 100%;
			height : 500px;
			line-height:30px;
			padding:0;
			margin:0;
		}
		#main_ul li{
			height : 500px;
			text-align : left;
			margin:0;
			padding:10px;
		}
		#userInfo{
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
		#place_table{
			width : 100%;
			height : 1000px;
		}
		#place_ul{
			list-style:none;
			width : 98%;
			height : 1000px;
			padding:0;
			margin:10px 0 0 10px;
			font-size : 18px;
			text-shadow : 0 0 1px black;
		}
		#place_ul li{
			display : inline;
			float : left;
			width: 280px;
			height:370px;
			text-align : center;
			margin:0 0 0 10px;
			padding: 10px 0 0 0;
		}
		#element{
			text-align : left;
			width : 280px;
			hegiht : 350px;
		}
		#element th{
			text-align : left;
			padding : 0 0 0 10px;
		}
		#element_name{
			font-size : 20px;
		}
		#element_heart img
		{	
			width : 33px;
			height : 33px;
			margin : 0 10px 0 0;
			float : right;
		}
		#element_explain, #element_hashtag, #element_grade{
			font-size : 15px;
		}
		#element_hashtag{
			text-align : left;
			padding : 0 10px;
		}
		#place_ul input[type=button]{
			height : 35px;
			line-height : 20px;
			margin : 5px;
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
		<section>
			<div id="main">
				<table id="sub_title">
					<tr>
						<td width=18%></td>
						<th id="subject" width=500px>마이페이지</th>
						<td id="edit_span">
							<input type=button value="편집" class="btn btn-info" id="edit" onClick="location.href='memUpForm.jsp?uId=<%=searchMember.getuId()%>'">
							<input type=button value="탈퇴" class="btn btn-danger" id="exit" onClick="exit_script()">
						</td>
						<td width=18%></td>
					</tr>
				</table>
				<table id="main_ul">
					<tr>
						<td width=18%></td>
						<td>
						<table id="userInfo" class="table">
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
								<th>나이</th>
								<td><%=searchMember.getAge() %></td>
							</tr>
							<tr>
								<th>성별</th>
								<td><%=searchMember.getSex() %></td>
							</tr>
							<tr>
								<th>e-mail</th>
								<td><%=searchMember.getEmail() %></td>
							</tr>
							<tr>
								<th>phone</th>
								<%
									if(searchMember.getPhone() != null){
								%>
								<td><%=searchMember.getPhone() %></td>
								<%}else{ %>
								<td>없음</td>
								<%} %>
							</tr>
							<tr>
								<th>등록일</th>
								<td><%=searchMember.getReg_date() %></td>
							</tr>
						</table>
					</td>
						<td width=18%></td>
					</tr>
					</table>
					<table id="place_table" >
					<tr>
					<td width=18%></td>
					<td>
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
						<tr>
							<td colspan=2 height=150px >
								<img src="<%=place.getpImg() %>" width=260px height=150px alt="place1">
							</td>
						</tr>
						<tr height=50px>
							<th id="element_name">
								<a href="placeDetail.jsp?uId=<%=request.getParameter("uId") %>&cId=<%=place.getcId() %>&pId=<%=place.getpId() %>"><%=place.getpName() %></a>									
							</th>
							<td id="element_heart">
<%
									if(wishList != null){
										wish = wishList.get(0);	
	%>
										<input type="hidden" id="uId" value="<%=uId %>">
										<img src="img/heart_after.png" width=33px id="heart_i" alt="<%=place.getpId() %>" onClick="wish_f()">
	<%								}else{
	%>									
										<input type="hidden" id="uId" value="<%=uId %>">
										<img src="img/heart.png" width=33px id="heart_i" alt="<%=place.getpId() %>" onClick="wish_f()">	
	<%} 
								
%>

							</td>
						</tr>
						<tr>
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
							<td height=15px colspan=2 id="element_grade">평점 <%=avg %></td>
						
						</tr>
						<tr>
							<td id="element_hashtag" colspan=2>
<%
			HashTagDBBean hashTagBean = HashTagDBBean.getInstance();
			List<HashTagDataBean> hashTagList = hashTagBean.detailHashTags(place.getpId());
			int random[] = new int [4];
			
			for(int k=0; k<4; k++){
				random[k] = (int)(Math.random()*hashTagList.size());
				for(int l=0; l<k; l++){
					if(random[k] == random[l]){
						k--;
						break;
					}
				}
			}
			for(int k=0; k<4; k++){
				HashTagDataBean hashTag = hashTagList.get(random[k]);
%>
								<input type="button" class="btn btn-primary" value="#<%=hashTag.getHashTag() %>" onClick="search_script()">	
<%} %>						
							</td>
						</tr>
					</table>
					</li>
<%
	}}}}
%>
				</ul>
				</td><td width=18%></td></tr>
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


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "transport.*" %>
<%@ page import = "place.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String uId = (String)session.getAttribute("uId");

	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.searchMembers(uId);
	MemDataBean member = null;
	if(memList != null)
		 member = memList.get(0);

	String GUGUN_NM = null;
	if(request.getParameter("GUGUN_NM") != null){
		GUGUN_NM = request.getParameter("GUGUN_NM");
	}

	PlaceDBBean placeBean = PlaceDBBean.getInstance();
	List<PlaceDataBean> GUGUNList = placeBean.getGUGUN();
	
	PlaceDBBean dbBean2 = PlaceDBBean.getInstance();
	
	List<PlaceDataBean> placeList = null;
	if(GUGUN_NM.equals("all"))
		placeList = dbBean2.getAllPlaces();
	else
		placeList = dbBean2.getPlaces(GUGUN_NM);
	
	WishDBBean wishBean = WishDBBean.getInstance();
	
%>

<%@ include file = "top2.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="css/bootstrap.css">
	<style>
		<%@ include file="asideCss.jsp" %>
		section{
			margin : 0 auto;
		}
		#main{
			display:table-cell;
			border-spacing:0;
			width:1200px;
			height : 2000px;
			display:table-cell;
			padding: 50px 10px;
			margin : 0 auto;
			text-align : left;
		}
		#menu_name{
			font-size : 30px;
		}
		
		#place_ul{
			width : 90%;
			line-height:45px;
			padding:0;
			margin:10px 0 0 10px;
			font-size : 18px;
			text-shadow : 0 0 1px black;
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
		
		a{
			color : black;
		}
		a:hover{
			color : #0174DF;
			 text-decoration:none;
		}
	</style>
	<script type="text/javascript" src="js/fun_script.js">
	</script>
	
	<script>
		function changeArea(){
		    var langSelect = document.getElementById("select_local");
		    var selectValue = langSelect.options[langSelect.selectedIndex].value;
		    
		    var url = "place.jsp?GUGUN_NM="+selectValue;
			location.href=url;
		}
	</script>
</head>
<body>
	<div id="content">
		<aside>
			<div id="side">
				<div id="side_name"><%=GUGUN_NM %></div><br>
				
				<ul id="side_ul">
					<li onClick="location.href='country_main.jsp'">홈</li>
					<%-- <li onClick="location.href='countryDetail.jsp?GUGUN_NM=<%=GUGUN_NM %>'">기본정보</li> --%>
					<li onClick="location.href='place.jsp?GUGUN_NM=<%=GUGUN_NM %>'" id="side_ul_now">명소</li>
				</ul>
			</div>
		</aside>
		<section>
			<div id="main">
				<span id="menu_name">명소</span><br>
				<select id="select_local" class="custom-select" onchange="changeArea()">
					<option value="all">전체</option>
<%
	if(GUGUNList != null){
		for(int i=0; i<GUGUNList.size(); i++){
			PlaceDataBean g = GUGUNList.get(i);
			if(g.getGUGUN_NM().equals(GUGUN_NM)){
%>				
					<option value="<%=g.getGUGUN_NM() %>" selected><%=g.getGUGUN_NM() %></option>
<%
			}else{
%>
					<option value="<%=g.getGUGUN_NM() %>"><%=g.getGUGUN_NM() %></option>
<%
			}
	}}
%>
				</select>
				<table id="place_ul" class="table">
				<tr>
<%	
	if(placeList != null){
		for(int i=0; i<placeList.size(); i++){
			PlaceDataBean place = placeList.get(i);
%>
					
				<td>
					<table id="element" class="">
						<tr height=80px>
							<th rowspan=5 width=400px>
								<img src="<%=place.getImg() %>" width=400px height=250px alt="place1">
							</th>
							<th id="element_name">
								<a href="placeDetailProc.jsp?pId=<%=place.getpId() %>"><%=place.getPLACE_NM() %></a>									
<%
								if(uId == null || uId.equals("null")){%>
									<img src="img/heart.png" id="heart_i" onClick="not_login()">
<%
								}else{
									List<WishDataBean> wishList = wishBean.searchWish(uId, place.getpId());
									WishDataBean wish = null;
									if(wishList != null){
										wish = wishList.get(0);	
	%>
										<img src="img/heart_after.png" width=33px id="heart_i" alt="<%=place.getpId() %>" onClick="wish_f()">
	<%								}else{
	%>									
										<img src="img/heart.png" width=33px id="heart_i" alt="<%=place.getpId() %>" onClick="wish_f()">	
	<%} 
								}
%>
							</th>
						</tr>
						<tr>
							<td id="element_explain"><%=place.getETC_CN() %></td>
						</tr>
						<tr height=40px>
							<td id="element_hashtag">
<%
			HashTagDBBean hashTagBean = HashTagDBBean.getInstance();
			List<HashTagDataBean> hashTagList = hashTagBean.detailHashTags(place.getpId());
			for(int j=0; j<hashTagList.size(); j++){
				HashTagDataBean hashTag = hashTagList.get(j);
%>
								<input type="button" class="btn btn-primary" name="hashTag" value="#<%=hashTag.getHashTag() %>" onClick="search_script()">	
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
				for(int j=0; j<gradeList.size(); j++){
					GradeDataBean grade = gradeList.get(j);
					sum += grade.getpGrade();
				}
				avg = (float)sum/gradeList.size();
			}
%>
							<td id="element_grade">평점 <%=avg %></td>
						</tr>
						<tr>
<%
						TransDBBean transBean = TransDBBean.getInstance();
						int time = transBean.getTime(place.getpId());
%>						
							<td>대중교통과의 거리 : <%=time %>분</td>
						</tr>
					</table>
					</td>
					</tr>
<%
	}}
%>
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
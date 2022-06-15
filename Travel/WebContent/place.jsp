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
		
	String cId = "";
	if(request.getParameter("cId") != null){
		cId = request.getParameter("cId");
	}

	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.searchMembers("uId", uId);
	MemDataBean member = null;
	if(memList != null)
		 member = memList.get(0);
	
	
	CountryDBBean countryBean = CountryDBBean.getInstance();
	List<CountryDataBean> countryList = countryBean.detailCountry(cId);
	CountryDataBean country = null;
	if(countryList != null){
		country = countryList.get(0);
	}
	
	CityDBBean cityBean = CityDBBean.getInstance();
	List<CityDataBean> cityList = cityBean.getCities(cId);
	
	PlaceDBBean dbBean2 = PlaceDBBean.getInstance();
	List<PlaceDataBean> placeList = dbBean2.getPlaces(cId);
	
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
	<script type="text/javascript" src="fun_script.js">
	</script>
</head>
<body>
	<div id="content">
		<aside>
			<div id="side">
				<div id="side_name"><%=country.getcName() %></div><br>
<%
	if(member != null){
%>
				<ul id="side_ul">
					<li onClick="location.href='country_main.jsp?uId=<%=member.getuId() %>&cId=<%=country.getcId() %>'">홈</li>
					<li onClick="location.href='countryDetail.jsp?uId=<%=member.getuId() %>&cId=<%=country.getcId() %>'">기본정보</li>
					<li onClick="location.href='place.jsp?uId=<%=member.getuId() %>&cId=<%=country.getcId() %>'"id="side_ul_now">명소</li>
				</ul>
<%}else{%>
				<ul id="side_ul">
					<li onClick="location.href='country_main.jsp?cId=<%=country.getcId() %>'">홈</li>
					<li onClick="location.href='countryDetail.jsp?cId=<%=country.getcId() %>'">기본정보</li>
					<li onClick="location.href='place.jsp?cId=<%=country.getcId() %>'" id="side_ul_now">명소</li>
				</ul>
<%} %>
			</div>
		</aside>
		<section>
			<div id="main">
				<span id="menu_name">명소</span><br>
				<select id="local" class="custom-select">
					<option value="all">전체</option>
<%
	if(cityList != null){
		for(int i=0; i<cityList.size(); i++){
			CityDataBean city = cityList.get(i);
%>				
					<option><%=city.getCityName() %></option>
<%
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
							<th rowspan=4 width=400px>
								<img src="<%=place.getpImg() %>" width=400px height=250px alt="place1">
							</th>
							<th id="element_name">
								<a href="placeDetail.jsp?uId=<%=request.getParameter("uId") %>&cId=<%=cId %>&pId=<%=place.getpId() %>"><%=place.getpName() %></a>									
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
										<input type="hidden" id="uId" value="<%=uId %>">
										<input type="hidden" id="cId" value="<%=cId %>">
										<img src="img/heart_after.png" width=33px id="heart_i" alt="<%=place.getpId() %>" onClick="wish_f()">
	<%								}else{
	%>									
										<input type="hidden" id="uId" value="<%=uId %>">
										<input type="hidden" id="cId" value="<%=cId %>">
										<img src="img/heart.png" width=33px id="heart_i" alt="<%=place.getpId() %>" onClick="wish_f()">	
	<%} 
								}
%>
							</th>
						</tr>
						<tr>
							<td id="element_explain"><%=place.getpExplain() %></td>
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
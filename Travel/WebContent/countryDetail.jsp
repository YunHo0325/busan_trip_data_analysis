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
	String uId = "";
	if(request.getParameter("uId") != null){
		uId = request.getParameter("uId");
	}
	String cId = "";
	if(request.getParameter("cId") != null){
		cId = request.getParameter("cId");
	}
	String pId = "";
	if(request.getParameter("pId") != null){
		pId = request.getParameter("pId");
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

	PlaceDBBean placeBean = PlaceDBBean.getInstance();
	List<PlaceDataBean> placeList = placeBean.getPlaces(cId);
	
	WishDBBean wishBean = WishDBBean.getInstance();
%>


<%@ include file="top2.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main</title>
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
		#table{
			width : 1100px;
		}
		#table th{
			width : 200px;
			height : 60px;
		}
		#explain{
			height : 180px;
			line-height:35px;
		}
		#place_ul input[type=button]{
			height : 35px;
			line-height : 31px;
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
		#line{
         border-left:0.1em solid #045FB4;
         padding: 1em;
         
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
				<span id="side_name"><%=country.getcName() %></span><br>
				
<%
	if(member != null){
%>
				<ul id="side_ul">
					<li onClick="location.href='country_main.jsp?uId=<%=member.getuId() %>&cId=<%=country.getcId() %>'">홈</li>
					<li id="side_ul_now" onClick="location.href='countryDetail.jsp?uId=<%=member.getuId() %>&cId=<%=country.getcId() %>'">기본정보</li>
					<li onClick="location.href='place.jsp?uId=<%=member.getuId() %>&cId=<%=country.getcId() %>'">명소</li>
				</ul>
<%}else{%>
				<ul id="side_ul">
					<li onClick="location.href='country_main.jsp?cId=<%=country.getcId() %>'">홈</li>
					<li onClick="location.href='countryDetail.jsp?cId=<%=country.getcId() %>'"  id="side_ul_now">기본정보</li>
					<li onClick="location.href='place.jsp?cId=<%=country.getcId() %>'">명소</li>
				</ul>
<%} %>
			</div>
		</aside>
		<section>
			<div id="main">
				<span id="menu_name">기본정보</span><br>
				<br>
				<table id="table" width=800px>
					<tr>
						<th colspan=2 style="font-size:30px"><%=country.getcName() %></th>
					</tr>
					<tr>
						<th>
							수도
						</th>
						<td>
							<%=country.getCapital() %>
						</td>
					</tr>
					<tr>
						<th>
							대통령(국왕)
						</th>
						<td>
							<%=country.getPresident() %>
						</td>
					</tr>
					<tr>
						<th>
							인구 수
						</th>
						<td>
							약 <%=country.getPeople() %> 만 명
						</td>
					</tr>
					<tr>
						<td colspan=2 id="explain">
							<p id="line"/>
							<%=country.getExplanation() %>
						</td>
					</tr>
					<tr>
						<th>
							전압
						</th>
						<td>
							<%=country.getVolt() %>
						</td>
					</tr>
					<tr>
						<th colspan=2>
							주요 여행지
						</th>
					</tr>
					<tr>
						<td colspan=2>
							<table id="place_table">
					<tr>
						<td></td>
						<td width=95%>
						<ul id="place_ul">
<%
	if(placeList != null){
		for(int i=0; i<placeList.size(); i++){
			PlaceDataBean place = placeList.get(i);
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
								if(uId.equals("null") || uId == null){%>
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

							</td>
						</tr>
						<tr>
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
							<th height=15px colspan=2 id="element_grade">평점 <%=avg %></th>
						</tr>
						<tr>
							<td colspan=2 id="element_hashtag">
<%
			HashTagDBBean hashTagBean = HashTagDBBean.getInstance();
			List<HashTagDataBean> hashTagList = hashTagBean.detailHashTags(place.getpId());
			int random[] = new int [4];
			
			for(int j=0; j<4; j++){
				random[j] = (int)(Math.random()*hashTagList.size());
				for(int k=0; k<j; k++){
					if(random[k] == random[j]){
						j--;
						break;
					}
				}
			}
			for(int j=0; j<4; j++){
				HashTagDataBean hashTag = hashTagList.get(random[j]);
%>
								<input type="button" class="btn btn-primary" value="#<%=hashTag.getHashTag() %>" onClick="search_script()">	
<%} %>						
							</td>
						</tr>
					</table>
					</li>
<%
	}}
%>
				</ul>
				
						</td>
						<td></td>
					</tr>
				</table>
						</td>
					</tr>
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
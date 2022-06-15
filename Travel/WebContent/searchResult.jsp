<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "place.*" %>
<%@ page import = "transport.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String uId = (String)session.getAttribute("uId");

	String search_text = null;
	String [] hashTag_li = null;
	String hashTag_s = "";
	int searchId = 0;
	
	MemDataBean member = null;
	List<HashTagDataBean> hashTagList = null;
	
	if(request.getParameter("searchId") != null)
		searchId = Integer.parseInt(request.getParameter("searchId"));

	if(request.getParameter("search_text") != null)
		search_text = request.getParameter("search_text");


	HashTagDBBean hashTagBean = HashTagDBBean.getInstance();
	List<HashTagDataBean> tagTypeList = hashTagBean.getTagType();
	
	if(request.getParameterValues("choose") != null){
		hashTag_li = request.getParameterValues("choose");
	}

	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.searchMembers(uId);
	if(memList != null)
		 member = memList.get(0);

	PlaceDBBean dbBean2 = PlaceDBBean.getInstance();
	WishDBBean wishBean = WishDBBean.getInstance();

	if(search_text != null)
		hashTagList = hashTagBean.searchHashTags(search_text);

	if(search_text != null || hashTag_li != null)
		hashTagList = hashTagBean.searchManyHashTags(search_text, hashTag_li);
%>

<%@ include file = "top2.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="css/bootstrap.css">
	<style>
		
		section{
			margin : 0 auto;
		}
		#main{
			display:table-cell;
			border-spacing:0;
			width:1500px;
			height : 560px;
			display:table-cell;
			padding: 50px 10px;
			margin : 0 auto;
			text-align : left;
		}
		#main_content, #statistic{
			width : 1200px;
			line-height:45px;
			padding:0;
			margin: 0 auto;
		}
		#menu_name{
			font-size : 30px;
		}
		
		#place_ul{
			list-style:none;
			width : 1200px;
			line-height:45px;
			padding:0;
			margin: 0 auto;
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
	<script type="text/javascript" src="js/fun_script.js"></script>
</head>
<body>
	<div id="content">
		<section>
			<div id="main">
<%
				if(hashTag_li != null){
%>

			<div id="statistic">
				<span id="menu_name">추천 지역</span><br>
				<ul id="place_ul">
				<li>
<%
					for(int i=0; i<hashTag_li.length; i++){
%>
				<table id="element" class="table">
					<tr>
						<th><%=hashTag_li[i] %></th>
						<td>
<%
							
%>
						</td>
					</tr>
				</table>
<%
					}
%>

				</li>
				</ul>
			</div>
<%
				}
%>
			<div id="main_content">
				<span id="menu_name">명소</span><br>
				
				
				<ul id="place_ul">
				
<%			
	if(hashTagList != null){
	for(int i=0; i<hashTagList.size(); i++){
		HashTagDataBean hashTag = hashTagList.get(i);
		List<PlaceDataBean> placeList = dbBean2.detailPlace(hashTag.getpId());
%>
<%
		if(placeList != null){
			for(int j=0; j<placeList.size(); j++){
				PlaceDataBean place = placeList.get(j);
%>
					<li>
					<table id="element" class="table">
						<tr height=80px>
							<th rowspan=5 width=400px>
								<img src="<%=place.getImg() %>" width=400px height=250px alt="place1">
							</th>
							<th id="element_name">
								<a href="placeDetail.jsp?&pId=<%=place.getpId() %>"><%=place.getPLACE_NM() %></a>									
<%
								if(uId == null){%>
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
			List<HashTagDataBean> hashTagList2 = hashTagBean.detailHashTags(place.getpId());
			for(int k=0; k<hashTagList2.size(); k++){
				HashTagDataBean hashTag2 = hashTagList2.get(k);
				
%>
								<input type="button" name="hashTag" value="#<%=hashTag2.getHashTag() %>" class="btn btn-primary" onClick="search_script()">	
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
						<tr>
						TransDBBean transBean = TransDBBean.getInstance();
						int time = transBean.getTime(place.getpId());
							
							<td>도보 : <%=time %></td>
						</tr>
					</table>
					</li>
<%
	}}
%>
<%}} %>		
				</ul>
			</div>
			</div>
		</section>
	</div>
	<footer>
	
	</footer>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "place.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String uId = (String)session.getAttribute("uId");
	
	String GUGUN_NM = "";
	if(request.getParameter("GUGUN_NM") != null){
		GUGUN_NM = request.getParameter("GUGUN_NM");
	}
	
	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.searchMembers(uId);
	MemDataBean member = null;
	if(memList != null)
	    member = memList.get(0);
	
	PlaceDBBean dbBean2 = PlaceDBBean.getInstance();
	/* List<PlaceDataBean> placeList = dbBean2.getPlaces(GUGUN_NM); */
	List<PlaceDataBean> placeList = dbBean2.getAllPlaces();
	
	WishDBBean wishBean = WishDBBean.getInstance();
	
	HashTagDBBean hashTagBean = HashTagDBBean.getInstance();
	List<HashTagDataBean> tagTypeList = hashTagBean.getTagType();
%>

<%@ include file = "top2.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="css/bootstrap.css">
	<style>
	   #middle{
	      position : relative;
	      top : 30px;
	      left : 0;
	      width : 100%;
	      hegiht : 1500px;
	      margin : auto;
	   }
	   #middle_first{
	      position : absolute;
	      top : 0;
	      left : 0;
	      width : 100%;
	      hegiht : 90px;
	   
	   }
	   #middle_first table{
	      width : 100%;
	      hegiht : 60px;
	      margin : auto;
	   }
	   #menu_button1, #menu_button2, #menu_button3, #menu_button4, #menu_button5{
	      width : 98%;
	      
	      height : 60px;
	      line-height : 50px;
	   }
	   
	   #middle_third{
	      width : 100%;
	      height : 1700px;
	      padding:0;
	      margin:0;
	      vertical-align : middle;
	      
	      position : absolute;
	      top:130px;
	   }
	   #recommand_table{
	      width : 100%;
	      hegiht : 50px;
	      font-size : 20px;
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
	   #element_name2{
	      font-size : 30px;
	      padding  : 0 0 0 50px;
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
	      padding : 0 5px;
	   }
	   #place_ul input[type=button]{
	      height : 35px;
	      line-height : 20px;
	      margin : 3px 1px;
	   }
	   a{
	      color : black;
	   }
	   a:hover{
	      color : #0174DF;
	      text-decoration:none;
	   }
	   #div_recommand{
   			margin : 50px 5px;
	   }
	   #div_search{
	   		margin : 10px 70px 50px 70px;
	   }
	   #tb_serach{
	   		width : 100%;
	   }
	   #search_text{
	   		height : 50px;
	   		width : 100%;
	   }
	</style>
	<script type="text/javascript" src="js/fun_script.js">
	</script>
	<script>

	function chooseOption(){
		var tag = "btn_" + event.target.value;
		var hidden_tag = "btn_hidden_"+ event.target.value;
		var btn_name = document.getElementById(tag).getAttribute('name');
		var btn_value = document.getElementById(tag).getAttribute('value');
		var btn_class = document.getElementById(tag).getAttribute('class');
		
		if(btn_class == "btn btn-outline-primary"){
			//document.getElementById(tag).setAttribute("name", "choose");
			document.getElementById(hidden_tag).setAttribute("name", "choose");
			document.getElementById(tag).setAttribute("class", "btn btn-primary");
		}
		else{
			//btn_name = btn_name.replace("_choose", "");
			//document.getElementById(tag).setAttribute("name", btn_name);
			document.getElementById(hidden_tag).setAttribute("name", btn_name);
			document.getElementById(tag).setAttribute("class", "btn btn-outline-primary");
		}
		
		
	}
	</script>
</head>
<body>
	<section>
		<div id="middle">
		
		<form name="form_search" action="searchProc.jsp" method="post">
		<div id="div_search">
			<table id="tb_serach">
				<tr height=100px>
					<td colspan=2>
       					<input type=text id="search_text" name="search_text" class="form-control" id="search_text" placeholder="search text">
       				</td>
       				<td width=100px>
       					<input type=submit id="search_text" name="serach" value="검색" class="btn btn-dark" id="search_submit">
       				</td>
				</tr>
				<%
				if(tagTypeList != null){
					for(int i=0; i<tagTypeList.size(); i++){
						HashTagDataBean tagType = tagTypeList.get(i);
				%>
				<tr height="50px">
					<th width=100px><%=tagType.getTagType() %></th>
					<td  colspan=2>
					<%
						List<HashTagDataBean> tagTypeDetailList = hashTagBean.getTagTypeDetail(tagType.getTagType());
						for(int j=0; j<tagTypeDetailList.size(); j++){
							HashTagDataBean tagTypeDetail = tagTypeDetailList.get(j);
					%>
						<input type="button" id="btn_<%=tagTypeDetail.getHashTag() %>" name="<%=tagType.getTagType() %>" class="btn btn-outline-primary" value="<%=tagTypeDetail.getHashTag() %>" onClick="chooseOption()">   
						<input type="hidden" id="btn_hidden_<%=tagTypeDetail.getHashTag() %>" name="<%=tagType.getTagType() %>" value="<%=tagTypeDetail.getHashTag() %>">
					<%
						}
					%>
					</td>
				</tr>
				<%		
					}
				}
				%>
			</table>
		
		</div>
		</form>
         
         
         
        <div id="div_recommand">
			<table id="tb_title">
				<tr>
					<td width=10%></td>
					<th id="element_name2">명소</th>
				</tr>
			</table>
			<table id="tb_place">
				<tr>
					<td></td>
					<td width=90%>
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
										<img src="<%=place.getImg() %>" width=260px height=150px alt="place1">
			                     	</td>
								</tr>
                  				<tr height=50px>
                     				<th id="element_name">
			                        	<a href="placeDetailProc.jsp?pId=<%=place.getpId() %>"><%=place.getPLACE_NM() %></a>                           
			                     	</th>
                     				<td id="element_heart">
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
                             			<input type="hidden" id="GUGUN_NM" value="<%=GUGUN_NM %>">
                              			<img src="img/heart_after.png" width=33px id="heart_i" alt="<%=place.getpId() %>" onClick="wish_f()">
   <%                        			}else{
   %>                           
                              			<input type="hidden" id="GUGUN_NM" value="<%=GUGUN_NM %>">
                              			<img src="img/heart.png" width=33px id="heart_i" alt="<%=place.getpId() %>" onClick="wish_f()">   
   <%									} 
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
<%									
									} 
%>                  
                     				</td>
                  				</tr>
               			</table>
               		</li>
<%
		}
      }
%>
            	</ul>
            
				</td>
				<td></td>
			</tr>
			</table>
		</div>
      
	</div>
   </section>
   <footer>
   
   </footer>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
	<script>
		function getRecommandPlace(){
		    $.ajax({
		        url: "http://221.138.15.210:8081/place/recommand", 
		        method: "POST",
		        success : function(result){
					document.getElementById("text").innerHTML = result.result;
		        }
		    });
		}
	</script>
</body>
</html>
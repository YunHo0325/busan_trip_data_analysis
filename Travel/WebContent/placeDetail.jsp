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

   String uId = (String)session.getAttribute("uId");

   int pId = -1;
   if(request.getParameter("pId") != null){
      pId = Integer.parseInt(request.getParameter("pId"));
   }

   MemDBBean dbBean = MemDBBean.getInstance();
   List<MemDataBean> memberList = dbBean.searchMembers(uId);
   MemDataBean member = null;
   if(memberList != null){
      member = memberList.get(0);
   }
   

   PlaceDBBean placeBean = PlaceDBBean.getInstance();
   List<PlaceDataBean> placeList = placeBean.detailPlace(pId);
   PlaceDataBean place = placeList.get(0);
   String GUGUN_NM = place.getGUGUN_NM();
   
   WishDBBean wishBean = WishDBBean.getInstance();
   List<WishDataBean> wishList = wishBean.searchWish(uId, pId);
   WishDataBean wish = null;
   if(wishList != null){
      wish = wishList.get(0);   
   }
   
   
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
         height : 560px;
         display:table-cell;
         padding: 50px 10px;
         margin : 0 auto;
         text-align : left;
      }
      #menu_name{
         font-size : 30px;
      }
      #element{
         width : 100%;
      }
      #element_name{
         font-size : 20px;
         padding : 10px 10px 0 10px;
      }
      #heart_i
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
      #profile_i{
         margin : 5px 0 0 0;
         width : 80px;
         border: 3px solid black;
         border-radius: 1000px;
         -moz-border-radius: 1000px;
         -khtml-border-radius: 1000px;
         -webkit-border-radius: 1000px;
         margin : 0 auto;
      }
      
      #near {
         position: absolute;
         width: 230px;
         height: 529px;
         right: 0px;
         top: 0px;
      }
      #near_ul{
         list-style:none;
         width : 230px;
         height : 529px;
         line-height:100px;
         padding:0;
         margin:20px 0 0 20px;
         font-size : 18px;
         text-shadow : 0 0 1px black;
      }
      #near_ul img{
         width : 100%;
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
   <script type="text/javascript" src="js/fun_script.js">
   </script>
   <script>
   function star_click(){
      var thisEle = event.target;
      
      if(thisEle.id == "star1_i"){
         if(thisEle.src == "http://39.115.48.106:8085/Travel/img/star.png"){
            thisEle.src="img/star_checked.png";
            document.getElementById("star2_i").src="img/star.png";
            document.getElementById("star3_i").src="img/star.png";
            document.getElementById("star4_i").src="img/star.png";
            document.getElementById("star5_i").src="img/star.png";
            document.getElementById("pGrade").value = 1;
         }
         else if(thisEle.src == "http://39.115.48.106:8085/Travel/img/star_checked.png"){
            thisEle.src="img/star.png";
            document.getElementById("star2_i").src="img/star.png";
            document.getElementById("star3_i").src="img/star.png";
            document.getElementById("star4_i").src="img/star.png";
            document.getElementById("star5_i").src="img/star.png";
            document.getElementById("pGrade").value = 0;
         }
      }
      else if(thisEle.id == "star2_i"){
         thisEle.src="img/star_checked.png";
         document.getElementById("star1_i").src="img/star_checked.png";
         document.getElementById("star3_i").src="img/star.png";
         document.getElementById("star4_i").src="img/star.png";
         document.getElementById("star5_i").src="img/star.png";
         document.getElementById("pGrade").value = 2;
      }
      else if(thisEle.id == "star3_i"){
         thisEle.src="img/star_checked.png";
         document.getElementById("star1_i").src="img/star_checked.png";
         document.getElementById("star2_i").src="img/star_checked.png";
         document.getElementById("star4_i").src="img/star.png";
         document.getElementById("star5_i").src="img/star.png";
         document.getElementById("pGrade").value = 3;
      }
      else if(thisEle.id == "star4_i"){
         thisEle.src="img/star_checked.png";
         document.getElementById("star1_i").src="img/star_checked.png";
         document.getElementById("star2_i").src="img/star_checked.png";
         document.getElementById("star3_i").src="img/star_checked.png";
         document.getElementById("star5_i").src="img/star.png";
         document.getElementById("pGrade").value = 4;
      }
      else if(thisEle.id == "star5_i"){
         thisEle.src="img/star_checked.png";
         document.getElementById("star1_i").src="img/star_checked.png";
         document.getElementById("star2_i").src="img/star_checked.png";
         document.getElementById("star3_i").src="img/star_checked.png";
         document.getElementById("star4_i").src="img/star_checked.png";
         document.getElementById("pGrade").value = 5;
      }
   }
   </script>
</head>
<body>
   <div id="content">
      <aside>
         <div id="side">
            <span id="side_name"><%=place.getGUGUN_NM() %></span><br>
				<ul id="side_ul">
					<li onClick="location.href='country_main.jsp?GUGUN_NM=<%=place.getGUGUN_NM() %>'">홈</li>
					<li onClick="location.href='countryDetail.jsp?GUGUN_NM=<%=place.getGUGUN_NM() %>'">기본정보</li>
					<li onClick="location.href='place.jsp?GUGUN_NM=<%=place.getGUGUN_NM() %>'"id="side_ul_now">명소</li>
				</ul>
         </div>
      </aside>
      <section>
         <div id="main">
            <span id="menu_name">명소</span><br>
            <br>
            <table id="table">
               <tr>
                  <th width=300px style="font-size:30px"><%=place.getPLACE_NM() %></th>
                  <td style="text-align:right">
                     <input type="hidden" id="pId" value="<%=pId %>">
<%
   if(request.getParameter("uId") != null && !(request.getParameter("uId").equals("null")) ){
      if(wishList != null){
%>
                     <img src="img/heart_after.png" width=33px id="heart_i" alt="<%=place.getpId() %>" onClick="wish_f()">
<%      }else{
%>                           
                     <img src="img/heart.png" width=33px id="heart_i" alt="<%=place.getpId() %>" onClick="wish_f()">   
<%
   }}else{
%>
                     <img src="img/heart.png" id="heart_i" onClick="not_login()">
<%} %>
                  </td>
               </tr>
               <tr>
                  <td colspan=2>
                     <img src="<%=place.getImg() %>" width=800px>
                  </td>
               </tr>
               <tr>
                  <td colspan=2 height=65px>
<%
         HashTagDBBean hashTagBean = HashTagDBBean.getInstance();
         List<HashTagDataBean> hashTagList = hashTagBean.detailHashTags(place.getpId());
         for(int i=0; i<hashTagList.size(); i++){
            HashTagDataBean hashTag = hashTagList.get(i);
%>
                        <input type="button" class="btn btn-primary" value="#<%=hashTag.getHashTag() %>" onClick="search_script()">   
<%} %>                  
                  </td>
               </tr>
               <tr>
                  <td colspan=2 style="line-height:32px">
                     <p id="line"/>
                     <%=place.getETC_CN() %>
                  </td>
               </tr>
               <tr>
					<td>
						연관 관광지
					</td>
               </tr>
               <tr>
               		<td>
               			주변 편의 식당
               		</td>
               </tr>
               <tr>
               		<td>
               			소비 순위 0위
               		</td>
               </tr>
               <tr>
                  <th   colspan=2 height=60px style="font-size:23px;vertical-align:bottom;">
                     리뷰
                  </th>
               </tr>
               <tr>
                  <td colspan=2 height=200px>
                     <form action="gradeRegProc.jsp">
                        <table id="review_write" class="table">
                           <tr>
                              <td rowspan=2 width=240px style="line-height:40px">
                                 별점<br>
                                 <div id="review_star" width=240px style="text-align:center;">
                                    <img src="img/star.png" width=33px id="star1_i" onClick="star_click()">
                                    <img src="img/star.png" width=33px id="star2_i" onClick="star_click()">
                                    <img src="img/star.png" width=33px id="star3_i" onClick="star_click()">
                                    <img src="img/star.png" width=33px id="star4_i" onClick="star_click()">
                                    <img src="img/star.png" width=33px id="star5_i" onClick="star_click()">
                                 </div>
                                 <input type=hidden name=pGrade id=pGrade value=0>
                              </td>
                              <th width=600px colspan=2>
                                 제목  <input type=text name=gSubject maxLength=50 width=100px>
                              </th>
                           </tr>
                           <tr>
                              <th>
                                 내용<br>
                                 <textarea name=gContent cols=65 rows=4 maxLength=1000></textarea>
                              </th>
                              <th style="text-align:center;"> 
<%if(request.getParameter("uId") != null){
%>
                                 <input type=submit value="리뷰 작성" class="btn btn-dark" style="height:120px">
                                 <input type=hidden name="uId" value="<%=request.getParameter("uId") %>">
                                 <input type=hidden name="pId" value="<%=request.getParameter("pId") %>">
<%}else{ %>
                                 <input type=button value="리뷰 작성" class="btn btn-dark" style="height:120px" onClick="not_login()">
<%} %>
                              </th>
                           </tr>
                        </table>
                     </form>
                  </td>
               </tr>
<%
         GradeDBBean gradeBean = GradeDBBean.getInstance();
         List<GradeDataBean> gradeList = gradeBean.getGrades(place.getpId());
         int sum=0;
         float avg=0;
         if(gradeList != null){
            for(int i=0; i<gradeList.size(); i++){
               GradeDataBean grade = gradeList.get(i);
%>
<%
               List<MemDataBean> memberList2 = dbBean.searchMembers(grade.getuId());
               
               if(memberList2 != null){
                  MemDataBean member2 = memberList2.get(0);
%>
               <tr> 
                  <td colspan=2>
                     <table id="review_read" width=800px>
                        <tr height=50px>
                           <td rowspan=2 width=90px style="text-align:center;padding:5px">
                              <img src="<%=member2.getImg() %>" id="profile_i">
                           </td>
                           <th style="font-size:18px;padding:10px">
                              <%=grade.getgSubject() %>
                           </th>
                           <td  width=200px>
<%if(grade.getpGrade() == 5){ %>
                              <div id="review_star" width=150px style="text-align:center;">
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star_checked.png" width=23px>
                              </div>
<%}else if(grade.getpGrade() == 4){ %>
                              <div id="review_star" width=150px style="text-align:center;">
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star.png" width=23px>
                              </div>
<%}else if(grade.getpGrade() == 3){ %>
                              <div id="review_star" width=150px style="text-align:center;">
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star.png" width=23px>
                                 <img src="img/star.png" width=23px>
                              </div>
<%}else if(grade.getpGrade() == 2){  %>
                              <div id="review_star" width=150px style="text-align:center;">
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star_checked.png" width=23px>
                                 <img src="img/star.png" width=23px>
                                 <img src="img/star.png" width=23px>
                                 <img src="img/star.png" width=23px>
                              </div>
<%}else{ %>
                              <div id="review_star" width=150px style="text-align:center;">
                                 <img src="img/star.png" width=23px>
                                 <img src="img/star.png" width=23px>
                                 <img src="img/star.png" width=23px>
                                 <img src="img/star.png" width=23px>
                                 <img src="img/star.png" width=23px>
                              </div>
<%} %>
                           </td>
                        </tr>
                        <tr>
                           <td>
                              <%=member2.getuName() %>
<%
      if(member != null && member2 != null){
         if(member.getuId().equals(grade.getuId())){
%>
            <input type=button value="삭제" id="delete" onClick="location.href='gradeDeleteProc.jsp?pId=<%=grade.getpId() %>&uId=<%=grade.getuId() %>'">
<%
      }}
%>
                           </td>
                           <td>
                              <%=member2.getReg_date() %>
                           </td>
                        </tr>
                        <tr>
                           <td colspan=3 style="font-size:15px;padding:10px 0 10px 15px;">
                              <%=grade.getgContent() %>
                           </td>
                        </tr>
                     </table>
                  </td>
               </tr>
<%
            }
            }
         }
%>
            </table>
         </div>
         <div id="near">
            <ul id="near_ul">
<%
   List<PlaceDataBean> placeList2 = placeBean.getPlaces(place.getGUGUN_NM());
   if(placeList2 != null){
      int random[] = new int [4];
            
      for(int i=0; i<4; i++){
         random[i] = (int)(Math.random()*placeList2.size());
         for(int j=0; j<i; j++){
            if(random[i] == random[j]){
               i--;
               break;
            }
         }
      }
      for(int i=0; i<4; i++){
         PlaceDataBean place2 = placeList2.get(random[i]);
%>
               <li>
                  <table>
                     <tr>
                        <td>
                           <img src="<%=place2.getImg() %>" width=200px height=130px>
                        </td>
                     </tr>
                  </table>
               </li>
<%}} %>
            </ul>
         </div>
      </section>
   </div>
   <footer>
   
   </footer>
<script src="jquery_mini.js" type="text/javascript"></script>
<script src="jquery.dimensions.js" type="text/javascript"></script> 
<script type="text/javascript">
// <![CDATA[ 
   var name = "#near"; 
   var menuYloc = null; 
   $(document).ready(function(){ 
      menuYloc = parseInt($(name).css("top").substring(0,$(name).css("top").indexOf("px"))) 
      $(window).scroll(function () { 
         if($(document).scrollTop() < 420){
            offset = menuYloc+$(document).scrollTop()+"px"; 
         }else if($(document).scrollTop() >= 420){
            offset = menuYloc+$(document).scrollTop()-550+"px"; 
         }
         $(name).animate({top:offset},{duration:400,queue:false}); 
         }); 
      }); 
// ]]>
</script> 

   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
   <script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>
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
String uId = null;
if(request.getParameter("uId") != null){
	uId = request.getParameter("uId");
}
String pId = null;
if(request.getParameter("pId") != null){
	pId = request.getParameter("pId");
}
String cId = null;
if(request.getParameter("cId") != null){
	cId = request.getParameter("cId");
}

   MemDBBean dbBean = MemDBBean.getInstance();
   List<MemDataBean> memberList = dbBean.detailMembers(uId);
   
   MemDataBean member=null;
   if(memberList != null){
      member = memberList.get(0);
   }
   
   CountryDBBean countryBean = CountryDBBean.getInstance();
   List<CountryDataBean> countryList = countryBean.detailCountry(cId);
   CountryDataBean country = null;
   for(int i=0; i<countryList.size(); i++)
      country = countryList.get(i);
   
   CityDBBean cityBean = CityDBBean.getInstance();
   List<CityDataBean> cityList = cityBean.getCities(cId);
   
   PlaceDBBean placeBean = PlaceDBBean.getInstance();
   List<PlaceDataBean> placeList = placeBean.detailPlace(pId);
   PlaceDataBean place = placeList.get(0);
   
%>


<%@ include file="top2.jsp" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Main</title>
   <link rel="stylesheet" href="css/bootstrap.css">
   <style>
      #content{
         display:table;
         width:100%;
         height : 500px;
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
         width:1200px;
         height : 560px;
         display:table-cell;
         padding: 50px 10px;
         margin : 0 auto;
         text-align : left;
      }
      #menu_name{
         font-size : 20px;
         color : #B56E6F
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
         height: 780px;
         right: 0px;
         top: 0px;
         padding : 10px;
      }
      #near_ul{
         border : solid black;
         list-style:none;
         width : 230px;
         height : 650px;
         line-height:100px;
         padding:0;
         margin:20px 0 0 20px;
         font-size : 18px;
         text-shadow : 0 0 1px black;
      }
      #near_ul li{
         padding : 10px;   
      }
      #hashtag{
         border: 1px solid skyblue;
         background-color: rgba(0,0,0,0);
         color: skyblue;
         padding: 5px;
         border-radius: 5px;
      }
      #hashtag:hover{
         color:white;
         background-color: skyblue;
      }
      #exp{
         border-left:0.2em solid #46B4B4; padding:0.5em;
      }
      #review{
         border-radius : 3px;
         vertical-align:bottom;   
         font-size:23px;
      }
      #review_write input[type=text]{
         border : solid 1px;
         border-radius : 4px;
      }
      #review_btn{
         background-color:transparent; 
         border:1px solid; 
         border-radius:2px;
         width: 80px;
         height: 100px;
      }
      #review_btn:hover{
         background-color:#FF1493;
      }
   </style>


<style type="text/css">
</style>
</head>
<body  onload="InitializeStaticMenu();">
   <div id="content">
      <aside>
         <div id="side">
            <span id="side_name"><%=country.getcName() %></span><br>
            <ul id="side_ul">
               <li>홈</li>
               <li>기본정보</li>
               <li>지도</li>
               <li id="side_ul_now">명소</li>
            </ul>
         </div>
      </aside>
      <section>
         <div id="main">
            <span id="menu_name">명소</span><br>
            <br>
            <table id="table" width=800px>
               <tr>
                  <th width=300px style="font-size:30px"><%=place.getpName() %></th>
                  <td style="text-align:right">
                     <img src="img/heart.png" width=33px>
                  </td>
               </tr>
               <tr>
                  <td colspan=2>
                     <br>
                     <img src="<%=place.getpImg() %>" width=800px>
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
                        <input id=hashtag type="button" value="#<%=hashTag.getHashTag() %>">   
<%} %>                  
                  </td>
               </tr>
               <tr>
                  <td id=exp colspan=2 style="line-height:32px">
                     <br> <br>
                     <%=place.getpExplain() %>
                  </td>
               </tr>
               <tr>
                  <th   id=review colspan=2 height=60px>
                     <br> <br> <br> <br> <br>
                     
                     <h4>리뷰</h4>
                  </th>
               </tr>
               <tr>
                  <td colspan=2 height=200px>
                     <form action="reiewRegProc.jsp">
                        <table id="review_write" border=1 width=800px>
                           <tr>
                              <td rowspan=2 width=200px style="line-height:40px">
                                 별점<br>
                                 <div id="review_star" width=200px style="text-align:center;">
                                    <img src="img/star.png" width=33px>
                                    <img src="img/star.png" width=33px>
                                    <img src="img/star.png" width=33px>
                                    <img src="img/star.png" width=33px>
                                    <img src="img/star.png" width=33px>
                                 </div>
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
                              <th>
                                 <input type=submit value="작성" id=review_btn>
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
               List<MemDataBean> memberList2 = dbBean.searchMembers("uId", grade.getuId());
               
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
                              <div id="review_star" width=150px style="text-align:center;">
                                 <img src="img/star.png" width=23px>
                                 <img src="img/star.png" width=23px>
                                 <img src="img/star.png" width=23px>
                                 <img src="img/star.png" width=23px>
                                 <img src="img/star.png" width=23px>
                              </div>
                           </td>
                        </tr>
                        <tr>
                           <td>
                              <%=member2.getuName() %>
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
   List<PlaceDataBean> placeList2 = placeBean.getPlaces(cId);
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
      for(int i=0; i<4; i++)
         System.out.println(random[i]); 
      for(int i=0; i<4; i++){
         PlaceDataBean place2 = placeList2.get(random[i]);
%>
               <li>
                  <table>
                     <tr>
                        <td>
                           <img src="<%=place2.getpImg() %>" width=200px height=130px>
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
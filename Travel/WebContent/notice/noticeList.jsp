<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "notice.*" %>
<%@ page import = "java.util.*" %>
<%
   int pageSize = 5;   // 페이지 당 글의 갯수
   int pageBlock = 5;   // 페이지 블록 당 페이지 수
   
   String pageNum = request.getParameter("pageNum");
   
   if(pageNum == null){
      pageNum = "1";
   }
   
   int currentPage = Integer.parseInt(pageNum);
   int startRow = (currentPage - 1) * pageSize + 1;
   int endRow = currentPage * pageSize;
%>
<%
   String uId = "";
   if(request.getParameter("uId") != null)
      uId = request.getParameter("uId");
   
   MemDBBean dbBean = MemDBBean.getInstance();
   List<MemDataBean> memList = dbBean.getMembers();
   List<MemDataBean> myList = dbBean.searchMembers("uId", uId);
   MemDataBean member = null;

   if(myList != null){
      member = myList.get(0);
   }
   
   NoticeDBBean noticeBean = NoticeDBBean.getInstance();
   List<NoticeDataBean> noticeList = noticeBean.getNotices(startRow, pageSize);
   int count = noticeBean.getNoticeCount();
   int number = count - (currentPage - 1)*pageSize;
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
      #search_user_ul{
         list-style:none;
         width : 50%;
         height : 50px;
         line-height:43px;
         padding:0;
         margin:0 auto;
         text-align : center;
      }
      #filter_li{
         float : left;
         display : inline;
         width : 25%;
         height : 100%;
         padding : 0;
         margin : 0;
         text-align : center;
         color : black;
      }
      #filter{
         width : 95%;
         height : 80%;
         
         border-radius:10px;
      }
      #search_user_text_li{
         float : left;
         display : inline;
         width : 65%;
         height : 100%;
         padding : 0;
         margin : 0;
         text-align : center;
         color : black;
      }
      #search_user_text_li input[type=text]{
         width : 100%;
         height: 45px;
         border-radius:10px;
         border : 1px solid black;
      }
      #search_user_i_li{
         float : left;
         display : inline;
         width : 8.5%;
         height : 100%;
         padding : 0;
         margin : 0;
         text-align : center;
         color : black;
      }
      #search_user_ul input[type=image]{
         display : inline;
         width:100%;
         height:100%;
         text-align : center;
         margin:0 ;
         padding:0;
      }
      
      #user_table{
         width : 100%;
      }
      #paging_table{
         width : 100%;
      }
      #user_table th{
         text-align : center;
         font-size : 25px;
         height : 50px;
         vertical-align : middle;
         background:#c8c8c8;
      }
      #user_table td{
         font-size : 20px;
         
         vertical-align : middle;
         height : 50px;
      }
      #element_subject{
         padding : 0 0 0 10px;
      }
      #idx, #element, #element_option{
         text-align : center;
         padding : 0;
      }
      
      #write{
         border : solid;
         margin : 10px;
         width : 1200px;
         text-align : right;
      }
      a{
         color : black;
      }
      a:hover{
         color : #0174DF;
         text-decoration:none;
      }
   </style>
   <script type="text/javascript" src="fun_script.js"></script>
</head>
<body>
   <div id="content">
      <aside>
         <div id="side">
            <span id="side_name">고객센터</span><br>
            
<%
   if(member != null){
%>
            <ul id="side_ul">
               <li onClick="location.href='noticeList.jsp?uId=<%=member.getuId() %>'" id="side_ul_now">공지사항</li>
               <li onClick="location.href='questList.jsp?uId=<%=member.getuId() %>'">Q & A</li>
            </ul>
<%}else{ %>
            <ul id="side_ul">
               <li onClick="location.href='noticeList.jsp'" id="side_ul_now">공지사항</li>
               <li onClick="location.href='questList.jsp'">Q & A</li>
            </ul>
<%} %>
         </div>
      </aside>
      
      <section>
         <div id="main">
            <form action="noticeSearchProc.jsp">
            <input type="hidden" name="uId" value=<%=uId %>>
               <ul id="search_user_ul">
                  <li id="filter_li"><select name="filter" id="filter"  class="custom-select">
                     <option value="subject">제목</option>
                     <option value="content">내용</option>
                  </select></li>
                  <li id="search_user_text_li"><input type="text" class="form-control" name="search_text" ></li>
                  <li id="search_user_i_li">
                        <input type="image" src="img/serach.png">
                  </li>
               </ul>
            </form>
            <br>
            
            <table id="user_table" class="table">
               <tr>
                  <th width=5%>IDX</th>
                  <th>제목</th>
                  <th width=10%>조회수</th>
                  <th width=20%>등록일</th>
               </tr>
               
               <% if (noticeList != null) {%>
               <%
               for(int i=0; i<noticeList.size(); i++){
                  NoticeDataBean notice = noticeList.get(i);
               %>
               <tr>
               <%
                  if(request.getParameter("uId") != null){
               %>
                  <td id="idx">
                     <a href="noticeDetail.jsp?num=<%=notice.getnNum() %>&uId=<%=member.getuId() %>">
                        <%=count - i - pageSize*(Integer.parseInt(pageNum)-1) %>
                     </a>
                  </td>
                  <td id="element_subject">
                     <a href="noticeDetail.jsp?num=<%=notice.getnNum() %>&uId=<%=member.getuId() %>">
                        <%=notice.getSubject() %>
                     </a>
                  </td>
               <%}else{ %>
                  <td id="idx">
                     <a href="noticeDetail.jsp?num=<%=notice.getnNum() %>">
                        <%=count - i - pageSize*(Integer.parseInt(pageNum)-1) %>
                     </a>
                  </td>
                  <td id="element_subject">
                     <a href="noticeDetail.jsp?num=<%=notice.getnNum() %>">
                        <%=notice.getSubject() %>
                     </a>
                  </td>
               <%} %>
                  <td id="element" align=center><%=notice.getReadcount() %></td>
                  <td id="element"><%=notice.getReg_date() %></td>
               </tr>   
               
               <% }}else{ %>
               <%} %>   
            </table>
            <table id="paging_table">
               <tr>
                  <td></td>
<%if(member != null){ %>
                  <td align=center width=98%>
<%
   if (count > 0){
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      int startPage = 1;
      //int pageBlock = 2;
      
      if(currentPage % pageBlock != 0){
         startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
      }else{
         startPage = ((int)(currentPage/pageBlock)-1)*pageBlock + 1;
      }
      
      int endPage = startPage + pageBlock - 1;
      if (endPage > pageCount) {
         endPage = pageCount;
      }
      
      if(startPage > pageBlock){
%>
                     <a href = "noticeList.jsp?pageNum=<%=startPage - pageBlock %>&uid=<%=uId %>">[이전]</a>
<%         
      }
      
      for(int i=startPage; i <= endPage; i++){
%>
                     <a href = "noticeList?pageNum=<%=i%>&uid=<%=uId %>">[<%=i %>]</a>         
<%
      }
      
      if(endPage < pageCount){
%>
                     <a href = "noticeList?pageNum=<%=startPage + pageBlock %>&uid=<%=uId %>">[다음]</a>
<%      
      }
      
   }
%>
                  </td>

<%}else{ %>
                  <td align=center>
<%
   if (count > 0){
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      int startPage = 1;
      //int pageBlock = 2;
      
      if(currentPage % pageBlock != 0){
         startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
      }else{
         startPage = ((int)(currentPage/pageBlock)-1)*pageBlock + 1;
      }
      
      int endPage = startPage + pageBlock - 1;
      if (endPage > pageCount) {
         endPage = pageCount;
      }
      
      if(startPage > pageBlock){
%>
                     <a href = "noticeList.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</a>
<%         
      }
      
      for(int i=startPage; i <= endPage; i++){
%>
                     <a href = "noticeList?pageNum=<%=i%>">[<%=i %>]</a>         
<%
      }
      
      if(endPage < pageCount){
%>
                     <a href = "noticeList?pageNum=<%=startPage + pageBlock %>">[다음]</a>
<%      
      }
      
   }
%>
                  </td>

<%} %>
                  <td></td>
               </tr>
            </table>

            

         </div>
      </section>
      
   </div>
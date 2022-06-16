<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "place.*" %>
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
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script src="//code.jquery.com/jquery-3.5.1.min.js" ></script>
<script>
	function relatedPlace(){
	    $.ajax({
	        url: "http://221.138.15.210:8081/search/relatedPlace",  // flask 서버로 던진다.
	        method: "GET",
	        data: {pId: <%=pId %> },
	        success : function(result){
	        	document.getElementById("related_1").setAttribute("value", result.result.related_1);
	        	document.getElementById("related_2").setAttribute('value', result.result.related_2);
	        	document.getElementById("related_3").setAttribute('value', result.result.related_3);
	        	document.getElementById("related_4").setAttribute('value', result.result.related_4);
	        	document.getElementById("related_5").setAttribute('value', result.result.related_5);
				document.searchForm.submit();
	        }
	    });
	}
</script>
</head>
<body>
	<form name="searchForm" action="placeDetail.jsp" method="POST">
		<input type=hidden name="pId" value="<%=pId %>">
		
<% 
		for(int i=1; i<6; i++){
%>
			<input id="related_<%=i %>" type=hidden name="related" value="">
<%
		} 
%>
		<script>relatedPlace();</script>
	</form>


</body>
</html>
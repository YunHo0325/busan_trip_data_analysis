<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "place.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String uId = (String)session.getAttribute("uId");
	
	String [] hashTag_li = null;
	String hashTag_s = "";
	String search_text = "";

	HashTagDBBean hashTagBean = HashTagDBBean.getInstance();
	List<HashTagDataBean> tagTypeList = hashTagBean.getTagType();
	
	if(request.getParameter("search_text") != null){
		search_text = request.getParameter("search_text");
	}
	if(request.getParameterValues("choose") != null){
		hashTag_li = request.getParameterValues("choose");
	}
   
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
</head>
<script src="//code.jquery.com/jquery-3.5.1.min.js" ></script>

<body>
	<form name="searchForm" action="searchResult.jsp" method="GET">
		<input type="hidden" id="searchId" name="searchId" value="">	
	
<%
	if(search_text != null){
%>
		<input type="hidden" name="search_text" value="<%=search_text %>">
<%
	}

	if(hashTag_li !=null){
		for(int i=0;i<hashTag_li.length ; i++){
			hashTag_s = hashTag_s + hashTag_li[i] + ",";
%>
			<input type="hidden" name="choose" value="<%=hashTag_li[i] %>">
<%
		}
	}
%>

<script>
	var sId = 0;
	function tagStatistic(){
		var hashTag_s = "<%=hashTag_s %>";
	    $.ajax({
	        url: "http://221.138.15.210:8081/search/tagStatistic",  // flask 서버로 던진다.
	        method: "POST",
	        data: { hashTag_s: hashTag_s},
	        success : function(result){
	        	sId = result.sId;
				document.getElementById("searchId").setAttribute("value", sId);
				document.searchForm.submit();
	        }
	    });
	}
</script>
<script>
tagStatistic();
</script>

	</form>

</body>
</html>
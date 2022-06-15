<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "place.*" %>  

<%
	request.setCharacterEncoding("utf-8");
	Timestamp regdate = new Timestamp(System.currentTimeMillis());
%>

<jsp:useBean id="grade" class="place.GradeDataBean">
	<jsp:setProperty name="grade" property="reg_date" value="<%=regdate %>" />
	<jsp:setProperty name="grade" property="*" />
</jsp:useBean>
<% 
	GradeDBBean dbBean = GradeDBBean.getInstance();
	String uId = request.getParameter("uId");
	String pId = request.getParameter("pId");
	int count = dbBean.searchGrade(uId, pId);
	
	if(count == 1){
		dbBean.update(uId, pId, grade);
	}
	else{
		dbBean.insert(grade);
	}
%>
<script>
	var referer = document.referrer;
	var url = "placeDetail.jsp?";
	if(referer.includes("uId")){
		var tmp1 = referer.split('?');
		var tmp2 = tmp1[1].split('&');
	
		var tmp3 = 0;
		var i = 0;
	
		while(!(tmp2[i].includes("uId="))) {
			tmp3 = tmp2[i];
		    i++;
		}
		tmp3 = tmp2[i];
		url += tmp3;
		
		var tmp3 = 0;
		var i = 0;
		while(!(tmp2[i].includes("pId="))) {
			tmp3 = tmp2[i];
		    i++;
		}
		tmp3 = tmp2[i];
		url += "&"+tmp3;
		
		var tmp3 = 0;
		var i = 0;
		while(!(tmp2[i].includes("cId="))) {
			tmp3 = tmp2[i];
		    i++;
		}
		tmp3 = tmp2[i];
		url += "&"+tmp3;
	}
	location.href=url;
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "quest.*" %>  

<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));	
	String answer = request.getParameter("answer");
	QuestDBBean dbBean = QuestDBBean.getInstance();
	dbBean.updateAnswer(answer, num);
%>
<script>
	var referer = document.referrer;
	alert();
	var url = "questAdminList.jsp?";
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
	}
	alert(url);
	location.href=url;
</script>
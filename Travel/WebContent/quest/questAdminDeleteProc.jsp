<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "quest.*" %>  

<%
	request.setCharacterEncoding("utf-8");
	Timestamp regdate = new Timestamp(System.currentTimeMillis());
	String ip = request.getRemoteAddr();
	System.out.println("sdf");
%>

<jsp:useBean id="question" class="quest.QuestDataBean">
	<jsp:setProperty name="question" property="reg_date" value="<%=regdate %>" />
	<jsp:setProperty name="question" property="*" />
</jsp:useBean>

<%
	QuestDBBean dbBean = QuestDBBean.getInstance();
	dbBean.delete(question);
%>
<script>
	var referer = document.referrer;
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
	location.href=url;
</script>
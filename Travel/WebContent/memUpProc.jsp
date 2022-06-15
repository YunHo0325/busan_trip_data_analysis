<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import="java.util.*" %>  

<%
	request.setCharacterEncoding("utf-8");
	int year = Calendar.getInstance().get(Calendar.YEAR);
	int age = year - Integer.parseInt(request.getParameter("year")) + 1;
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
	String referer = request.getParameter("referer");
	
%>

<jsp:useBean id="member" class="member.MemDataBean">
	<jsp:setProperty name="member" property="*" />
	<jsp:setProperty name="member" property="age" value="<%=age %>" />
	<jsp:setProperty name="member" property="reg_date" value="<%=reg_date %>" />
</jsp:useBean>

<%
	MemDBBean dbBean = MemDBBean.getInstance();
	dbBean.update(member);
	response.sendRedirect(referer);
%>
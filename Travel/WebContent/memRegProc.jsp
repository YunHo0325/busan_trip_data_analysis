<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="java.util.*" %>  
<%@ page import="member.*" %>    

<%
	request.setCharacterEncoding("utf-8");
	int year = Calendar.getInstance().get(Calendar.YEAR);
	int age = year - Integer.parseInt(request.getParameter("year")) + 1;
	String email = request.getParameter("email_before") + "@"+request.getParameter("email_after");
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
%>

<jsp:useBean id="member" class="member.MemDataBean">
	<jsp:setProperty name="member" property="*" />
	<jsp:setProperty name="member" property="age" value="<%=age %>" />
	<%-- <jsp:setProperty name="member" property="email" value="<%=email %>" /> --%>
	<%-- <jsp:setProperty name="member" property="reg_date" value="<%=reg_date %>" /> --%>
</jsp:useBean>

<%
	MemDBBean dbBean = MemDBBean.getInstance();	// 있는 것 가져다 쓰는 것
	dbBean.insert(member);
%>
<%
	response.sendRedirect("main1.jsp");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String uId = request.getParameter("uId");
	String referer = (String)request.getHeader("REFERER");
%>
<%
	MemDBBean dbBean = MemDBBean.getInstance();
	dbBean.delete(uId);
	response.sendRedirect(referer);
%>
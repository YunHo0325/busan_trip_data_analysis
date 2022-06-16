<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="member.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String uId = (String)session.getAttribute("uId");

	String pId = null;
	if(request.getParameter("pId") != null){
		pId = request.getParameter("pId");
	}
	String referer = (String)request.getHeader("REFERER");
%>

<jsp:useBean id="wish" class="member.WishDataBean">
	<jsp:setProperty name="wish" property="*" />
</jsp:useBean>

<% 	
	WishDBBean dbBean = WishDBBean.getInstance();
	
	List<WishDataBean> wishList = dbBean.searchWish(uId, pId);
	
	if(wishList == null){
		dbBean.insert(wish);
		response.sendRedirect(referer);
}else{ 
		dbBean.delete(uId, pId);
		response.sendRedirect(referer);
%>
<%} %>

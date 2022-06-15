<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "java.util.*" %>

<%
	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.getMembers();
%>


<h1>회원 리스트</h1> <a href="memRegForm.jsp"><small>[등록]</small></a>
<% if (memList != null) {%>
	<table border=1>
		<tr>
			<th>id</th>
			<th>pwd</th>
			<th>name</th>
			<th>sex</th>
			<th>age</th>
			<th>email</th>
			<th>regdate</th>
			<th>option</th>
		</tr>
		<%
			for(int i=0; i<memList.size(); i++){
				MemDataBean member = memList.get(i);
		%>
		<tr>
			<th><%=member.getuId() %></th>
			<th><%=member.getPwd() %></th>
			<th><%=member.getuName() %></th>
			<th><%=member.getSex() %></th>
			<th><%=member.getAge() %></th>
			<th><%=member.getEmail() %></th>
			<th><%=member.getReg_date() %></th>
			<th>
				<input type=submit value=edit onClick="location.href='memUpForm.jsp?uId=<%=member.getuId()%>'">
			<input type=submit value=delete onClick="location.href='memDelProc.jsp?uId=<%=member.getuId()%>'">
			</th>
		</tr>	
		
		<% } %>	
	</table>
<% } %>
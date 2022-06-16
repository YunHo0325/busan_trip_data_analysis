<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String uId = request.getParameter("uId");	
	String pwd = request.getParameter("pwd");
	String referer = request.getParameter("referer");

	if(uId != null && uId.equals(pwd)){
		session.setAttribute("uId", uId);
		response.sendRedirect("country_main.jsp");
	}
	else{
%>
		<script>
			function login_fail(){
				alert("비밀번호가 일치하지 않습니다");
				history.back();
			}
		</script>
		<body onLoad="login_fail()"></body>
<%	}%>


<%-- 
	String [] url = referer.split("\\?");
	int ind = 0;
	ind = referer.indexOf("uId=");
	
	
	if(referer.contains("?")){
		if(referer.contains("uId")){
			referer = referer.substring(0,ind) + "uId="+uId+ referer.substring(ind+8, referer.length());
	
		}else{
			referer += "&uId=" + uId;
		}
	}else{
		url[0] += "?uId=" + uId;
		referer =url[0];
	}
%>
<%
	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.searchMembers(filter, uId);
	if(memList != null){
		MemDataBean member = memList.get(0);
		if(member.getuId().equals("admin")){
%>
		<script>
			function none(){
				alert("존재하지 않는 아이디 입니다.");
				history.back();
			}
		</script>
		<body onLoad="none()">
		</body>
<% 	
		}else{
			if(member.getPwd().equals(pwd)){
%>
			<script>
				function login_ok(){
					fm.submit();
				}
			</script>
			<body onLoad="login_ok()">
				<form name="fm" action="<%=referer %>" method="post">
					<input type=hidden name=uId value="<%=member.getuId() %>">
				</form>
			</body>
<%
		}
		else{
%>
			<script>
				function login_fail(){
					alert("비밀번호가 일치하지 않습니다");
					history.back();
				}
			</script>
			<body onLoad="login_fail()">			
			</body>
<% 
		}
	}}
	else{
%>
	<script>
		function none(){
			alert("존재하지 않는 아이디 입니다.");
			history.back();
		}
	</script>
	<body onLoad="none()">
	</body>
<%} %>
 --%>
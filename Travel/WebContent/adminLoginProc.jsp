<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String filter = "uId";
	String search_text = request.getParameter("uId");	
	String pwd = request.getParameter("pwd");

	MemDBBean dbBean = MemDBBean.getInstance();
	
		if(search_text.equals("admin")){
			if(pwd.equals("password")){
%>
			<script>
				function login_ok(){
					fm.submit();
				}
			</script>
			<body onLoad="login_ok()">
				<form name="fm" action="admin_user.jsp" method="post">
					<input type=hidden name=uId value="<%=search_text %>">
				</form>
			</body>
<%				
			}else{
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
		}
		else{
			out.print("none");
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
	}
%>
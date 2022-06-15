<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="member.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String email_before = request.getParameter("email_before");
	String email_after = request.getParameter("email_after");
	String uId = request.getParameter("uId");
	String uName = request.getParameter("uName");
	String pwd = request.getParameter("pwd");
	String year = request.getParameter("year");
	String sex = request.getParameter("sex");

	String email = email_before +"@"+ email_after;
	
	int num []= new int[6];
	String auth_num = "";
	
	for(int i=0; i<6; i++){
		num[i] = (int)(Math.random()*6+1);
		auth_num += num[i];
	}
%>


<%
	int flag = 0;
	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.getMembers();
	
	for(int i=0; i<memList.size(); i++){
		MemDataBean member = memList.get(i);
		if(member.getEmail().equals(email)){
			flag = 1;
			break;
		}
	}
	
	if(flag == 1){ %>
	<script>
		function overlap(){
			alert("중복된 이메일입니다.");
			history.back();
		}
	</script>
	<body onLoad="overlap()">
	</body>
<%
	}
	else{
%>
	<%
	AuthMail.gmailSend(email, auth_num);
	
	out.println(email);
	out.println(auth_num);
	out.println("COMPLETE");
	%>
	<br>
		
	<script>
		function idconfirm(){
			fm.submit();
		}
	</script>
	<body onLoad="idconfirm()">
		<form action="join2.jsp" name="fm" method="post">
			<input type="hidden" name="email_before" value="<%=email_before %>">
			<input type="hidden" name="email_after" value="<%=email_after %>">
			<input type="hidden" name="auth_num" value="<%=auth_num %>">
			<input type="hidden" name="uId" value="<%=uId %>">
			<input type="hidden" name="pwd" value="<%=pwd %>">v
			<input type="hidden" name="uName" value="<%=uName %>">
			<input type="hidden" name="sex" value="<%=sex %>">
			<input type="hidden" name="year" value="<%=year %>">
			<input type="hidden" name="flag" value="1">
			
		</form>
	</body>
<%	}
%>
		
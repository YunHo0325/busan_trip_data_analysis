<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<%
	int flag = 0;
	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.getMembers();
	
	for(int i=0; i<memList.size(); i++){
		MemDataBean member = memList.get(i);
		if(member.getuId().equals(request.getParameter("uId"))){
			flag = 1;
			break;
		}
	}
	
	if(flag == 1){ %>
	<script>
		function overlap(){
			alert("중복된 아이디 입니다.");
			history.back();
		}
	</script>
	<body onLoad="overlap()">
	</body>
<%
	}
	else{
%>
	<script>
		function idconfirm(){
			if(confirm("사용가능한 id 입니다. 사용하시겠습니까?")){
				alert("사용 가능한 id");
				fm.submit();
				
			}else{
				history.back();
			}
		}
	</script>
	<body onLoad="idconfirm()">
		<form action="join.jsp" name="fm" method="post">
			<input type="hidden" name="uName" value="<%=request.getParameter("uName") %>">
			<input type="hidden" name="uId" value="<%=request.getParameter("uId") %>">
			<input type="hidden" name="sex" value="<%=request.getParameter("sex") %>">
			
			<input type="hidden" name="yaer" value="<%=request.getParameter("year") %>">
			<input type="hidden" name="flag" value="1">
		</form>
	</body>
<%	}
%>
			
	

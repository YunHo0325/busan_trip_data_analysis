<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String uId = (String)session.getAttribute("uId");

	MemDBBean dbBean = MemDBBean.getInstance();
	MemDataBean member = null;

	String referer = (String)request.getHeader("REFERER");
%>

<%@ include file="top1.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main</title>
	<link rel="stylesheet" href="css/bootstrap.css">
	
	<style>
		*reset*
		*{margin:0; padding:0;}
	
		body{
			background-color:#EFF5FB;
		}
		
		#main{
			height : 80%;
			width :100%;
			position : relative;
			top : 30px;
			text-align : center;
		}
		#form{
			width : 500px;
			height : 600px;
			margin : 0 auto;
			text-align : left;
		}
		#table{
			border : solid;
			width : 100%;
			height : 400px;
		}
		#table th{
			text-align : left;
			width : 500px;
			font-size : 20px;
			padding : 10px;
		}
		#table td{
			text-align : left;
			padding : 10px;
			font-size : 18px;
		}
		#table input[type=text], input[type=password]{
			width : 500px;
			height : 50px;
			border-radius : 10px ;
			border : 1px solid black;
			padding : 10px;
		}
		#table input[type=submit]{
			width : 500px;
			height : 50px;
		}
	</style>
	<script type="text/javascript">
		function bb(){
			if(fm.uId.value=="")
			{
				alert("아이디를 입력하시오");
				return false;
			}
			
			if(fm.pwd.value=="")
			{
				alert("비밀번호를 입력하시오");
				return false;
			}
			return true;
		}
	</script>
</head>
<body>
	<section>
		<div id="main">
			<div id="form">
			<h2 style={align:left}>로그인</h2>
			<br>
			<form action="loginProc.jsp?" method="get" name="fm" onsubmit="return bb()">
				<table id="table">
					<tr>
						<th>ID</th>
					</tr>
					<tr>
						<td>
							<input type="hidden" name="referer" value="<%=referer %>">
							<input type=text name=uId id=uId placeholder="ID를 입력하세요">
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
					</tr>
					<tr>
						<td>
							<input type=password name=pwd id=pwd placeholder="비밀번호를 입력하세요">
						</td>
					</tr>
					<tr>
						<td>
							<input type=submit class="btn btn-outline-primary" value="로그인">
						</td>
					</tr>
				</table>
			</form>
			</div>
		</div>
	</section>
	<footer>
	
	</footer>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>
				
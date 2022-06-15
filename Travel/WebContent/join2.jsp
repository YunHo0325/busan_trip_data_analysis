<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>

<%
	request.setCharacterEncoding("utf-8");
	MemDBBean dbBean = MemDBBean.getInstance();
	MemDataBean member = null;
%>

<%@ include file="top1.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="css/bootstrap.css">
	
	<style>
		*reset*
		*{margin:0; padding:0;}
	
		body{
			background-color:#EFF5FB;
		}
		
		#main{
			height : 2000px;
			width :100%;
			position : relative;
			top : 30px;
			text-align : center;
		}
		#form{
			width : 850px;
			height : 700px;
			margin : 0 auto;
			text-align : left;
		}
		#table{
			width : 600px;
			height :300px;
			margin : 0 auto;
		}
		#table th{
			text-align : left;
			width : 150px;
			font-size : 20px;
			vertical-align : middle;
			height : 40px
		}
		#table td{
			text-align : center;
			padding : 10px;
			font-size : 18px;
			
			vertical-align : middle;
			height : 50px
		}
		#table input[type=text]{
			width : 300px;
			height : 40px;
			border-radius : 10px ;
			border : 1px solid black;
			padding : 10px;
		}
		#email_before_b, #email_before{
			width : 200px;
		}
		#table input[type=submit]{
			width : 80px;
		}
		a{
			color : black;
		}
		a:hover{
			color : #0174DF;
			text-decoration:none;
		}
	</style>
	<script>
		function auth_email(){
			var before = document.getElementById("email_before_b").value;
			var after = document.getElementById("email_after_b").value;
			var uId = document.getElementById("uId_b").value;
			var pwd = document.getElementById("pwd_b").value;
			var uName = document.getElementById("uName_b").value;
			var year = document.getElementById("year_b").value;
			var sex = document.getElementById("sex_b").value;
			
			location.href="sendAuthMail.jsp?email_before="+before+"&email_after="+after+"&uId="+uId+"&pwd="+pwd+"&uName="+uName+"&year="+year+"&sex="+sex;
		}
		
		function auth_confirm(){
			var btn = document.getElementById('auth_button');
			var auth_num = document.getElementById('auth_num').value;

			if(auth_num == fm.auth.value){
				btn.value = "인증 완료";
				btn.disabled = 'disabled';
			}
			else{
				alert("일치하지 않음");	
			}
		}
	</script>
</head>
<body>
	<section>
		<div id="main">	
			<div id="form">
			<h2 style={align:left}>회원가입</h2>
			<br>
			<form action="memRegProc.jsp" method="post" name="fm">
				<%
					request.setCharacterEncoding("utf-8");
					int year = Integer.parseInt(request.getParameter("year"));
					
				%>
				
				<jsp:useBean id="member2" class="member.MemDataBean">
					<jsp:setProperty name="member2" property="age" value="<%=year %>" />
					<jsp:setProperty name="member2" property="*" />
				</jsp:useBean>
				
				<%
					if(request.getParameter("flag") != null){
				%>
				
				
				<input type=hidden name="uId" id="uId_b" value="<%=member2.getuId() %>">
				<input type=hidden name="pwd" id="pwd_b" value="<%=member2.getPwd() %>">
				<input type=hidden name="uName" id="uName_b" value="<%=member2.getuName() %>">
				<input type=hidden name="year" id="year_b" value="<%=member2.getAge() %>">
				<input type=hidden name="sex" id="sex_b" value="<%=member2.getSex() %>">
				
				<%System.out.println(member2.getuId()); %>
				<table id="table" class="table">
					<tr>
						<th colspan=4> 이메일을 입력하세요 </th>
					</tr>
					<tr>
						<td><input type=text readonly class="form-control" name="email_before" id="email_before" value="<%=request.getParameter("email_before") %>"> 
						</td>
						<td>@ </td>
						<td><select name="email_after" id="email_after" class="custom-select">
								<option selected value="<%=request.getParameter("email_after") %>">
									<%=request.getParameter("email_after") %>
								</option>
							</select>
						</td>
						<td>
							<input type="button" class="btn btn-primary" disabled value="인증번호 받기">
						</td>
					</tr>
					<tr>
						<th>
							인증번호
						</th>
						<td colspan=2>
							 <input type=text  class="form-control" name=auth id=auth>
							 <input type=hidden name=auth_num id="auth_num" value=<%=request.getParameter("auth_num") %>>
						</td>
						<td>	 
							 <input type=button value="인증" class="btn btn-outline-primary" id="auth_button" onClick="auth_confirm()">
						</td>
					</tr>
					<tr>
						<td colspan=4><input type=submit value="join" class="btn btn-dark"></td>
					</tr>
				</table>
				<%
					}else{
				%>
				
				
				<input type=hidden name="uId" id="uId_b" value="<%=member2.getuId() %>">
				<input type=hidden name="pwd" id="pwd_b" value="<%=member2.getPwd() %>">
				<input type=hidden name="uName" id="uName_b" value="<%=member2.getuName() %>">
				<input type=hidden name="year" id="year_b" value="<%=member2.getAge() %>">
				<input type=hidden name="sex" id="sex_b" value="<%=member2.getSex() %>">
				
				<table id="table" class="table">
					<tr>
						<th colspan=4> 이메일을 입력하세요 </th>
					</tr>
					<tr>
						<td><input type=text size=10 class="form-control" name="email_before_b" id="email_before_b">
						</td>
						<td width=10>
							@ 
						</td>
						<td>
							 <select name="email_after_b" id="email_after_b" class="custom-select">
								<option value="gmail.com">gmail.com</option>
								<option value="naver.com">naver.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="daum.net">daum.net</option>
							</select>
						</td>
						<td>
							<input type="button" value="인증번호 받기" class="btn btn-outline-primary" onClick="auth_email()">
						</td>
					</tr>
					<tr>
						<th>
							인증번호
						</th>
						<td colspan=4>
							 <input type=text class="form-control" name=auth_b id=auth_b>
						</td>
					</tr>
					<tr>
						<td colspan=4><input type=submit value="join" class="btn btn-dark"></td>
					</tr>
				</table>
				<%
					}
				%>
			</form>
			</div>
		</div>
	</section>
</body>
</html>
						
						
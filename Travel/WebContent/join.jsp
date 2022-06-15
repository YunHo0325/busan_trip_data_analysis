<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<%@ page import="java.util.*" %>

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
			height : 600px;
			margin : 0 auto;
		}
		#table th{
			text-align : center;
			width : 150px;
			font-size : 20px;
			vertical-align: middle;
		}
		#table td{
			text-align : left;
			padding : 10px;
			font-size : 18px;
			vertical-align: middle;
		}
		#table input[type=text], input[type=password]{
			width : 300px;
			height : 40px;
			border-radius : 10px ;
			border : 1px solid black;
			padding : 10px;
		}
		#year_b, #year{
			width : 100px;
		}
		a{
			color : black;
		}
		a:hover{
			color : #0174DF;
			text-decoration:none;
		}
	</style>
	<script type="text/javascript">
		function idCheck(){
			
			if(fm.uId_b.value=="")
			{
				alert("아이디를 입력하시오");
				fm.uId.focus();
				return false;
			}
			else if(fm.uId_b.value.length>20 || fm.uId_b.value.length<6)
			{
				alert("아이디를 6자이상 10자 이하로 입력하시오");
				fm.uId.value="";
				fm.uId.focus();

			}
			else{
				var uId = document.getElementById("uId_b").value;
				var uName = document.getElementById("uName_b").value;
				var year = document.getElementById("year_b").value;
				var sex= document.getElementsByName('sex_b')[0].value;

				location.href="IdCheckProc.jsp?uId="+uId+"&uName="+uName+"&year="+year+"&sex="+sex;
			}


		}
		
		function bb(){
			if(fm.confirm.value=="no")
			{
				alert("중복확인을 하시오");
				return false;
			}
			
			if(fm.pwd.value=="")
			{
				alert("비밀번호를 입력하시오");
				return false;
			}
			if(fm.pwd.value.length <6 || fm.pwd.value.length > 20)
			{
				alert("비밀번호를 6자이상 20자이하로 입력하시오");
				fm.pwd.value="";
				fm.pwd.focus();
				return false;
			}
			if(fm.pwd.value != fm.pwd2.value)
			{
				alert("입력한 비밀번호가 일치하지 않습니다");
				fm.pwd2.value="";
				fm.pwd2.focus();
				return false;
			}
			
			if(fm.uName.value=="")
			{
				alert("이름을 입력하시오");
				fm.uName.focus();
				return false;
			}
			if(fm.uName.value.length > 20){
				alert("이름을 20자 이내로 입력하시오");
				return false;
			}
			
			var chkbox = document.getElementsByName('agree');
			var chk = false;
			for(var i=0 ; i<chkbox.length ; i++) {
				if(chkbox[i].checked) {
					chk = true; 
				}
				else {
					chk = false; 
				}
			}
			if(chk) { 
				alert("모든 약관에 동의함."); 
				return true;
			} else {
				alert("모든 약관에 동의해 주세요.");
				return false; 
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
			<form action="memRegProc.jsp" method="post" name="fm" onsubmit="return bb()">
				<%
					if(request.getParameter("flag") != null){
				%>
						<table id="table" class="table">
							<tr>
								<th>이름</th>
								<td>
									<input type="text" class="form-control" name="uName" id="uName" value="<%=request.getParameter("uName")%>" placeholder="이름을 입력하시오">
								</td>
							</tr>
							<tr>
								<th>아이디</th>						
									<td>
										<input type="text" class="form-control" name="uId" id="uId" value="<%=request.getParameter("uId") %>" readonly>	
									</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td>
									<input type="password" class="form-control" name="pwd" id="pwd" placeholder="20자 이내로 입력하시오">
								</td>
							</tr>
							<tr>
								<th>비밀번호 확인</th>
								<td>
									<input type="password" class="form-control" name="pwd2" id="pwd2">
								</td>
							</tr>
							<tr>
								<th>년도</th>
								<td>
									<select name="year" id="year" class="custom-select">
										<%if(request.getParameter("year") != null){
											for(int i=1920; i<2020; i++){ 
												if(i == Integer.parseInt(request.getParameter("year"))){	
										%>
											<option value="<%=i %>" selected><%=i %></option>
										<%		}else{ %>
											<option value="<%=i %>"><%=i %></option>
										<%
												}
											}
										}
										else{
											for(int i=1920; i<2020; i++){ %>
												<option value="<%=i %>"><%=i %></option>
											<%}
										}%>
									</select> 년
								</td>
							</tr>
							
							<tr>
								<th>성별</th>
								<td>
									<%if(request.getParameter("sex").equals("m")){%>
										<div class="custom-control custom-radio">
											<input type="radio" class="custom-control-input" name="sex" id="sex_m" value="m" checked>
											<label class="custom-control-label" for="sex_m"> 남</label>
										
										</div>
										<div class="custom-control custom-radio">
											<input type="radio" class="custom-control-input" name="sex" id="sex_w" value="w">
											<label class="custom-control-label" for="sex_w"> 여</label>	
										</div>
									<%}else{ %>
										<div class="custom-control custom-radio">
											<input type="radio" class="custom-control-input" name="sex" id="sex_m" value="m">
											<label class="custom-control-label" for="sex_m"> 남</label>
										
										</div>
										<div class="custom-control custom-radio">
											<input type="radio" class="custom-control-input" name="sex" id="sex_w" value="w" checked>
											<label class="custom-control-label" for="sex_w"> 여</label>	
										</div>
									<%} %>
								</td>
							</tr>
							<tr>
								<td colspan=2>
									<div class="custom-control custom-checkbox">
										<input type="checkbox" name="agree" id="agree" value="yes" class="custom-control-input">
										<label class="custom-control-label" for="agree">약관에 동의하시겠습니까?</label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan=2>
									<input type=submit class="btn btn-dark" value="다음">
									<input type=hidden name="confirm" id="confirm" value="ok">
								</td>
							</tr>
						</table>
				<%
					}else{
				%>
				<table id="table" class="table">
					<tr>
						<th>이름</th>
						<td colspan=2>
							<input type="text" class="form-control" name="uName_b" id="uName_b" placeholder="이름을 입력하시오">
						</td>
					</tr>
					<tr>
						<th>아이디</th>
							<td width=320px>
								<input type="text" class="form-control" name="uId_b" id="uId_b" placeholder="20자 이내로 입력하시오">
							</td>
							<td>
								<input type="button" value="중복확인" class="btn btn-outline-primary" onClick="idCheck()">
							</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td colspan=2>
							<input type="password" class="form-control" name="passwd_b" id="passwd_b" placeholder="20자 이내로 입력하시오">
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td colspan=2> 
							<input type="password" class="form-control" name="passwd2_b" id="passwd_b">
						</td>
					</tr>
					<tr>
						<th>년도</th>
						<td colspan=2>
							<select name="year_b" id="year_b" class="custom-select">
							<%for(int i=1920; i<2020; i++){ %>
								<option value="<%=i %>"><%=i %></option>
							<%} %>
							</select> 년
						</td>
					</tr>
					<tr>
						<th>성별</th>
						<td colspan=2>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="sex_b" id="sex_b_m" value="m" checked>
							<label class="custom-control-label" for="sex_b_m"> 남</label>
						
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="sex_b" id="sex_b_w" value="w">
							<label class="custom-control-label" for="sex_b_w"> 여</label>	
						</div>		
						</td>
					</tr>
					<tr>
						<td colspan=3>
							<div class="custom-control custom-checkbox">
								<input type="checkbox" name="agree_b" id="agree_b" value="yes" class="custom-control-input">
								<label class="custom-control-label" for="agree_b">약관에 동의하시겠습니까?</label>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan=3>
							<input type=submit value="다음" class="btn btn-dark">
							<input type=hidden name="confirm" id="confirm" value="no">
						</td>
					</tr>
				</table>
				<% 	}
				%>	
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
				
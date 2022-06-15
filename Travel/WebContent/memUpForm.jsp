<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "place.*" %>
<%@ page import = "country.*" %>
<%@ page import = "city.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String uId = "";
	if(request.getParameter("uId") != null)
		uId = request.getParameter("uId");

	
	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.searchMembers("uId", uId);
	MemDataBean member = null;
	
	if(memList != null){
		member = memList.get(0);
	}
	String referer = (String)request.getHeader("REFERER");
%>

<%@ include file="top1.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
		
		<%@ include file="asideCss.jsp" %>
		section{
			margin : 0 auto;
		}
		#main{
			display:table-cell;
			border-spacing:0;
			padding: 50px 50px;
			margin : 0 auto;
			text-align : left;
		}
		h2{
			padding : 0 0 0 85px;
		}
		#table{
			width : 1200px;
			height : 800px;
			font-size : 20px;
			margin : 0 auto;
		}
		#table th{
			padding : 25px;
			vertical-align : middle;
		}
		#table td{
			padding : 15px;
			vertical-align : middle;
		}
		#profile_i{
			margin : 5px 0 0 0;
			width : 150px;
			border: 3px solid black;
			border-radius: 1000px;
			-moz-border-radius: 1000px;
			-khtml-border-radius: 1000px;
			-webkit-border-radius: 1000px;
			margin : 0 auto;
		}
		#year{
			width : 100px;
		}
	</style>
</head>
<body>
	<section>
		<div id="content">
			<div id="main">
			<h2>프로필 수정</h2><br>
			
				<form action=memUpProc.jsp method=post>
					<% if (memList != null) { 
						member = memList.get(0);
						System.out.println(member.getuId());
					%>
					<table id="table" class="table">
						<tr>
							<td height=190px width=200px>
								<img src="<%=member.getImg() %>" id="profile_i">
							</td>
							<td>
								수정
							</td>
						</tr>
						<tr>
							<th>아이디</th>
							<td>
								<input type=hidden name="referer" value="<%=referer %>">
								<%=member.getuId() %>
								<input type=hidden name="uId" value=<%=member.getuId() %>>
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type=password name=pwd class="form-control"></td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td><input type=password name=pwd2 class="form-control"></td>
						</tr>
						<tr>
							<th>이름</th>
							<td>
								<input type=text name=uName class="form-control" value=<%=member.getuName() %>>
							</td>
						</tr>
						<tr>
							<th>나이</th>
							<td>
								<select name="year" id="year" class="custom-select">
								<%
									for(int i=1920; i<2020; i++){ 
										if(i == (Calendar.getInstance().get(Calendar.YEAR) - member.getAge()+1)){	
								%>
									<option value="<%=i %>" selected><%=i %></option>
								<%		}else{ %>
									<option value="<%=i %>"><%=i %></option>
								<%
										}
									}
								%>
								</select> 년
							</td>
						</tr>
						<tr>
							<th>sex</th>
							<td>
								<%if(member.getSex().equals("m")){%>
										<div class="custom-control custom-radio">
											<input type="radio" class="custom-control-input" name="sex" id="sex_m" value="m" checked>
											<label class="custom-control-label" for="sex_m"> 남</label>
										
										</div>
										<div class="custom-control custom-radio">
											<input type="radio" class="custom-control-input" name="sex" id="sex_w" value="w">
											<label class="custom-control-label" for="sex_w"> 여</label>	
										</div>
								<%}else {%>
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
							<th>
								이메일
							</th>
							<td>
								<%=member.getEmail() %>
								<input type=hidden name="email" value=<%=member.getEmail() %>>
							</td>
						</tr>
						<tr>
							<th>
								phone
							</th>
							<td>
								<input type=text name=phone class="form-control" value="<%=member.getPhone() %>">
								<input type=hidden name="img" value=<%=member.getImg() %>>
							</td>
						</tr>
						<tr>
							<th colspan=2>
								<input type=submit value=수정 class="btn btn-primary">
								<input type=button value=취소 class="btn btn-danger" onClick="location.href='myPage.jsp?uId=<%=member.getuId()%>'">
							</th>
						</tr>
					</table>
					<% } %>		
				</form>
			</div>
		</div>
	</section>
</body>
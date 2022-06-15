<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "quest.*" %>
<%@ page import = "member.*" %>
<%@ page import = "java.util.*" %>


<%
	request.setCharacterEncoding("utf-8");
	String uId = null;
	if(request.getParameter("uId") != null)
		uId = request.getParameter("uId");
	int num = 0;
	if(request.getParameter("num") != null)
		num = Integer.parseInt(request.getParameter("num"));
	
	
	MemDBBean dbBean = MemDBBean.getInstance();
	List<MemDataBean> memList = dbBean.getMembers();
	List<MemDataBean> myList = dbBean.searchMembers("uId", uId);
	MemDataBean member = null;
	
	if(myList != null){
		member = myList.get(0);
	}
%>
<%
	QuestDBBean questBean = QuestDBBean.getInstance();
	List<QuestDataBean> questList = questBean.detailQuests(num);
	QuestDataBean quest = questList.get(0);
	System.out.println(quest.getNum());
	questBean.increaseReadCount(quest);

	questList = questBean.detailQuests(num);
	quest = questList.get(0);

	List<MemDataBean> memList2 = dbBean.searchMembers("uId", quest.getuId());
	MemDataBean member2 = memList2.get(0);
%>
<%@ include file="adminTop.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main</title>
	<link rel="stylesheet" href="css/bootstrap.css">
	<style>
		body{
			background-color:#EFF5FB;
			height : 100%;
		}
		
		<%@ include file="asideCss.jsp" %>
		#main{
			display:table-cell;
			border-spacing:0;
			width:1200px;
			height : 560px;
			display:table-cell;
			padding: 50px 10px;
			margin : 0 auto;
			text-align : left;
		}
		#quest{
			border : solid;
			width : 100%;
			height : 500px;
			font-size : 20px;
		}
		#quest th{
			padding : 10px;
			font-size : 23px;
		}
		#quest td{
			padding : 10px;
		}
		#form{
			width : 1100px;
			height : 500px;
		}
		#form th{
			width : 200px;
			height : 60px;
			font-size : 20px;
		}
	</style>
	<script type="text/javascript">
		function goBack(){
			var referer = document.referrer;
			location.replace(referer);
		}
	</script>
</head>

<body>
	<div id="content">
		<aside>
			<div id="side">
				<span id="side_name">UK</span><br>
				
				<ul id="side_ul">
					<li onClick="location.href='noticeAdminList.jsp'">공지사항</li>
					<li onClick="location.href='questAdminList.jsp'" id="side_ul_now">Q & A</li>
				</ul>
			</div>
		</aside>
		<section>
			<div id="main">
				<p>Q & A</p>
				<div id="go_list">
					<input type=button value="글목록" onClick="goBack()">
				</div>		
				<table id="quest" border=1>
					<tr>
						<th height=15% style="vertical-align:bottom">
							<%=quest.getSubject() %>
						</th>
					</tr>
					<tr>
						<td height=15% style="vertical-align:top">
							<%=member2.getuName() %> | <%=quest.getReg_date() %>
							 | 조회수 <%=quest.getReadcount() %> | <span id="report">신고</span>
						</td>
					</tr>
					<tr>
						<td style="vertical-align:top">
							<%=quest.getContent() %>
						</td>
					</tr>
				</table>
				<br>
				
				답변
			<form action="questAnswerProc.jsp" name="writeform" onSubmit="return InputCheck();">
				<table id="form" border =1>
					<tr>
						<th>
							<input type=hidden name=num value=<%=quest.getNum() %>>
							내용
						</th>
						<td><textarea rows="13" cols="120" name=content></textarea></td>
						
					</tr>
					<tr>
						<td colspan=2 align=center>
							<input type=submit value="등록">
							<input type=reset value="다시작성">
							<input type=button value="취소" onClick="goBack()">
						</td>
					</tr>
				</table>
			</form>
			</div>
		</section>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "member.*" %>
<%@ page import = "place.*" %>
<%@ page import = "java.util.*" %>

<%
	String uId = (String)session.getAttribute("uId");
	
	/* if(uId == null){
		response.sendRedirect("loginFrm_s.jsp");
	} */
	
	
	/* 
	if(request.getParameter("uId") != null)
		uId=request.getParameter("uId");
	 */
	MemDBBean dbBean = MemDBBean.getInstance();
	List <MemDataBean> memList = dbBean.searchMembers(uId);
	MemDataBean member = null;
	if(memList != null)
		member = memList.get(0);
	if(memList == null)
		System.out.println("null"); 
	

	PlaceDBBean placeBean = PlaceDBBean.getInstance();
	List<PlaceDataBean> placeList = placeBean.getGUGUN();

%>

<%@ include file = "top1.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<style>
		#map_con{
			float : right;
			height : 1500px;
			width : 100%;
			position : relative;
			top : 150px;
			text-align : center;
		}
		#map{
			height : 750px;
			width : 100%;
			
			position : absolute;
			top : 0;
			left : 0;
		}
		#i_map, #i_uk, #i_franch, #i_germany, #i_italia, #i_russia, #i_sweden{
			height : 840px;
			width : 83%;
		}
		#i_mark_uk{
			position : absolute;
			top : 50%;
			left : 24.5%;
		}
		#i_mark_franch{
			position : absolute;
			top : 73%;
			left : 26.9%;
		}
		#i_mark_germany{
			position : absolute;
			top : 66%;
			left : 36.5%;
		}
		#i_mark_italia{
			position : absolute;
			top : 85.5%;
			left : 38.5%;
		}
		#i_mark_russia{
			position : absolute;
			top : 39%;
			left : 69%;
		}
		#i_mark_sweden{
			position : absolute;
			top : 33%;
			left : 42%;
		}
		
		#i_popup_uk{
			position : absolute;
			top : 24%;
			left : 18%;
		}
		#i_popup_franch{
			position : absolute;
			top : 80%;
			left : 15%;
		}
		#i_popup_germany{
			position : absolute;
			top : 40%;
			left : 30.5%;
		}
		#i_popup_italia{
			position : absolute;
			top : 60%;
			left : 40.5%;
		}
		#i_popup_russia{
			position : absolute;
			top : 13%;
			left : 62.5%;
		}
		#i_popup_sweden{
			position : absolute;
			top : 7%;
			left : 36%;
		}
	
	</style>
	<script type="text/javascript">
		
		function logout_script(){
			<%
	session.removeAttribute("uId");%>
			alert("logout");
			location.replace("main1.jsp");
		}
		
		history.pushState(null, null, location.href);

		window.onpopstate = function(event) {

			history.go(1);

		};
	</script>
</head>
<body>
	<section>
		<div>
			<table >
               <tr>
<%
	if(placeList != null){
		for(int i=0; i<placeList.size()/2; i++){
			PlaceDataBean place = placeList.get(i);
%>
                  <td id="button" width=180px>
                     <button id="button" class="btn btn-primary waves-effect" onClick="location.href='country_main.jsp?GUGUN_NM=<%=place.getGUGUN_NM() %>'">
                     	<%=place.getGUGUN_NM() %>
                     </button>
                  </td>
<%		
		}
		%>
				</tr>
				<tr>
		<%
		for(int i=placeList.size()/2; i<placeList.size(); i++){
			PlaceDataBean place = placeList.get(i);
			%>
                  <td id="button" width=180px>
                     <button id="button" class="btn btn-primary waves-effect" onClick="location.href='country_main.jsp?GUGUN_NM=<%=place.getGUGUN_NM() %>'">
                     	<%=place.getGUGUN_NM() %>
                     </button>
                  </td>
			<%
		}
   } %>
               </tr>
            </table>
		</div>
	</section>
	<footer>
	
	</footer>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>
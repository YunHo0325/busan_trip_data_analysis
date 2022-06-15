<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
	<style type="text/css">
		#near {
			position: absolute;
			width: 230px;
			height: 700px;
			right: 0px;
			top: 0px;
		}
		#near_ul{
			border : solid black;
			list-style:none;
			width : 230px;
			height : 570px;
			line-height:100px;
			padding:0;
			margin:20px 0 0 20px;
			font-size : 18px;
			text-shadow : 0 0 1px black;
		}
	</style>
</head>
    
<body>
			<div id="near">
				<ul id="near_ul">
<%
	List<PlaceDataBean> placeList2 = placeBean.getPlaces(cId);
	if(placeList2 != null){
		int random[] = new int [4];
				
		for(int i=0; i<4; i++){
			random[i] = (int)(Math.random()*placeList2.size());
			for(int j=0; j<i; j++){
				if(random[i] == random[j]){
					i--;
					break;
				}
			}
		}
		for(int i=0; i<4; i++)
			System.out.println(random[i]); 
		for(int i=0; i<4; i++){
			PlaceDataBean place2 = placeList2.get(random[i]);
%>
					<li>
						<table>
							<tr>
								<td>
									<img src="<%=place2.getpImg() %>" width=200px height=130px>
								</td>
							</tr>
						</table>
					</li>
<%}} %>
				</ul>
			</div>
</body>
<script src="jquery_mini.js" type="text/javascript"></script>
<script src="jquery.dimensions.js" type="text/javascript"></script> 
<script type="text/javascript">
// <![CDATA[ 
	var name = "#near"; 
	var menuYloc = null; 
	$(document).ready(function(){ 
		menuYloc = parseInt($(name).css("top").substring(0,$(name).css("top").indexOf("px"))) 
		$(window).scroll(function () { 
			if($(document).scrollTop() < 420){
				offset = menuYloc+$(document).scrollTop()+"px"; 
			}else if($(document).scrollTop() >= 420){
				offset = menuYloc+$(document).scrollTop()-550+"px"; 
			}
			$(name).animate({top:offset},{duration:400,queue:false}); 
			}); 
		}); 
// ]]>
</script> 
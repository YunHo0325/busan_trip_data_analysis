/**
 * 
 */

function not_login(){
	alert("로그인을 해주세요");
	location.href="login.jsp";
}
	
function wish_f(){		
	var thisEle = event.target;
	if(thisEle.src=="http://39.115.48.106:8085/Travel/img/heart.png"){
		var paraUId = document.getElementById("uId").value;
		var paraPId = thisEle.alt;
		var paraCId = document.getElementById("cId").value;
		window.location.href="wishAdd.jsp?uId="+paraUId+"&pId="+paraPId+"&cId="+paraCId;
		document.getElementById("heart_i").src="img/heart_after.png";			
	}
	else if(thisEle.src=="http://39.115.48.106:8085/Travel/img/heart_after.png"){
		var paraUId = document.getElementById("uId").value;
		var paraPId = thisEle.alt;
		var paraCId = document.getElementById("cId").value;
		window.location.href="wishAdd.jsp?uId="+paraUId+"&pId="+paraPId+"&cId="+paraCId;
		document.getElementById("heart_i").src="img/heart.png";	
	}
}


function logout_script(){
	alert("logout");
	location.replace("main1.jsp");
}

function preSearch(){
	var paraSearch = document.getElementById("search_text").value;
	
	var referer = document.location.href;
	var url = "searchResult.jsp?search_text="+paraSearch;
	if(referer.includes("uId")){
		var tmp1 = referer.split('?');
		var tmp2 = tmp1[1].split('&');

		var tmp3 = 0;
		var i = 0;

		while(!(tmp2[i].includes("uId="))) {
			tmp3 = tmp2[i];
		    i++;
		}
		tmp3 = tmp2[i];
		url += "&"+tmp3;
	}
	location.href=url;
}

function search_script(){
	var thisEle = event.target.value;
	var tag = thisEle.replace("#", "");
	
	var referer = document.location.href;
	var url = "searchResult.jsp?choose="+tag;
	if(referer.includes("uId")){
		var tmp1 = referer.split('?');
		var tmp2 = tmp1[1].split('&');

		var tmp3 = 0;
		var i = 0;

		while(!(tmp2[i].includes("uId="))) {
			tmp3 = tmp2[i];
		    i++;
		}
		tmp3 = tmp2[i];
		url += "&"+tmp3;
	}
	location.href=url;
}

function chooseOption(){
	var tag = "btn_" + event.target.value;
	alert(tag);
	var btn_name = document.getElementById(tag).getAttribute('name');
	var btn_class = document.getElementById(tag).getAttribute('class');
	
	if(btn_class == "btn btn-outline-primary"){
		document.getElementById(tag).setAttribute("name", btn_name+"_choose");
		document.getElementById(tag).setAttribute("class", "btn btn-primary");
	}
	else{
		btn_name = btn_name.replace("_choose", "");
		document.getElementById(tag).setAttribute("name", btn_name);
		document.getElementById(tag).setAttribute("class", "btn btn-outline-primary");
	}
	
	
}


function go_main(){
	var referer =  document.location.href;
	var url = "country_main.jsp";
	if(referer.includes("uId")){
		var tmp1 = referer.split('?');
		var tmp2 = tmp1[1].split('&');

		var tmp3 = 0;
		var i = 0;

		while(!(tmp2[i].includes("uId="))) {
			tmp3 = tmp2[i];
		    i++;
		}
		tmp3 = tmp2[i];
		url += "?"+tmp3;
	}
	location.href=url;
}
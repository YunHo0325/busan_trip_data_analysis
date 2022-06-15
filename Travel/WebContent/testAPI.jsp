<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>POST방식의 요청</h1>
	<button type="button" onclick="sendRequest()">POST방식으로 요청 보내기!</button>
	<button type="button" onclick="getRecommandPlace()">getRecommandPlace</button>
	<p id="text"></p>

<script src="//code.jquery.com/jquery-3.5.1.min.js" ></script>
<script>
	function sendRequest(){
	    $.ajax({
	        url: "http://221.138.15.210:8081/api/plus",  // flask 서버로 던진다.
	        method: "GET",
	        data: { x: "2" , y : "3" },
	        success : function(result){
				document.getElementById("text").innerHTML = result.result;
	        }
	    });
	}
	function getRecommandPlace(){
	    $.ajax({
	        url: "http://221.138.15.210:8081/place/recommand",  // flask 서버로 던진다.
	        method: "POST",
	        success : function(result){
				document.getElementById("text").innerHTML = result.result;
	        }
	    });
	}
</script>

</body>
</html>
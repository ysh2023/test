<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../common/common.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//alert(1);
		var use;
		var isCheck = false;
		$('#titleCheck').click(function(){//중복체크 버튼
			//alert(2);
			isCheck=true;
			$.ajax({
				url : "titlecheck.mv",
				data: ({
					moviechk : $("input[name=title]").val()
				}),
				success : function(data) {
					alert("data:"+data);
					if($("input[name=title]").val() ==""){
					/* 	alert("제목 누락 되어있습니다.");
						use = "missing";
						$('#titlemessage').show(); */
						$('#titlemessage').html("<font color=green>입력 누락되었습니다.</font>");
						$('#titlemessage').show();
					}
					else if(data == "YES"){
						$('#titlemessage').html("<font color=blue>사용가능합니다</font>");
						use = "possible";
						$('#titlemessage').show();
					}else{
						$('#titlemessage').html("<font color=red>이미 사용중인 제목입니다.</font>");
						use = "impossible";
						$('#titlemessage').show();
					}
				}//success				
			});//ajax
		});//click
		$('#sub').click(function(){
			//alert(4);
			if(use =="missing"){
				alert("제목을 입력하세요.");
				$("input[name=title]").focus();
				return false;
			}else if(use == "impossible"){
				alert("이미 사용중인 제목입니다.");
				return false;
			}else if(isCheck == false){
				alert("중복체크 먼저 하세요.");
				return false;
			}
		})//sub_click
		//키보드 눌렸을때.	
		$("input[name=title]").keydown(function(){
				$('#titlemessage').css('display','none');
				use = "";//초기화 안하면 전에 입력된 값때문에 가입하기가 안된다.
				isCheck = false;
				
			});//keydown
	});//ready 
</script>
<script type="text/javascript">
var f_selbox = new Array('아시아', '아프리카', '유럽', '아메리카','오세아니아');
var s_selbox = new Array();
s_selbox[0] = new Array('대한민국', '일본', '중국', '싱가폴', '필리핀');
s_selbox[1] = new Array('이집트', '수단', '모로코', '알제리');
s_selbox[2] = new Array('프랑스', '이탈리아', '독일', '스페인','체코');
s_selbox[3] = new Array('미국', '캐나다','그린란드');
s_selbox[4] = new Array('뉴질랜드', '오스트레일리아', '피지', '사모아');

	function init(mf) { // select박스에 대륙 값 넣기
		//alert(1);
		for(var i=0;i<f_selbox.length;i++){
			mf.continent.options[i+1] = new Option(f_selbox[i]);
		}
			
	}

	function firstChange(f) {
		
		var sel_index = f.continent.selectedIndex;
		var sel_val = f.continent[sel_index].value;
		
		//alert(sel_index +"," + sel_val); // 1,아시아
		
		for(i=f.nation.length; i>0 ;i--){
			f.nation.options[i] = null;
		}
		
		for(var i=0; i<s_selbox[sel_index-1].length; i++){
			f.nation.options[i+1] = new Option(s_selbox[sel_index-1][i]);
		}
	}
</script>
<style>
	.err{
		color: red;
		font-size: 9px;
		font-weight: bold;
	}
</style>

movieInsertForm.jsp<br>
<body onload="init(myform)">
<h2>영화 정보 등록 화면</h2>

<form:form name="myform" commandName="movie" action="insert.mv" method="post">
 <p>
  <label for="title">영화 제목 : </label>
  <input type="text" name="title" id="title" value="${ movieBean.title }">
  <input type="button" id="titleCheck" value="중복체크">
  <span id="titlemessage"></span>
  <form:errors cssClass="err" path="title"/>
 </p>
 
 <p>
  <label for="continent">대륙 : </label>
  <select name="continent" id="continent" onchange="firstChange(myform);">
  	<option value="">대륙 선택하세요</option>
  </select>
  <form:errors cssClass="err" path="continent"/>
  
  <label for="nation">나라 : </label>
  <select name="nation">
  	<option value="">나라 선택하세요</option>
  </select> 
  <form:errors cssClass="err" path="nation"/>
 </p>
 <p>
  <label for="genre">장르 : </label>
  <c:forEach var="genre" items="액션,스릴러,코미디,판타지,애니메이션">
    <input type="checkbox" name="genre" id="genre" value="${ genre }" <c:if test="${ fn:contains(movieBean.genre, genre) }">checked</c:if>>${ genre }
  </c:forEach>
  <form:errors cssClass="err" path="genre"/>
 </p>
<p>
  <label for="grade">등급 : </label>
  <c:forEach var="grade" items="19,15,12,7">
    <input type="radio" name="grade" id="grade" value="${ grade }" <c:if test="${ fn:contains(movieBean.grade, grade) }">checked</c:if>>${ grade }
  </c:forEach>
  <form:errors cssClass="err" path="grade"/>
 </p>
 <p>
  <label for="actor">출연 배우 : </label>
  <input type="text" name="actor" id="actor" value="${ movieBean.actor }">
  <form:errors cssClass="err" path="actor"/>
 </p>
 <p>
  <input type="submit" id="sub" value="추가하기" onClick="return check()">
 </p>
</form:form>
</body>

<%--  <p>
  <label for="continent">대륙 : </label>
  <input type="text" name="continent" id="continent" value="${ movieBean.continent }">
  <form:errors cssClass="err" path="continent"/>
  
  <label for="nation">나라 : </label>
  <input type="text" name="nation" id="nation" value="${ movieBean.nation }">
  <form:errors cssClass="err" path="nation"/>
 </p> --%>
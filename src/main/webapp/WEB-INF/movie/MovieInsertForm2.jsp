<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../common/common.jsp" %>
<script type="text/javascript">
//var f_selbox = new Array('아시아', '아프리카', '유럽', '아메리카','오세아니아');
var s_selbox = new Array();
s_selbox[0] = new Array('대한민국', '일본', '중국', '싱가폴', '필리핀');
s_selbox[1] = new Array('프랑스', '이탈리아', '독일', '스페인','체코');
s_selbox[2] = new Array('미국', '캐나다','그린란드');
s_selbox[3] = new Array('이집트', '수단', '모로코', '알제리');
s_selbox[4] = new Array('뉴질랜드', '오스트레일리아', '피지', '사모아');


	function firstChange(f) {
		var f_sel = f.continent; //첫번째 셀렉트박스
		var s_sel = f.nation; //두번째 셀렉트박스

		var sel = f_sel.selectedIndex; //선택을 선택하면 0, 아시아 선택하면 1, 아프리카 선택하면 2....
		var sel_val = f_sel[sel].value; //'아시아', '아프리카', '유럽', '아메리카','오세아니아'

		alert(sel); //선택을 선택하면 0, 아시아 선택하면 1, 아프리카 선택하면 2....
		alert(sel_val); //'아시아', '아프리카', '유럽', '아메리카','오세아니아'

		//새로운 대륙의 나라를 넣기위해 기존 앞의 대륙나라를 지우는것이다.    
		for (var i = s_sel.length; i >= 0; i--) { //i=4,3,2,1
			s_sel.options[i] = null;
		}

		//value를 빈칸으로 두는 이유는 null값이 나오는지 안나오는지
		s_sel.options[0] = new Option("선택", ""); //text,value

		if (sel != 0) { //sel 선택 '선택'이 아니면/ 1아시아,2아프리카,3유럽,4아메리카,5오세아니아 선택시

			for (var i = 0; i < s_selbox[sel - 1].length; i++) {//s_selbox 0번방,1번방,2번방,3번방......

				s_sel.options[i + 1] = new Option(s_selbox[sel - 1][i],
						s_selbox[sel - 1][i]);
				//s_sel.options[i + 1] 두번째 셀렉트박스// = s_selbox[][] 0.0번방,1.1번방,2.2번방,3.3번방
			}
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
<h2>영화 정보 등록 화면</h2>

<form:form commandName="movie" action="insert.mv" method="post">
 <p>
  <label for="title">영화 제목 : </label>
  <input type="text" name="title" id="title" value="${ movieBean.title }">
  <form:errors cssClass="err" path="title"/>
 </p>
 
 <p>
  <label for="continent">대륙 : </label>
  <select name="continent" id="continent" onchange="firstChange(this.form);">
  	<option value="">대륙 선택하세요</option>
  	<c:forEach var="continent" items="아시아,유럽,아메리카,아프리카,오세아니아">
  		<option value="${continent }">${continent }</option>
  	</c:forEach>
  </select>
  <form:errors cssClass="err" path="continent"/>
  
  <label for="nation">나라 : </label>
  <select name="nation">
  	<option value="">나라 선택하세요</option>
  	<c:forEach var="list" items="${continent.selected }">
	  	<c:choose>
		  	<c:when test="${list == '아시아' }">
			  	<c:forEach var="nation" items="한국,일본,중국">
			  		<option value="${nation }">${nation }</option>
			  	</c:forEach>
		  	</c:when>
		  	<c:when test="${list eq '유럽' }">
			  	<c:forEach var="nation" items="영국,프랑스,독일">
			  		<option value="${nation }">${nation }</option>
			  	</c:forEach>
		  	</c:when>
		  	<c:when test="${list == '아메리카' }">
			  	<c:forEach var="nation" items="미국,캐나다,칠레">
			  		<option value="${nation }">${nation }</option>
			  	</c:forEach>
		  	</c:when>
	  	</c:choose>
  	</c:forEach>
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
  <input type="submit" value="추가하기">
 </p>
</form:form>

<%--  <p>
  <label for="continent">대륙 : </label>
  <input type="text" name="continent" id="continent" value="${ movieBean.continent }">
  <form:errors cssClass="err" path="continent"/>
  
  <label for="nation">나라 : </label>
  <input type="text" name="nation" id="nation" value="${ movieBean.nation }">
  <form:errors cssClass="err" path="nation"/>
 </p> --%>
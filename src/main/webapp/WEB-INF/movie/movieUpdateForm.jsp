<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

movieUpdateForm.jsp<br>

<%@page import="movie.model.MovieBean"%>
<%@ include file = "../common/common.jsp" %>
<%
	String[] genreArr = {"액션", "스릴러", "코미디", "판타지", "애니메이션"};
	String[] gradeArr = {"19", "15", "12", "7"};
%>
<script type = "text/javascript">
var f_selbox = new Array('아시아','아프리카','유럽','아메리카','오세아니아');
var s_selbox = new Array();
s_selbox[0] = new Array('한국','중국','베트남','네팔');
s_selbox[1] = new Array('케냐', '가나', '세네갈');
s_selbox[2] = new Array('스페인', '영국','덴마크','러시아','체코');
s_selbox[3] = new Array('미국', '캐나다');
s_selbox[4] = new Array('뉴질랜드','오스트레일리아');

	function init(f){
		var findex;
		for(i=0; i< f_selbox.length;i++){
			f.first.options[i+1] = new Option(f_selbox[i]); //옵션 추가
		}
		for(i=0; i < f.first.length; i++){
			if(f.first.options[i].value == "${movieBean.continent}"){ //일치 조건 
				f.first.options[i].setAttribute("selected", "selected"); //속성 추가
				findex = f.first.selectedIndex;
			}
		}
		if(f.first.options[findex].value != ""){
			for(i = 0; i < s_selbox[findex-1].length; i++){
				f.second.options[i+1] = new Option(s_selbox[findex-1][i]);	
			}
			for(i=0; i < f.second.length; i++){
				if(f.second.options[i].value == "${movieBean.nation}"){
					f.second.options[i].setAttribute("selected", "selected");
				}
			}
		}
	}
	
	function firstSelect(f){
		findex = f.first.selectedIndex;
		fvalue = f.first[findex].value;
		for(i = f.second.length-1; i > 0; i--){ 
			f.second.options[i] = null;
		}
		for(i = 0; i < s_selbox[findex-1].length; i++){
			f.second.options[i+1] = new Option(s_selbox[findex-1][i]);	
		}
	}
</script>
<style>
	.err{
		color: red;
		font-weight: bold;
		font-size: 10px;
	}
</style>
<body onLoad = "init(myform)">
<h2 align = "center">영화 정보 수정 화면</h2>
<form:form commandName = "movieBean" name = "myform" action = "update.mv" method = "post">
<input type = "hidden" name = "num" value = "${movieBean.num }">
<input type = "hidden" name = "pageNumber" value = "${pageNumber }">

<table border = "1" width = "60%" align = "center">
	<tr>
		<td>영화 제목 :</td>
		<td><input type = "text" name = "title" value = "${movieBean.title }">
		<form:errors cssClass="err" path = "title"/>
	</tr>
	<tr>
		<td>대륙 : </td>
		<td><select id = "first" name = "continent" onChange = firstSelect(myform)>
		<option value = "">대륙 선택하세요</option>
		</select>
		<form:errors cssClass="err" path = "continent"/></td>
	</tr>
	<tr>
		<td>나라 : </td>
		<td><select id = "second" name = "nation">
		<option value = "">나라 선택하세요</option>
		</select>
		<form:errors cssClass="err" path = "nation"/>
		</td>
	</tr>
	<tr>
		<td>장르 :</td>
		<td>
		<c:forEach var = "genre" items = "<%= genreArr %>">
			<input type = "checkbox" name = "genre" value = ${genre } <c:if test = "${fn:contains(movieBean.genre, genre) }"> checked</c:if>>${genre }
		</c:forEach>
		<form:errors cssClass="err" path = "genre"/></td>
	</tr>
	<tr>
		<td>등급 :</td>
		<td>
		<c:forEach var = "grade" items = "<%= gradeArr %>">
			${grade }<input type = "radio" name = "grade" value = "${grade }" <c:if test = "${grade eq movieBean.grade }"> checked</c:if>>
		</c:forEach>
		<form:errors cssClass="err" path = "grade"/></td>
		</tr>
	<tr>
		<td>출연 배우 :</td> 
		<td><input type = "text" name = "actor" value = "${movieBean.actor }"></td>
	</tr>
	<tr>
		<td colspan = "2" align = "center"><input type = "submit" value = "수정하기"></td>
	</tr>
</table>
</form:form>
</body>

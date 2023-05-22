<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<script type="text/javascript">
	function insert() {
		location.href = "insert.mv"; //get방식 요청
	}
	function goUpdate(num,pageNumber){
		//alert(num+"."+pageNumber);
		location.href = "update.mv?num="+num+"&pageNumber="+pageNumber+""
	}
</script>    
MovieList.jsp<br>
<h2 align="center">여행 리스트 화면</h2>
<center>
	<form action="list.mv" method="get">
		<select name="whatColumn">
			<option value="">전체검색</option>
			<option value="genre">장르</option>
			<option value="grade">등급</option>
			<option value="actor">배우</option>
		</select>
		<input type="text" name="keyword">
		<input type="submit" value="검색">
	</form>
</center>
<center>
<table border="1">
	<tr>
		<td colspan="9" align="right">
			<input type="button" value="추가하기" onClick="insert()">
		</td>
	</tr>
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>대륙</th>
		<th>제작국가</th>
		<th>장르</th>
		<th>등급</th>
		<th>출연배우</th>
		<th>삭제</th>
		<th>수정</th>
	</tr>
	<c:if test="${empty lists}">
		<tr>
			<td colspan="9" align="center">
				검색 결과가 없습니다.
			</td>
		</tr>
	</c:if>
	<c:if test="${! empty lists}">
		<c:forEach var="movie" items="${lists}">
		<tr>
			<td align="center">${movie.num}</td>
			<td><a href="detail.mv?num=${movie.num }&pageNumber=${pageInfo.pageNumber }">${movie.title}</a></td>
			<td>${movie.continent}</td>
			<td>${movie.nation}</td>
			<td>${movie.genre}</td>
			<td>${movie.grade}</td>
			<td>${movie.actor}</td>
			<td>
				<a href="delete.mv?num=${movie.num }&pageNumber=${pageInfo.pageNumber}">삭제</a>
			</td>
			<td>
				<input type="button" value="수정" onclick="goUpdate(${movie.num},${pageInfo.pageNumber })">
			</td>
		</tr>
		</c:forEach>
	</c:if>
</table>
</center>

<center>
	${pageInfo.pagingHtml}
</center>

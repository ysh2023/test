<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
MovieDetailForm
<center>
	<h2>영화 상세 화면</h2>
	<table border="1">
		<tr>
			<th width="100">번호</th>
			<td width="200">${movie.num }</td>
		</tr>
		<tr>
			<th>영화제목</th>
			<td>${movie.title }</td>
		</tr>
		<tr>
			<th>제작국가</th>
			<td>${movie.nation }</td>
		</tr>
		<tr>
			<th>장르</th>
			<td>${movie.genre }</td>
		</tr>
		<tr>
			<th>등급</th>
			<td>${movie.grade }</td>
		</tr>
		<tr>
			<th>배우</th>
			<td>${movie.actor }</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<a href="list.mv?pageNumber=${pageNumber}">영화 리스트 화면으로 돌아감</a>
			</td>
		</tr>
	</table>
</center>
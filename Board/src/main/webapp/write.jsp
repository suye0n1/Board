<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/write.css">
<title>Insert title here</title>
</head>
<body>
	<div class="box">
		<!-- banner -->
		<div class="banner">
			<div id="mypage">
				<a href="mypage.jsp">🌳마이페이지🌳</a>
				<a href="index.jsp">🌴목록🌴</a>
			</div>
		</div>

		<!-- board -->
		<!-- 게시판 리스트 -->
		<div class="board_list">
			<div id="write">
				<%
				String login_id = (String) session.getAttribute("idKey");
				%>
<!-- 				<h2>글 작성하기</h2> -->
				<form action="ServletWrite" method="get">
					<table border:"1px solid #dddddd" width="1000" height="500">
						<tr>
							<!-- 							<th>작성자:</th> -->
							<td><input name = "id" value="<%=login_id%>"> <%-- 	<%=b_id %> --%> <!-- 	<input name="id"> -->
							</td>
						</tr>
						<tr>
							<!-- 							<th>글제목:</th> -->
							<td><input name="title" id="title" placeholder="글 제목"></td>
						</tr>

						<tr>
							<!-- 							<th>내용:</th> -->
							<td><textarea name="content" id="content" rows="25" cols="50"
									placeholder="글 내용을 입력하세요"></textarea></td>
						</tr>
<!-- 						<tr> -->
<!-- 							<td id="w" colspan="4"><input type="submit" value="제출"> -->
<!-- 							</td> -->
<!-- 						</tr> -->
					</table>
<!-- 					제출버튼이 form태그 안에 존재 -->
					<input type="submit" value="제출">					
					</form>
					</div>
					</div>
					<div class="bot">
						<div id="list_button">
						</div>
					</div>
			</div>
</body>
</html>
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
				<a href="mypage.jsp">๐ณ๋ง์ดํ์ด์ง๐ณ</a>
				<a href="index.jsp">๐ด๋ชฉ๋ก๐ด</a>
			</div>
		</div>

		<!-- board -->
		<!-- ๊ฒ์ํ ๋ฆฌ์คํธ -->
		<div class="board_list">
			<div id="write">
				<%
				String login_id = (String) session.getAttribute("idKey");
				%>
<!-- 				<h2>๊ธ ์์ฑํ๊ธฐ</h2> -->
				<form action="ServletWrite" method="get">
					<table border:"1px solid #dddddd" width="1000" height="500">
						<tr>
							<!-- 							<th>์์ฑ์:</th> -->
							<td><input name = "id" value="<%=login_id%>"> <%-- 	<%=b_id %> --%> <!-- 	<input name="id"> -->
							</td>
						</tr>
						<tr>
							<!-- 							<th>๊ธ์ ๋ชฉ:</th> -->
							<td><input name="title" id="title" placeholder="๊ธ ์ ๋ชฉ"></td>
						</tr>

						<tr>
							<!-- 							<th>๋ด์ฉ:</th> -->
							<td><textarea name="content" id="content" rows="25" cols="50"
									placeholder="๊ธ ๋ด์ฉ์ ์๋ ฅํ์ธ์"></textarea></td>
						</tr>
<!-- 						<tr> -->
<!-- 							<td id="w" colspan="4"><input type="submit" value="์ ์ถ"> -->
<!-- 							</td> -->
<!-- 						</tr> -->
					</table>
<!-- 					์ ์ถ๋ฒํผ์ด formํ๊ทธ ์์ ์กด์ฌ -->
					<input type="submit" value="์ ์ถ">					
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
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
<%
// 				String w_id = (String) session.getAttribute("w_id");
				%>
	<div class="box">
		<!-- banner -->
		<div class="banner">
			<div id="mypage">
				<a href="mypage.jsp">🌳마이페이지🌳</a>
				<a href="index.jsp">🌴목록🌴</a>
			</div>
		</div>
		<%
		// String login_id = (String)session.getAttribute("idKey");
// 		w_id 저장
		String w_id = request.getParameter("w_id");
		String editNum = request.getParameter("num");
		String title = null;
		// 	String id = null;
		String content = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "root");
			Statement st = con.createStatement(); // Statement는 정적 SQL문을 실행하고 결과를 반환받기 위한 객체다. Statement하나당 한개의 ResultSet 객체만을 열 수있다.
			String sql = "select * from board_1 where num=" + editNum;
			System.out.println("전송 sql:" + sql);
			ResultSet rs = st.executeQuery(sql); //sql 전송???
			rs.next();
			title = rs.getString("title");
			// 			id= rs.getString("id");
			content = rs.getString("content");

		} catch (Exception e) {

			e.printStackTrace();
		}
		%>
		<div class="board_list">
			<div id="modify">
				
<!-- 				<h3>글 수정 페이지</h3> -->
				<%-- 	수정할 글 번호:<%=editNum %><br> --%>
				<form action="ServletEdit" method="get">

					<input name="num" type="hidden" value="<%=editNum%>">
					
					<table  width="1000" height="500">
						<tr>
							<!-- 							<th>작성자:</th> -->
							<td><input name="id" value="<%=w_id%>"> <%-- 	<%=b_id %> --%> <!-- 	<input name="id"> -->
							</td>
						</tr>
						<tr>
							<!-- 							<th>글제목:</th> -->
							<td><input name="title" id="title" placeholder="글 제목"></td>
						</tr>

						<tr>
							<!-- 							<th>내용:</th> -->
							<td><textarea name="content" id="content" rows="25"
									cols="50" placeholder="글 내용을 입력하세요"></textarea></td>
						</tr>
					</table>
<!-- 		수정 버튼이	form태그 안에 있어야 작동 -->
		<input type="submit" id="modify_button" value="수정">
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
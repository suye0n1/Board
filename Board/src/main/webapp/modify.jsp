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
				<a href="mypage.jsp">๐ณ๋ง์ดํ์ด์ง๐ณ</a>
				<a href="index.jsp">๐ด๋ชฉ๋ก๐ด</a>
			</div>
		</div>
		<%
		// String login_id = (String)session.getAttribute("idKey");
// 		w_id ์ ์ฅ
		String w_id = request.getParameter("w_id");
		String editNum = request.getParameter("num");
		String title = null;
		// 	String id = null;
		String content = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "root");
			Statement st = con.createStatement(); // Statement๋ ์ ์  SQL๋ฌธ์ ์คํํ๊ณ  ๊ฒฐ๊ณผ๋ฅผ ๋ฐํ๋ฐ๊ธฐ ์ํ ๊ฐ์ฒด๋ค. Statementํ๋๋น ํ๊ฐ์ ResultSet ๊ฐ์ฒด๋ง์ ์ด ์์๋ค.
			String sql = "select * from board_1 where num=" + editNum;
			System.out.println("์ ์ก sql:" + sql);
			ResultSet rs = st.executeQuery(sql); //sql ์ ์ก???
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
				
<!-- 				<h3>๊ธ ์์  ํ์ด์ง</h3> -->
				<%-- 	์์ ํ  ๊ธ ๋ฒํธ:<%=editNum %><br> --%>
				<form action="ServletEdit" method="get">

					<input name="num" type="hidden" value="<%=editNum%>">
					
					<table  width="1000" height="500">
						<tr>
							<!-- 							<th>์์ฑ์:</th> -->
							<td><input name="id" value="<%=w_id%>"> <%-- 	<%=b_id %> --%> <!-- 	<input name="id"> -->
							</td>
						</tr>
						<tr>
							<!-- 							<th>๊ธ์ ๋ชฉ:</th> -->
							<td><input name="title" id="title" placeholder="๊ธ ์ ๋ชฉ"></td>
						</tr>

						<tr>
							<!-- 							<th>๋ด์ฉ:</th> -->
							<td><textarea name="content" id="content" rows="25"
									cols="50" placeholder="๊ธ ๋ด์ฉ์ ์๋ ฅํ์ธ์"></textarea></td>
						</tr>
					</table>
<!-- 		์์  ๋ฒํผ์ด	formํ๊ทธ ์์ ์์ด์ผ ์๋ -->
		<input type="submit" id="modify_button" value="์์ ">
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
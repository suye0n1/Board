<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.db.Dao"%>
<%@page import="com.db.Dto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/read.css">
<title>Insert title here</title>
</head>
<body>

	<div class="box">
		<!-- banner -->
		<div class="banner">
			<div id="mypage">
				<a href="index.jsp">π΄λͺ©λ‘π΄</a>
			</div>
		</div>
		<!-- 		
		<!-- board -->
		<!-- κ²μν λ¦¬μ€νΈ -->
		<div class="board_list">
			<div id="read">
				<!-- <h2>κ²μν κΈ λ³΄κΈ°</h2> -->
				<%
				// 	getParameter: httpμμ²­μμ κ°μ μ»κΈ° μν΄ μ¬μ©/ ν΄λΌμ΄μΈνΈκ° μλ ₯ν κ°μ μ μ μμ
				String readNum = request.getParameter("num");

				Dao dao = new Dao();
				Dto d = dao.read(readNum);

				// 		w_id(μμ±μ μμ΄λ)κ°μ²΄μ κ°μ μ μ₯
				// 						session.setAttribute("w_id", id);
				// 						session.setMaxInactiveInterval(60 * 50);
				%>
				<div id="b_top">
					<div><%=d.num%><hr>
					</div>
					<div>
						μ λͺ©
						<hr>
					</div>
					<div><%=d.title%><hr>
					</div>
					<div><%=d.id%><hr>
					</div>
					<div><%=d.hits%><hr>
					</div>
					<div><%=d.dt%><hr>
					</div>
				</div>

				<%-- 	<td colspan="4"><a href="read.jsp?num=<%=num%>"><%=title %></a></td> --%>

				<div id="b_mid">
					<div>
						<%-- 	<textarea rows="20" cols="55"><%=content %></textarea> --%>
						<%=d.content%>
					</div>
				</div>

				<div id="b_bot">
					<div id="b_re">λκΈκΈ°λ₯</div>
					<div>
						<form action="proc/replyproc.jsp" method="get">
							<input name="re" id="re" placeholder="λκΈ"> <input
								type="button" value="μμ±">
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="bot">
			<div>
				<a href="modify.jsp?num=<%=readNum%>&w_id=<%=d.id%>"><input type="button"
					value="μμ "></a> <input
					type="button" value="μ­μ " onclick="location.href='ServletDel?num=<%=readNum%>&w_id=<%=d.id%>'">
			</div>
		</div>
	</div>
</body>
</html>
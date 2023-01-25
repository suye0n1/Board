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
				<a href="index.jsp">🌴목록🌴</a>
			</div>
		</div>
		<!-- 		
		<!-- board -->
		<!-- 게시판 리스트 -->
		<div class="board_list">
			<div id="read">
				<!-- <h2>게시판 글 보기</h2> -->
				<%
				// 	getParameter: http요청에서 값을 얻기 위해 사용/ 클라이언트가 입력한 값을 알 수 있음
				String readNum = request.getParameter("num");

				Dao dao = new Dao();
				Dto d = dao.read(readNum);

				// 		w_id(작성자 아이디)객체에 값을 저장
				// 						session.setAttribute("w_id", id);
				// 						session.setMaxInactiveInterval(60 * 50);
				%>
				<div id="b_top">
					<div><%=d.num%><hr>
					</div>
					<div>
						제목
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
					<div id="b_re">댓글기능</div>
					<div>
						<form action="proc/replyproc.jsp" method="get">
							<input name="re" id="re" placeholder="댓글"> <input
								type="button" value="작성">
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="bot">
			<div>
				<a href="modify.jsp?num=<%=readNum%>&w_id=<%=d.id%>"><input type="button"
					value="수정"></a> <input
					type="button" value="삭제" onclick="location.href='ServletDel?num=<%=readNum%>&w_id=<%=d.id%>'">
			</div>
		</div>
	</div>
</body>
</html>
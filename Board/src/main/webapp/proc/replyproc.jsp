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
<title>Insert title here</title>
</head>
<body>

<%

String re_text = request.getParameter("re");

//	로그인한 아이디
String login_id = (String)session.getAttribute("idKey");


try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "root");
		Statement st = con.createStatement();
		
		String sql = "insert into board_1 (w_id,re_text) values('"+login_id +"','"+re_text+"')";

		System.out.println("전송 sql:" + sql);		
		int resultCount = st.executeUpdate(sql);	// 글쓰기 sql 전송

		
		if(resultCount == 1){
			System.out.println("댓글 쓰기 성공");
			%>	<script>
			alert('댓글 작성 완료!');
			</script>
			<script>
			location.href = '../read.jsp'
			</script>

		<% 	
		} else {
			System.out.println("댓글 작성 실패");
			%>	<script>
			alert('댓글 작성 실패!');
			</script>
			<script>
			location.href = '../read.jsp'
			</script>

		<% 	
		}
	} catch (Exception e) {		
		e.printStackTrace();
	}
	%>

</body>
</html>
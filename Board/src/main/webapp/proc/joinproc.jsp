<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%-- <%@ page import="java.sql.*" %>  --%>
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
	// request.getParameter("id");은 login.jsp에서 지정한 name
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
// 	String pw_c = request.getParameter("pw_check");
	String name2 = request.getParameter("user_name"); 
	
	//입력하지 않으면 경고창
	if (name2.equals("")) {
	%>
	<script>
		alert('이름을 입력하세요');
	</script>
	<script>
		location.href = '../join.html'
	</script>

	<%
	} else if (id.equals("")) {
	%>
	<script>
		alert('아이디를 입력하세요');
		location.href = '../join.html'
	</script>
	<%
	} else if (pw.equals("")) {
	%>
	<script>
		alert('비밀번호를 입력하세요');
		location.href = '../join.html'
	</script>
	<%
	} 
 else {

	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "root");
		stmt = con.createStatement();
		String sql = "insert into b_member values('" + id + "','" + pw + "','" + name2 + "')";
		System.out.println("sql:" + sql);
		int resultCount = stmt.executeUpdate(sql);

		//회원가입 완료시
		if (id != null && pw != null && name2 != null) {
	%>
	<script>
		alert('회원가입이 완료되었습니다.');
		location.href = '../index.jsp'
	</script>
	<%
	}
	
	} catch (Exception e) {
	e.printStackTrace();
	
	}
 }
	// 	response.sendRedirect("../index.jsp");
	
	%>

</body>
</html>
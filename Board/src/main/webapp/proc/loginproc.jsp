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


//로그인 입력을 하지 않으면 계속 login 페이지에 있도록
// if(id.equals("")){
// 	response.sendRedirect("../login.html");
// }

//아이디와 비밀번호를 입력하지 않으면 경고창 뜨도록
if(id.equals("")){
%>	<script>
	alert('아이디를 입력하세요');
	</script>
	<script>
	location.href = '../login.html'
	</script>

<% }	else if(pw.equals("")) {
%>	<script>
	alert('비밀번호를 입력하세요');
	</script>
	<script>
	location.href = '../login.html'
	</script>
<%}	else{


Connection con = null;
Statement stmt = null;
ResultSet rs = null;

try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "root");
	stmt = con.createStatement();
	rs = stmt.executeQuery("select * from b_member where s_id='"+id+"'");
	rs.next();

	String pwTemp = rs.getString("s_pw");
	String idTemp = rs.getString("s_id");
// 	1.이름, 아이디를 변수에 저장
	String s_name = rs.getString("s_name");
	String s_id = rs.getString("s_id");
// 	2.객체에 값을 저장
	session.setAttribute("nameKey",s_name);
// 	session.setMaxInactiveInterval(60*50);
	session.setAttribute("idKey",s_id);
// 	session.setMaxInactiveInterval(60*50);

//아이디와 비밀번호를 잘못 입력했을 경우	
// 	db에서 지정한 이름	
	if(pw.equals(pwTemp) && id.equals(idTemp)){
		System.out.println("로그인 성공");
		%>
		<script>
		alert('로그인 성공! 게시판 이용이 가능합니다');
		location.href = '../login_page.jsp'
		</script>
<!-- 		response.sendRedirect("../index.jsp"); -->
<% 
	}	
		else{
%>			<script>
			alert('로그인 실패! 다시 입력하세요');
			location.href = '../login.html'
			</script>
<%		 	
		}
	rs.close();
	stmt.close();
	con.close();	
		
}
	catch (SQLException e) {		
		System.out.println("SQLException:"+e);
	} catch (Exception e) {		
		e.printStackTrace();
	}	finally {
		if(stmt!=null){
			stmt.close();
		}
		if(con!=null){
			con.close();
		}
	}


}
%>		
	
	
</body>
</html>
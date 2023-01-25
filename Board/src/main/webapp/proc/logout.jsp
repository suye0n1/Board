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
//  	설정된 세션의 값들을 모두 사라지도록
	session.invalidate();
	out.println("<script>alert('로그아웃되었습니다.')</script>");
	out.println("<script>location.href = '../index.jsp'</script>");
	%>
	
</body>
</html>
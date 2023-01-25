package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import com.db.Dao;
import com.db.Dto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ServletEdit")
public class ServletEdit extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 id가 같을 경우에만 수정 가능하도록
	String editNum = request.getParameter("num");
	String title = request.getParameter("title");
	String w_id = request.getParameter("id");
	String content = request.getParameter("content");

// 	로그인한 아이디
	HttpSession session = request.getSession();	
	String login_id = (String)session.getAttribute("idKey");
// 	작성자 아이디
//	HttpSession session_2 = request.getSession();	
//	String w_id = (String)session.getAttribute("w_id");

	if(login_id.equals(w_id)){

	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "root");
		Statement st = con.createStatement();
//	 	큰 따옴표, 작은 따옴표 주의
		String sql = "update board_1 set "
					+"title='"
					+title
					+"',"
					+"id='"
					+w_id
					+"',"
					+"content='"
					+content
					+"'"
					+"where num=" + editNum;
		System.out.println("sql:"+sql);

		int resultCount = st.executeUpdate(sql); //글쓰기 sql 전송
		if(resultCount == 1){
			System.out.println("글 수정 완료");
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();	//out객체
			out.println("<script>");
			out.println("alert('수정되었습니다.')");
			out.println("location.href='/login_page.jsp'");
			out.println("</script>");
		}

	} catch (Exception e) {		
		e.printStackTrace();
	}
	}				else {
		System.out.println("수정 권한이 없습니다.");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();	//out객체
		out.println("<script>");
		out.println("alert('수정 권한이 없습니다.')");
		out.println("location.href='/login_page.jsp'");
		out.println("</script>");
		}
	
// 	response.sendRedirect("../board.jsp");

}
}

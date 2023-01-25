package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import com.db.Dao;
import com.db.Dto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ServletWrite")
public class ServletWrite extends HttpServlet {
	@Override
	// 오류: class com.servlet.ServletWrite cannot be cast to class
	// jakarta.servlet.Servlet
	// 상속 extends HttpServlet
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
// 	글을 작성하고 난 후 글 리스트에 로그인한 아이디가 저장되려면 1.로그인 아이디를 저장한 객체(idKey)를 변수에 저장
//		HttpSession session = request.getSession();	
//		String login_id = (String) session.getAttribute("idKey");
		// id가 계속 null값으로 찍힘(dto에서 객체 생성을 안해줬기 때문에)
		Dto dto = new Dto(request.getParameter("title"), request.getParameter("content"), request.getParameter("id"));
		Dao dao = new Dao();

// write.jsp에서 쓴 제목과 내용을 저장함
		String title = request.getParameter("title");
		String content = request.getParameter("content");
//  	String id = request.getParameter("id");

// 제목, 내용이 null이 아니라면
//조건을 title != null && content != null 했을 때 작동x null값이 아니라 ""을 줘야됨
		if(title == "" || content == "") 
		{
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('글쓰기 실패')");
			out.println("location.href='/write.jsp'");
			out.println("</script>");

		}	else {
			
			dao.write(dto);
			System.out.println("글쓰기 성공");
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('글쓰기 성공')");
			out.println("location.href='/login_page.jsp'");
			out.println("</script>");
			
		}

// 	response.sendRedirect("../board.jsp");	// 글리스트 화면으로 강제 이동

	}
}
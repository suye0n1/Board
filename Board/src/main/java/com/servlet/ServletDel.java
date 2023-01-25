package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import com.db.Dao;

@WebServlet("/ServletDel")
public class ServletDel extends HttpServlet {
	//애너테이션:주석처럼 프로그램에 영향을 미치지 않으면서 유용한 정보를 제공하는 것
	//@Override를 달면 컴파일러가 해당 메서드가 오버라이딩 메서드인지 체크해줌
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String no = request.getParameter("num");
		Dao dao = new Dao();

		String delNum = request.getParameter("num");
		// 	로그인한 아이디와 작성한 아이디를 비교
		// 	1.로그인한 아이디
		HttpSession session = request.getSession();	//session 객체
		String login_id = (String)session.getAttribute("idKey");
		// 	2.작성자 아이디
		//오류: read.jsp에 W_id가 안넘어온 상태에서 비교하려고 하니깐 w_id에 null값이 들어감
		//String w_id = (String) session.getAttribute("idKey");
		//해결1.read.jsp에서 &w_id=<%=d.id%> 해주고
		String w_id = request.getParameter("w_id");	//2.getParameter로 받아와서 w_id에 넘겨주기
		// ==연산자와 equals()메서드의 가장 큰 차이점
		// 연산자는 비교하고자 하는 두개의 대상의 주소값을 비교하고 String클래스의 equals 메소드는 비교하고자 하는 두개의 대상의 값 자체를 비교한다
		if (login_id.equals(w_id)) {
			dao.del(no);
			response.setContentType("text/html; charset=utf-8"); //한글 깨짐 방지
			PrintWriter out = response.getWriter();	//out객체
			out.println("<script>");
			out.println("alert('삭제되었습니다.')");
			out.println("location.href='/login_page.jsp'");
			out.println("</script>");

			//response랑 sendRedirect는 같이 사용할 수 없음
			//out.println("location.href='/login_page.jsp';");로 해주기
//			response.sendRedirect("login_page.jsp");
//			페이지 이동("login_page.jsp");
	} else {

		System.out.println("삭제 권한이 없습니다.");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('글 삭제 권한이 없습니다.')");
		out.println("</script>");
		out.println("location.href='/login_page.jsp'");
		}
//	 	response.sendRedirect("../login_page.jsp"); // 글리스트 화면으로 강제 이동
	}
}

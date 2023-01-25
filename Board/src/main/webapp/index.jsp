<%@page import="com.db.Page"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.db.Dto"%>
<%@page import="com.db.Dao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/css/index.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/index.css">
<title>Insert title here</title>
</head>
<body>

	<div class="box">
		<!-- banner -->
		<div class="banner">
			<div>
				<form action="index.jsp">
					<input name="word"> <input type="submit" value="검색">
				</form>
			</div>

			<!-- 로그인 -->
			<div id="login">
				<a href="login.html">🌼로그인🌼</a>
			</div>
			<!-- 회원가입 -->
			<div id="signup">
				<a href="join.html">🌻회원가입🌻</a>
			</div>

		</div>

		<!-- Page -->
		<!-- 게시판 리스트 -->
		<div class="Page_list">
			<div id=list>
				<div id="num">
					번호
					<hr>
				</div>
				<div id="title">
					제목
					<hr>
				</div>
				<div id="id">
					작성자
					<hr>
				</div>
				<div id="hits">
					조회수
					<hr>
				</div>
				<div id="dt">
					작성일
					<hr>
				</div>


				<%
				//글리스트 출력
				String pageNum = request.getParameter("page");
				if (pageNum == null) {
					pageNum = "1";
				}

				Dao dao = new Dao();
				int totalPage = 0;
				ArrayList<Dto> posts = null;
				String searchWord = request.getParameter("word");
				
				//일반 리스트, 검색 리스트
				if (searchWord == null || searchWord.equals("null")) {
					posts = dao.list(pageNum);
					totalPage = dao.getTotalPageCount();
				} else {
					posts = dao.listSearch(searchWord, pageNum);
					totalPage = dao.getSearchTotalPageCount(searchWord);
				}
				// 				ArrayList<Dto> posts = dao.list(pageNum);

				for (int i = 0; i < posts.size(); i++) {
				%>
				<div><%=posts.get(i).num%><hr>
				</div>
				<div>
					<a href="read.jsp?num=<%=posts.get(i).num%>"><%=posts.get(i).title%></a>
					<hr>
				</div>
				<div><%=posts.get(i).id%><hr>
				</div>
				<div><%=posts.get(i).hits%><hr>
				</div>
				<div><%=posts.get(i).dt%><hr>
				</div>
				<%
				}
				%>
			</div>
		</div>
		
		<div class="bot">
			<!-- 하단 -->
		<div id="pageNum">
			<!-- 			페이지 1,2,3...... -->
			<div>
		<%
	//include를 하면 list.jsp 변수랑 다르게 설정해줘야함

	Dao dao2 = new Dao();
	int cPage2 = 1;
	String pNum = request.getParameter("page");
	if (pNum == null) {
// 				cPage2 = Integer.parseInt("pNum");
		pNum = "1";
	} else {
		cPage2 = Integer.parseInt(pNum);
	}
// 	int count = dao2.getPostCount(); //한 페이지에 들어갈 데이터(테이블의 행)의 개수

	ArrayList<Dto> posts2 = dao2.list(pNum);
	//전체 페이지 수 구하기
	// 			int tpc = 0; //전체 페이지 수
	// 			if (count % Page.PER_PAGE == 0) {
	// 				tpc = count / Page.PER_PAGE;
	// 			} else {
	// 				tpc = count / Page.PER_PAGE + 1;
	// 			}

	Dao tpc1 = new Dao(); //객체 생성
	int tp1 = tpc1.getTotalPageCount(); //총 페이지 개수
	int tpb = 0; //총 페이지 블럭 수 ex)총 6페이지일 경우 총 2페이지 {(12345) 1개 (6) 2개}
	int pb = 0; //몇 번째 페이지 블럭인지 1~5페이지면 첫 번째 블럭 6~10페이지면 두 번째 블럭

	if (cPage2 % Page.PAGE_BLOCK == 0) { //현재 페이지를 페이지블럭 단위로 나눴을 때 나머지가 0이면 (5,10,15...)가 해당
		pb = cPage2 / Page.PAGE_BLOCK; //5이면 1페이지 블럭 10이면 2페이지 블럭 15면 3페이지 블럭
		tpb = tp1 / Page.PAGE_BLOCK; //전체 페이지 블럭 수 [1][2][3][4][5] = 1페이지 [6][7][8][9][10] =2페이지 
	} else {
		pb = cPage2 / Page.PAGE_BLOCK + 1;
		tpb = tp1 / Page.PAGE_BLOCK + 1;
	}
	//첫 페이지===================================================================
	if (cPage2 > 1) {//첫 페이지로 가기
	%>
	<a href="index.jsp?page=1">처음</a>
	<%
	} else { //첫페이지면 안눌리게
	%>
	<a style="font-weight: bolder; font-size: 0.8em;">처음</a>
	<%
	}
	//이전 페이지==========================================================================
	if (cPage2 > 1) {//1페이지는 안 눌림
	if (cPage2 % Page.PAGE_BLOCK == 1) {//현재 페이지가 각 페이지 블럭의 첫 페이지면(1,6,11) 이전 블럭으로 넘어감
	%>
	<!--  	6-10 블럭에 있을 경우 1-5블럭으로 가도록 -->

	<a href="index.jsp?page=<%=((pb - 1) * Page.PAGE_BLOCK)%>">이전</a>
	<%
	} else if (cPage2 > 1) { //그냥 이전 페이지(2페이지까지만 1페이지는 이전 페이지가 없기 때문에)
	%>

	<a href="index.jsp?page=<%=(cPage2 - 1)%>">이전</a>
	<%
	}
	} else {
	%>
	<a style="font-weight: bolder; font-size: 0.8em;">이전</a>
	<%
	}
	//페이지 블럭=========================================================================
	// pb는 페이지 블럭/페이지 블럭 5개: (1-1)*5+1/1~5블럭까지 나오기 &&	전체 페이지 블럭 개수보다 작게
	for (int i = (pb - 1) * Page.PAGE_BLOCK + 1; i < ((pb - 1) * Page.PAGE_BLOCK + Page.PAGE_BLOCK + 1) && i <= tp1; i++) {
	%>
	<% 
	if (i == cPage2) {//그냥 현재 페이지면 찐하게 표시하는거.
	%>
	<a style="font-weight: bolder;"
		href="index.jsp?page=<%=i%>"><%=i%></a>
	<%
	} else {
	%>
	<a href="index.jsp?page=<%=i%>"><%=i%></a>
	<%
	}
	}
	
	//다음 페이지====================================================================================
	if (cPage2 % Page.PAGE_BLOCK == 0) {//현재 페이지가 각 페이지 블럭의 마지막 페이지면 다음 페이지로 이동
	%>
	<a href="index.jsp?page=<%=(pb * Page.PAGE_BLOCK + 1)%>">다음</a>
	<%
	} else if (cPage2 < tp1) {//if조건이 아니고 && 마지막 페이지보다 작으면 다음 페이지로 넘어감
	%>
	<a href="index.jsp?page=<%=cPage2 + 1%>">다음</a>
	<%
	} else {
	%>
	<a style="font-weight: bolder; font-size: 0.8em;">다음</a>
	<%
	}
	//마지막 페이지====================================================================================
	if (cPage2 < tp1) {
	%>
	<a href="index.jsp?page=<%=tp1%>">마지막</a>
	<%
	} else {
	%>
	<a style="font-weight: bolder; font-size: 0.8em;">마지막</a>
	<%
	}
	%>
		</div>
		</div>
			<div id="w">
				<a href="write.jsp"><input type="button" value="글쓰기"></a>
			</div>
		</div>
	</div>
</body>
</html>
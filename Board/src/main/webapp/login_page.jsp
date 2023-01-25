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
				<form action="login_page.jsp">
					<input name="word"> <input type="submit" value="검색">
				</form>
			</div>
			<!-- 로그아웃 -->
			<div id="logout">
				<a href="proc/logout.jsp">🌼로그아웃🌼</a>
			</div>
			<!-- 마이페이지 -->
			<div id="mypage">
				<a href="mypage.jsp">🌻마이페이지🌻</a>
			</div>
		</div>

		<!-- board -->
		<!-- 게시판 리스트 -->
		<div class="board_list">
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
				
				if(pageNum == null){
					pageNum = "1";
				}
				
				Dao dao = new Dao();
				int totalPage = 0;
				ArrayList<Dto> posts = null;
				String searchWord = request.getParameter("word");
				//일반 리스트, 검색 리스트
				if(searchWord==null || searchWord.equals("null")){
					posts=dao.list(pageNum);
					totalPage = dao.getTotalPageCount();
				}	else{
					posts=dao.listSearch(searchWord,pageNum);
					totalPage = dao.getSearchTotalPageCount(searchWord);
				}
// 				ArrayList<Dto> posts = dao.list(pageNum);
				
				for(int i=0; i<posts.size(); i++){
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
		<div id="pageNum">
			<div>
			<%
	//페이지 번호 조회(형 변환)
	int nPageNum = Integer.parseInt(pageNum);
	//블럭 총 개수 = 전체 글 / 블럭당 페이지 수
	//Math.ceil() 소수점 이하를 올림
	//(1,2,3,4,5) 한 블럭
	int totalBlock = (int)Math.ceil((double) totalPage / Page.PAGE_BLOCK);
	//현재 블럭 번호	(1,2,3,4,5)가 첫 번째 블럭
	int currentBlockNo = (int)Math.ceil((double) nPageNum / Page.PAGE_BLOCK);
	//블럭 시작 번호	(1)이 블럭 시작 번호
	int blockStartNo = (currentBlockNo - 1) * Page.PAGE_BLOCK + 1;
	//블럭 마지막 번호 (1,2,3,4,5)에서 (5)가 블럭 마지막 번호
	int blockEndNo = currentBlockNo * Page.PAGE_BLOCK;

	//???????
	if(blockEndNo > totalPage){
		blockEndNo = totalPage;
	}
	
	int prevPage = 0;	//이전
	int nextPage = 0;	//다음
	
	//이전 페이지 처리 
	boolean hasPrev = true;
	if(currentBlockNo == 1){	//현재 페이지가 1이라면
		hasPrev = false;	//이전 페이지 x
	}	else{				//현재 페이지가 1이 아니라면
		hasPrev = true;		//이전 페이지 o
		prevPage = (currentBlockNo - 1 ) * Page.PAGE_BLOCK;	//현재 페이지보다 앞 페이지로 가기
	}

	//다음 블럭 처리 
	boolean hasNext = true;
	if(currentBlockNo < totalBlock){	//현재 페이지 블럭  < 전체블럭 ex) 첫 페이지 블럭(1,2,3,4,5) < 첫 페이지 블럭(1,2,3,4,5) 두 번째 페이지 블럭(6,7,8,9,10)
		hasNext = true;	//다음 블럭 가기
		nextPage = currentBlockNo * Page.PAGE_BLOCK + 1;		// 다음 블럭의 첫 페이지
	} else{	//현재 블럭이 마지막 블럭보다 같거나 크면 다음 블럭 x
		hasNext = false;
	}
	//================================================================================
	////이전 페이지가 true인 경우 일반 리스트와 검색어 리스트 처리
	if(hasPrev){	//이전 페이지 true인 경우
	if(searchWord == null){	//검색어가 null일 경우
		%><a href = "login_page.jsp?page=<%=prevPage%>">[이전]</a>
	<% 
		
	}else{	//검색어 기능 
	%>
	<a href = "login_page.jsp?page=<%=prevPage%>&word=<%=searchWord%>">[이전]</a>
<% 
}
	}
	//블럭 적용
	for(int i=blockStartNo; i<blockEndNo; i++){	//[처음]블럭에서 [마지막]블럭까지 
		if(nPageNum == i){	//현재 페이지랑 i(번호)가 같으면 링크 x
%>
		<%=i %>
<% 		}else{
		if(searchWord == null){	//일반 리스트
%>			<a href = "login_page.jsp?page=<%=i%>">[<%=i%>]</a>
	<% 		
	}else{	//검색했을 때 리스트
		String urlEncodedSearchWord = java.net.URLEncoder.encode(searchWord);
%>				
		<a href="login_page.jsp?page=<%=i %>&word=<%=urlEncodedSearchWord%>">[<%=i %>]</a>		
<% 
	}
		}
	}
	
	//다음 블럭 처리
	if(hasNext){
		if(searchWord == null){
%>			<a href = "login_page.jsp?page=<%=nextPage%>">[다음]</a>
<%
		}else{
		%>
		<a href ="login_page.jsp?page=<%=nextPage%>&word=<%=searchWord%>">[다음]</a>
<% 
	}
}


 %>
 
<!-- 페이징 처리만 -->
				<!-- 			페이지 1,2,3...... -->
<%-- 				<% for(int i=1; i<=totalPage; i++){ --%>
<%-- 				%> --%>
<%-- 				<a href="index.jsp?page=<%=i%>&word=<%=searchWord%>"><<%=i%>></a> --%>
<%-- 				<% --%>
<!--  				} -->
<%-- 				%> --%>
			</div>
		</div>
		<div class="bot">
			<!-- 하단 -->
			<div id="w">
				<a href="write.jsp"><input type="button" value="글쓰기"></a>
			</div>
		</div>
	</div>
</body>
</html>
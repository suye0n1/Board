package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class Dao {
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;

	// 삭제
	public void del(String no) {
		try {
			//// 고정 1
			Class.forName(Db.DB_JDBC_DRIVER_PACKAGE_PATH);
			//// 고정 2
			con = DriverManager.getConnection(Db.DB_URL, Db.DB_ID, Db.DB_PW);
			//// 고정 3
			st = con.createStatement();

			// todo:
			// 코딩하시오:
			String sql = String.format("delete from %s where num=%s", Db.BOARD_1, no);
			int resultCount = st.executeUpdate(sql);
			if (resultCount == 1) {
				System.out.println("글 삭제 성공");
//				alert("삭제되었습니다.");
//				"../login_page.jsp"로 돌아가기
			}
			//// 고정 4
			st.close();
			//// 고정 5
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 쓰기
	public void write(Dto d) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "root");
			Statement st = con.createStatement();
			// todo login_id 저장하기
			String sql = String.format(
					"insert into %s (title,content,id,dt) values ('%s','%s','%s'," + "now()" + ");",
					Db.BOARD_1, d.title, d.content, d.id);

			System.out.println("전송 sql:" + sql);
			int resultCount = st.executeUpdate(sql); // 글쓰기 sql 전송
			if (resultCount == 1) {
				System.out.println("글쓰기 성공");

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 읽기
	public Dto read(String readNum) {
		Dto post = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "root");
			Statement st = con.createStatement();
//			update board_1 set boardCount = boardCount+1 where num=" + boardNo;
			String sql = String.format("update %s set hits = hits+1 where num=%s", Db.BOARD_1, readNum);
			st.executeUpdate(sql);
			sql = String.format("select * from %s where num=%s", Db.BOARD_1, readNum);
//			String sql = String.format("update %s set hits = hits+1 where num=%s",Db.BOARD_1,readNum);
//			ResultSet rs = st.executeupdate(sql);
			
			ResultSet rs = st.executeQuery(sql);
			rs.next();
			post = new Dto(rs.getString("num"), rs.getString("title"), rs.getString("id"), rs.getString("dt"),
					rs.getString("hits"), rs.getString("content"));
			st.close(); // [고정-4]
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return post;
	}

	//조회수
	 
	
	// 목록
	//페이징 처리
	public ArrayList<Dto> list(String page) {
		ArrayList<Dto> posts = new ArrayList<>();
		try {
			Class.forName(Db.DB_JDBC_DRIVER_PACKAGE_PATH); // [고정-1]
			con = DriverManager.getConnection(Db.DB_URL, Db.DB_ID, Db.DB_PW); // [고정-2]
			st = con.createStatement(); // [고정-3]

			int startIndex = ((Integer.parseInt(page)) - 1) * Page.PER_PAGE;
			String sql = String.format("select * from %s limit %s,%s", Db.BOARD_1, startIndex, Page.PER_PAGE);
			System.out.println("sql:" + sql);
			ResultSet rs = st.executeQuery(sql);
			while (rs.next()) {
				posts.add(new Dto(rs.getString("num"), rs.getString("title"), rs.getString("id"), rs.getString("dt"),
						rs.getString("hits")
				));
			}
			st.close(); // [고정-4]
			con.close(); // [고정-5]
		} catch (Exception e) {
			e.printStackTrace();
		}
		return posts;
	}

	// 테이블 행 총 몇 개인지
	public int getCount() {
		int count = 0;
		try {
			Class.forName(Db.DB_JDBC_DRIVER_PACKAGE_PATH); // [고정-1]
			con = DriverManager.getConnection(Db.DB_URL, Db.DB_ID, Db.DB_PW); // [고정-2]
			st = con.createStatement(); // [고정-3]

			String sql = String.format("select count(*) from %s", Db.BOARD_1);
			System.out.println("sql:" + sql);
			ResultSet rs = st.executeQuery(sql);
			rs.next();
			count = rs.getInt("count(*)");
			st.close(); // [고정-4]
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	//총 페이지 수 구하기
	public int getTotalPageCount() {
		int totalPageCount = 0;
		int count = getCount();
		
		if(count % Page.PER_PAGE == 0 ) {
			totalPageCount = count / Page.PER_PAGE;
		}	else {
			totalPageCount = count/ Page.PER_PAGE + 1;
		}
		return totalPageCount;
	}
	
	//검색 글 리스트
	public ArrayList<Dto> listSearch(String word, String page){
		ArrayList<Dto> posts = new ArrayList<>();
		try {
			Class.forName(Db.DB_JDBC_DRIVER_PACKAGE_PATH); // [고정-1]
			con = DriverManager.getConnection(Db.DB_URL, Db.DB_ID, Db.DB_PW); // [고정-2]
			st = con.createStatement(); // [고정-3]

			int startIndex = ((Integer.parseInt(page)) - 1) * 10;
			String sql = String.format("select * from %s where title like '%%%s%%' limit %s,%s", Db.BOARD_1,word,startIndex,Page.PER_PAGE);
			System.out.println("sql:" + sql);
			ResultSet rs = st.executeQuery(sql);
			while (rs.next()) {
				posts.add(new Dto(rs.getString("num"), rs.getString("title"), rs.getString("id"), rs.getString("dt"),
						rs.getString("hits")
				));
			}
			st.close(); // [고정-4]
			con.close(); // [고정-5]
		} catch (Exception e) {
			e.printStackTrace();
		}
		return posts;
		
	}
	//검색했을 때 테이블 행 수 구하기
	public int getSearchCount(String word) {
		int count = 0;
		try {
			Class.forName(Db.DB_JDBC_DRIVER_PACKAGE_PATH); // [고정-1]
			con = DriverManager.getConnection(Db.DB_URL, Db.DB_ID, Db.DB_PW); // [고정-2]
			st = con.createStatement(); // [고정-3]

			String sql = String.format("select count(*) from %s where title like '%%%s%%'", Db.BOARD_1,word);
			System.out.println("sql:" + sql);
			ResultSet rs = st.executeQuery(sql);
			rs.next();
			count = rs.getInt("count(*)");
			st.close(); // [고정-4]
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	//검색
	//검색했을 때 총 페이지 수 구하기
	public int getSearchTotalPageCount(String word) {
		int totalPageCount = 0;
		int count = getSearchCount(word);
		
		if(count % Page.PER_PAGE == 0){		
			totalPageCount = count / Page.PER_PAGE;
		}else{					
			totalPageCount = count / Page.PER_PAGE + 1;
		}
		return totalPageCount;
	}	
	
	
	
}



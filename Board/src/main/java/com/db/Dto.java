package com.db;

public class Dto {
	public String num;         
	public String title;      
	public String id;         
	public String dt;   
	public String hits;        
	public String content;
	public String login_id;
	
	public Dto(String title, String content) {
		super();
		this.title = title;
		this.content = content;
	}

	public Dto(String title,String content, String id) {
		super();
		this.title = title;
		this.content = content;
		this.id = id;
	}

	public Dto(String num, String title, String id, String dt, String hits, String content) {
		super();
		this.num = num;
		this.title = title;
		this.id = id;
		this.dt = dt;
		this.hits = hits;
		this.content = content;
	}

	public Dto(String num, String title, String login_id, String dt, String hits) {
		super();
		this.num = num;
		this.title = title;
		this.id = login_id;
		this.dt = dt;
		this.hits = hits;
	}  

	
	
}

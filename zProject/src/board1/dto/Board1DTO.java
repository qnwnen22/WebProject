package board1.dto;

public class Board1DTO {

	private int num;
	private String writer;
	private String subject;
	private String reg_date;
	private int readcount;
	private int up;
	private int ref; 
	private int re_step; 
	private int re_level;
	private String content;
	private int comment_count;//댓글 갯수, 테이블에는 없음
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getUp() {
		return up;
	}
	public void setUp(int up) {
		this.up = up;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getComment_count() {
		return comment_count;
	}
	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}
	@Override
	public String toString() {
		return "Board1DTO [num=" + num + ", writer=" + writer + ", subject=" + subject + ", reg_date=" + reg_date
				+ ", readcount=" + readcount + ", up=" + up + ", ref=" + ref + ", re_step=" + re_step + ", re_level="
				+ re_level + ", content=" + content + ", comment_count=" + comment_count + "]";
	}
	
}
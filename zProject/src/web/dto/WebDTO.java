package web.dto;

import java.sql.Date;

public class WebDTO {
	
	private String userid;
	private String userpw;
	private String username;
	private String email;
	private String hp;
	private String nickname;
	private String signUp_date;
//
	public String getUserid() {
		return userid;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getSignUp_date() {
		return signUp_date;
	}
	public void setSignUp_date(String signUp_date) {
		this.signUp_date = signUp_date;
	}
	@Override
	public String toString() {
		return "WebDTO [userid=" + userid + ", userpw=" + userpw + ", username=" + username + ", email=" + email
				+ ", hp=" + hp + ", nickname=" + nickname + ", signUp_date=" + signUp_date + "]";
	}
	public WebDTO(String userid, String userpw, String username, String email, String hp, String nickname,
			String signUp_date) {
		this.userid = userid;
		this.userpw = userpw;
		this.username = username;
		this.email = email;
		this.hp = hp;
		this.nickname = nickname;
		this.signUp_date = signUp_date;
	}
	public WebDTO() {
	}
}

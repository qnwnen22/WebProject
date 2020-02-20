package web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.PStmtKey;

import config.DB;
import web.dto.WebDTO;

public class WebDAO {

	public String SignIn(WebDTO dto) {
		System.out.println("로그인 시도 WebDAO.login() 실행");
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		String result=null;
		/* int check=0; */
		
		try {
			conn=DB.getConn2();
			String sql="select userid from web where userid=? and userpw=? ";
			pst=conn.prepareStatement(sql);
			pst.setString(1, dto.getUserid());
			pst.setString(2, dto.getUserpw());
			
			System.out.println("입력받은 id 값 : "+dto.getUserid());
			System.out.println("입력받은 pw 값 : "+dto.getUserpw());
			rs=pst.executeQuery();
			
			if(rs.next()) {
				result=rs.getString("userid");
				System.out.println("레코드가 있습니다.");
				System.out.println("아이디 : "+dto.getUserid());
				System.out.println("비밀번호 : "+dto.getUserpw());
				System.out.println("아이디 : "+result);
			}else {
				System.out.println("레코드가 없습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(pst!=null) pst.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}//end login();
	
	public int CheckPw(String userpw, String userpw_check) {
		int check=0;
		String str1=userpw;
		String str2=userpw_check;
		System.out.println("userpw : "+userpw);
		System.out.println("userpw_check : "+userpw);
		if(str1==str2) {
			check++;
		}else {
			check=0;
		}
		System.out.println("check : "+check);
		return check;
	}
	
//	회원가입
	public int SignUp(WebDTO dto) {
		Connection conn=null;
		PreparedStatement pst=null;
		int check = 0;
		try {
			conn=DB.getConn2();
			String sql = "insert into web (userid,userpw,username,email,hp) "
					+ " values(?,?,?,?,?) ";
			pst=conn.prepareStatement(sql);
			pst.setString(1, dto.getUserid());
			pst.setString(2, dto.getUserpw());
			pst.setString(3, dto.getUsername());
			pst.setString(4, dto.getEmail());
			pst.setString(5, dto.getHp());
			String userid = dto.getUserid();
			check = Check(userid);
			if(check==1) {
				System.out.println("check : "+check); 
				pst.executeUpdate();
			}else {
				System.out.println("check : "+check);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pst!=null) pst.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return check;
	}
	
	public int Check(String userid) {
		System.out.println("Check() 실행");
		int check=0;
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		
		try {
			conn=DB.getConn2();
			String sql="select userid from web where userid=?";
			pst=conn.prepareStatement(sql);
			pst.setString(1, userid);
			System.out.println("dao에서 입력받은 userid:"+userid);
			rs=pst.executeQuery();
			if(!(rs.next())) {
				check=1;
			}else {
				check=-1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(pst!=null) pst.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return check;
	}
	
	public int Check2(String nickname) {
		System.out.println("닉네임 아이디 체크( Check2() 실행)");
		int check=0;
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		
		try {
			conn=DB.getConn2();
			String sql="select nickname from web where nickname=?";
			pst=conn.prepareStatement(sql);
			pst.setString(1, nickname);
			System.out.println("dao에서 입력받은 nickname:"+nickname);
			rs=pst.executeQuery();
			if(!(rs.next())) {
				check=1;
			}else {
				check=-1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(pst!=null) pst.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return check;
	}
	
	public List<WebDTO> find_id(String username, String email){
		System.out.println("find_id() 실행");
		List<WebDTO> list=new ArrayList<>();
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		try {
			conn=DB.getConn2();
			String sql="select userid, signUp_date from web where username=? and email=?";
			pst=conn.prepareStatement(sql);
			pst.setString(1, username);
			pst.setString(2, email);
			rs=pst.executeQuery();
			
			while(rs.next()) {
				WebDTO dto=new WebDTO();
				dto.setUserid(rs.getString("userid"));
				dto.setSignUp_date(rs.getString("signUp_date"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(pst!=null) pst.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
		
	}

	public void update_pw(WebDTO dto) {
		System.out.println("update_pw() 실행");
		Connection conn=null;
		PreparedStatement pst=null;

		try {
			conn=DB.getConn2();
			String sql="update web set userpw=? where userid=? and username=? and hp=?";
			pst=conn.prepareStatement(sql);
			pst.setString(1, dto.getUserpw());
			pst.setString(2, dto.getUserid());
			pst.setString(3, dto.getUsername());
			pst.setString(4, dto.getHp());
			System.out.println("userid : "+dto.getUserid());
			System.out.println("userpw : "+dto.getUserpw());
			System.out.println("username : "+dto.getUsername());
			System.out.println("hp : "+dto.getHp());
			pst.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pst!=null) pst.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public int pwC(WebDTO dto) {
		System.out.println("pwC() 실행");
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		int result=0;
		try {
			conn=DB.getConn2();
			String sql="select userpw from web where userid=? and username=? and hp=?";
			pst=conn.prepareStatement(sql);
			pst.setString(1, dto.getUserid());
			pst.setString(2, dto.getUsername());
			pst.setString(3, dto.getHp());
			System.out.println("userid : "+dto.getUserid());
			System.out.println("username : "+dto.getUsername());
			System.out.println("hp : "+dto.getHp());
			rs=pst.executeQuery();
			if(rs.next()) {
				result=1;
				System.out.println("result="+result);
			}else {
				result=-1;
				System.out.println("result="+result);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(pst!=null) pst.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}
	public String SignUp_date(String userid) {
		System.out.println("SignUp_date() 실행");
		String signUp_date=null;
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		try {
			conn=DB.getConn2();
			String sql="select signup_date from web where userid=?";
			pst=conn.prepareStatement(sql);
			pst.setString(1, userid);
			rs=pst.executeQuery();
			signUp_date=rs.getString("signUp_date");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(pst!=null) pst.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return signUp_date;
	}

	public List<WebDTO> edit(String userid) {
		List<WebDTO> list=new ArrayList<>();
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		try {
			conn=DB.getConn2();
			String sql="select * from web where userid=?";
			pst=conn.prepareStatement(sql);
			pst.setString(1, userid);
			rs=pst.executeQuery();
			while(rs.next()){
				WebDTO dto=new WebDTO();
				dto.setUserid(rs.getString("userid"));
				dto.setUserpw(rs.getString("userpw"));
				dto.setUsername(rs.getString("username"));
				dto.setNickname(rs.getString("nickname"));
				dto.setEmail(rs.getString("email"));
				dto.setHp(rs.getString("hp"));
				list.add(dto);
				System.out.println("list : "+list);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(pst!=null) pst.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(conn!=null) conn.close();
			} catch (Exception e2) { 
				e2.printStackTrace();
			}
		}
		return list;
	}

	public void update(WebDTO dto) {
		System.out.println("update() 실행");
		Connection conn=null;
		PreparedStatement pst=null;
		
		try {
			conn=DB.getConn2();
			String sql="update web set userpw=?, username=?, nickname=?, "
					+ " email=?, hp=? where userid=?";
			pst=conn.prepareStatement(sql);
			pst.setString(1, dto.getUserpw());
			pst.setString(2, dto.getUsername());
			pst.setString(3, dto.getNickname());
			pst.setString(4, dto.getEmail());
			pst.setString(5, dto.getHp());
			pst.setString(6, dto.getUserid());
			pst.executeUpdate();
			System.out.println("userpw :"+dto.getUserpw());
			System.out.println("username :"+dto.getUsername());
			System.out.println("nickname :"+dto.getNickname());
			System.out.println("email :"+dto.getEmail());
			System.out.println("hp :"+dto.getHp());
			System.out.println("userid :"+dto.getUserid());
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pst!=null) pst.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}

}//end class

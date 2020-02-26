package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.dao.WebDAO;
import web.dto.WebDTO;

public class WebController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("웹컨트롤러 실행");
		
		String context = request.getContextPath();
		System.out.println("context : "+context);
		String uri = request.getRequestURI();
		String url=request.getRequestURL().toString();
		
		System.out.println("URI : "+uri);
		System.out.println("URL : "+url);
		WebDAO dao=new WebDAO();
		
		if(url.indexOf("login.do") != -1) {
			System.out.println("login.do 실행");
			String userid = request.getParameter("userid");
			String userpw = request.getParameter("userpw");
			String page="";
			String message="";
			
			WebDTO dto=new WebDTO();
			dto.setUserid(userid);
			dto.setUserpw(userpw);
			
			String result=dao.SignIn(dto);
			System.out.println("result : "+result);
			if(result==null) {
				message="로그인 실패";
				message = URLEncoder.encode(message, "utf-8");
				page="/login/login.jsp?message=";
				response.sendRedirect(context+page+message);
			}else {
				page="/main/main.jsp?";
				HttpSession session = request.getSession();
				session.setAttribute("userid", result);
				response.sendRedirect(context+page);
			}
			
		}else if(url.indexOf("logOut.do") != -1) {
			System.out.println("logOut.do 실행");
			HttpSession session = request.getSession();
			session.invalidate();
			response.sendRedirect(context+"/main/index.jsp");
		}
		else if(url.indexOf("signUp.do") != -1){
			System.out.println("signUp.do 실행");
			System.out.println("signUp start");
			
			String userid = request.getParameter("userid");
			String userpw = request.getParameter("userpw");
			String username = request.getParameter("username");
			String e1 = request.getParameter("email");
			String e2 = request.getParameter("select_email");
			String email=e1+"@"+e2;
			String hp = request.getParameter("hp");
			System.out.println("아이디\t비밀번호\t이름\t이메일\t전화번호");
			System.out.println(userid+"\t"+userpw+"\t"+username+"\t"+email+"\t"+hp);
			WebDTO dto = new WebDTO();
			dto.setUserid(userid);
			dto.setUserpw(userpw);
			dto.setUsername(username);
			dto.setEmail(email);
			dto.setHp(hp);
			System.out.println("아이디\t비밀번호\t이름\t이메일\t전화번호");
			System.out.println(userid+"\t"+userpw+"\t"+username+"\t"+email+"\t"+hp);
			System.out.println("성공");
			dao.SignUp(dto);
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('회원가입이 완료되었습니다.'); location.href='"+context+"/login/login.jsp';</script>");
			out.flush();
		}else if(url.indexOf("find_id.do") != -1) {
			System.out.println("find_id.go 실행");
			String username=request.getParameter("username");
			String email=request.getParameter("email");
			Map<String,Object> map=new HashMap<String, Object>();
			List<WebDTO> list=dao.find_id(username, email);
			map.put("list",list);
			map.put("count",list.size());
			request.setAttribute("map", map);
			
			String path="/login/find_id_result.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(path);
			rd.forward(request, response);
			
			
		}else if(url.indexOf("list.do")!=-1) {
			System.out.println("list.do 실행");
			String path="/webProject/boardList.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(context+path);
			rd.forward(request, response);
		
		}else if(url.indexOf("main.do")!=-1) {
			System.out.println("main.do 실행");
			String page="/main/main.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		}else if(url.indexOf("find_pw.do")!=-1) {
			System.out.println("find_pw.do 실행");
			String userid=request.getParameter("userid");
			System.out.println("userid : "+userid);
			
			request.setAttribute("userid", userid);
			String path="/login/find_pw.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(url.indexOf("find_pw_result.do")!=-1){
			System.out.println("find_pw_reuslt.do 실행");
			String userid=request.getParameter("userid");
			String username=request.getParameter("username");
			String hp=request.getParameter("hp");
			
			System.out.println("userid : "+userid);
			System.out.println("username : "+username);
			System.out.println("hp : "+hp);
			WebDTO dto=new WebDTO();
			dto.setUserid(userid);
			dto.setUsername(username);
			dto.setHp(hp);
		
			int pwc=dao.pwC(dto);
			System.out.println("int pwc="+pwc);
			if(pwc>0) {
				request.setAttribute("userid", userid);
				request.setAttribute("username", username);
				request.setAttribute("hp", hp);
				System.out.println("pwc(userid):"+userid);
				System.out.println("pwc(username):"+username);
				System.out.println("pwc(hp):"+hp);
				String path="/login/find_pw_result.jsp";
				RequestDispatcher rd=request.getRequestDispatcher(path);
				rd.forward(request, response);
			}else {
				String path="/login/find_pw.jsp";
				request.setAttribute("userid", userid);
				System.out.println("pwc(userid):"+userid);
				String result="잘못된 정보를 입력하셨습니다.\n다시 입력해주세요.";
				request.setAttribute("result", result);
				RequestDispatcher rd=request.getRequestDispatcher(path);
				rd.forward(request, response);
			}
			
		}else if(url.indexOf("update_pw.do")!=-1) {
			System.out.println("update_pw.do 실행");
			String userid=request.getParameter("userid");
			String username=request.getParameter("username");
			String hp=request.getParameter("hp");
			String userpw=request.getParameter("userpw");
			System.out.println("userid : "+userid);
			System.out.println("username : "+username);
			System.out.println("hp : "+hp);
			System.out.println("(update)userpw : "+userpw);
			WebDTO dto=new WebDTO();
			dto.setUserid(userid);
			dto.setUsername(username);
			dto.setHp(hp);
			dto.setUserpw(userpw);
			dao.update_pw(dto);
			String path="/login/login.jsp";
			response.sendRedirect(context+path);
					
		}else if(url.indexOf("id_check.do")!=-1) {
			System.out.println("id_check.do 실행");
			String userid=request.getParameter("id");
			System.out.println("id : "+userid);
			int check=dao.Check(userid);
			String a="";
			String message="";
			if(check==1) {
				message="'"+userid+"'은(는) 사용가능한 아이디 입니다.";
				a="1";
			}else {
				message="'"+userid+"'은(는) 사용중인 아이디 입니다.";
				a="0";
			}
			String path="/login/signUp.jsp";
			request.setAttribute("userid", userid);
			request.setAttribute("a", a);
			request.setAttribute("message", message);
			RequestDispatcher rd=request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(url.indexOf("nickname_check.do")!=-1) {
			System.out.println("nickname_check.do 실행");
			String nickname=request.getParameter("nick");
			System.out.println("nick : "+nickname);
			int check=dao.Check2(nickname);
			String b="";
			String message1="";
			if(check==1) {
				message1="'"+nickname+"'은(는) 사용가능한 닉네임 입니다.";
				b="1";
			}else {
				message1="'"+nickname+"'은(는) 사용중인 닉네임 입니다.";
				b="0";
			}
			String path="/login/signUp.jsp";
			request.setAttribute("message1", message1);
			request.setAttribute("nickname", nickname);
			request.setAttribute("b", b);
			RequestDispatcher rd=request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(url.indexOf("login_page.do")!=-1) {
			System.out.println("login_page.do 실행");
			String path="/login/login.jsp";
			response.sendRedirect(context+path);
		}else if(url.indexOf("signUp_page.do")!=-1) {
			System.out.println("signUp_page.do 실행");
			String path="/login/signUp.jsp";
			response.sendRedirect(context+path);
		}else if(url.indexOf("edit.do")!=-1) {
			System.out.println("edit.do 실행");
			HttpSession session = request.getSession();
			String userid=(String)session.getAttribute("userid");
			
			Map<String,Object> map=new HashMap<String, Object>();
			List<WebDTO> list=dao.edit(userid);
			map.put("list",list);
			request.setAttribute("map", map);
			String path="/main/edit.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(url.indexOf("edit_result.do")!=-1) {
			System.out.println("eidt_result.do 실행");
			String userid=request.getParameter("userid");
			String userpw=request.getParameter("userpw");
			String username=request.getParameter("username");
			String nickname=request.getParameter("nickname");
			String email=request.getParameter("email");
			String hp=request.getParameter("hp");
			System.out.println("userid : "+userid);
			System.out.println("userpw : "+userpw);
			System.out.println("username : "+username);
			System.out.println("nickname : "+nickname);
			System.out.println("email : "+email);
			System.out.println("hp : "+hp);
			WebDTO dto=new WebDTO();
			dto.setUserid(userid);
			dto.setUserpw(userpw);
			dto.setUsername(username);
			dto.setNickname(nickname);
			dto.setEmail(email);
			dto.setHp(hp);
			dao.update(dto);
			
			HttpSession session = request.getSession();
			session.invalidate();
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('수정되었습니다.재로그인 해주세요.'); location.href='"+context+"/login/login.jsp';</script>");
			out.flush();
		}else if(url.indexOf("menu1.do")!=-1) {
			System.out.println("menu1.do 실행");
			String path="/main/menu1.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(url.indexOf("menu2.do")!=-1) {
			System.out.println("menu2.do 실행");
			String path="/board0_sevlet/list.do";
			RequestDispatcher rd=request.getRequestDispatcher(path);
			rd.forward(request, response);
		}
		else if(url.indexOf("main.do")!=-1) {
			System.out.println("main.do 실행");
			String path="/main/main.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(path);
			rd.forward(request, response);
		}
		else if(url.indexOf("index.do")!=-1) {
			System.out.println("index.do 실행");
			String path="/main/index.jsp";
			response.sendRedirect(context+path);
		}
		else if(url.indexOf("signIn.do")!=-1) {
			System.out.println("signIn.do 실행");
			String path="/login/login.jsp";
			response.sendRedirect(context+path);
		}
		else if(url.indexOf("signUp0.do")!=-1) {
			System.out.println("signUp0.do 실행");
			String path="/login/signUp.jsp";
			response.sendRedirect(context+path);
		}
		else if(url.indexOf("findId.do")!=-1) {
			System.out.println("findId.do 실행");
			String path="/login/find_id.jsp";
			response.sendRedirect(context+path);
		}
		else if(url.indexOf("findPw.do")!=-1) {
			System.out.println("findPw.do 실행");
			String path="/login/find_pw.jsp";
			response.sendRedirect(context+path);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

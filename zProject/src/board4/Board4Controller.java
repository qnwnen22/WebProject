package board4;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.dto.BoardDTO;
import board4.dao.Board4DAO;
import board4.dto.Board4CommentDTO;
import board4.dto.Board4DTO;
import page.Pager;

public class Board4Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String context=request.getContextPath();
		String url=request.getRequestURL().toString();
		Board4DAO dao=new Board4DAO();
		
		if(url.indexOf("list.do")!=-1) {
			System.out.println("list.do 실행");
			//레코드 갯수 계산
			int count=dao.count();
			//페이지 나누기를 위한 처리
			int curPage=1;
			if(request.getParameter("curPage") != null) {
				curPage=Integer.parseInt(request.getParameter("curPage"));
			}
			Pager pager=new Pager(count, curPage);
			int start=pager.getPageBegin();
			int end=pager.getPageEnd();
			
			List<Board4DTO> list=dao.list(start,end);
			request.setAttribute("list", list);
			//페이지 네비게이션 출력을 위한 정보전달
			request.setAttribute("page", pager);
			
			String page="/main/board4.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("view.do")!=-1) {
			System.out.println("view.do 실행");
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println("num : "+num);
			
			int count=dao.replyCount(num);
			System.out.println("count:"+count);
			request.setAttribute("count", count);

			HttpSession session=request.getSession();
			//조회수 증가 처리
			dao.plusReadCount(num,session);
			Board4DTO dto=dao.viewReplace(num);
			request.setAttribute("dto", dto);

			String page="/board4/view.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("insert.do")!=-1) {
			System.out.println("insert.do 실행");
			String writer=request.getParameter("writer");
			String subject=request.getParameter("subject");
			String content=request.getParameter("content");
			Board4DTO dto=new Board4DTO();
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dao.insert(dto);
			String path="/board4_servlet/list.do";
			response.sendRedirect(context+path);
		}else if(url.indexOf("edit.do")!=-1) {
			int num=Integer.parseInt(request.getParameter("num"));
			String subject=request.getParameter("subject");
			String content=request.getParameter("content");
			System.out.println("num:"+num);
			System.out.println("subject:"+subject);
			System.out.println("content:"+content);
		
			String writer=request.getParameter("writer");
			String userid=request.getParameter("userid");
			System.out.println("userid:"+userid);
			System.out.println("writer:"+writer);
			
			request.setAttribute("num", num);
			request.setAttribute("subject", subject);
			request.setAttribute("content", content);
			String path="/board4/edit.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(url.indexOf("update.do")!=-1){ 
			int num=Integer.parseInt(request.getParameter("num"));
			String subject=request.getParameter("subject");
			String content=request.getParameter("content");
			Board4DTO dto=new Board4DTO();
			System.out.println("num:"+num);
			System.out.println("subject:"+subject);
			System.out.println("content:"+content);
			dto.setNum(num);
			dto.setSubject(subject);
			dto.setContent(content);
			
			dao.update(dto);
			String page="/board4_servlet/list.do";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		}else if(url.indexOf("delete.do")!=-1) {
			int num=Integer.parseInt(request.getParameter("num"));
			dao.delete(num);
			
			String page="/board4_servlet/list.do";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("up.do")!=-1) {
			int num=Integer.parseInt(request.getParameter("num"));
			dao.up(num);
			
			String page="/board4_servlet/list.do";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		}else if(url.indexOf("commentList.do")!=-1) {
			System.out.println("commentList.do 실행");
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println("댓글을 위한 게시물번호:"+num);
			//댓글 목록 리턴commentList.do
			List<Board4CommentDTO> list=dao.commentList(num);
			request.setAttribute("list", list);
			//출력 페이지 이동
			String page="/board4/comment_list.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("comment_add.do")!=-1) {
			System.out.println("comment_add.do 실행");
			Board4CommentDTO dto=new Board4CommentDTO();
			//게시물 번호
			int board_num=Integer.parseInt(request.getParameter("board_num"));
			String writer=request.getParameter("writer");
			String content=request.getParameter("content");
			System.out.println("writer : "+writer);
			System.out.println("content : "+content);
			dto.setBoard_num(board_num);
			dto.setWriter(writer);
			dto.setContent(content);
			dao.commentAdd(dto);
		}else if(url.indexOf("search.do")!=-1) {
			String search_option=request.getParameter("search_option");
			String keyword=request.getParameter("keyword");
			System.out.println("search_option:"+search_option);
			System.out.println("keyword:"+keyword);
			
			List<Board4DTO> list=dao.searchList(search_option, keyword);
			request.setAttribute("list", list);
			request.setAttribute("search_option", search_option);
			request.setAttribute("keyword", keyword);
			String page="/board4/search.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("reply.do")!=-1) {
			int num=Integer.parseInt(request.getParameter("num"));
			String subject=request.getParameter("subject");
			
			Board4DTO dto = dao.view(num);
			dto.setContent("===게시물의 내용===\n"+dto.getContent());
			request.setAttribute("dto", dto);
			request.setAttribute("subject", subject);
			String page="/board4/reply.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if(url.indexOf("insertReply.do")!=-1) {
			int num=Integer.parseInt(request.getParameter("num"));
			Board4DTO dto=dao.view(num);
			int ref=dto.getRef();//답변 그룹 번호
			int re_step=dto.getRe_step()+1;//출력순번
			int re_level=dto.getRe_level()+1;//답변 단계
			String writer=request.getParameter("writer");
			String subject=request.getParameter("subject");
			String content=request.getParameter("content");
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setRef(ref);
			dto.setRe_level(re_level);
			dto.setRe_step(re_step);
			//답글 순서 조정
			dao.updateStep(ref, re_step);
			//답글 쓰기
			dao.reply(dto);
			//목록으로 이동
			String page="/board4_servlet/list.do";
			response.sendRedirect(context+page);
		}	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

package board0.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import board0.dto.Board0CommentDTO;
import board0.dto.Board0DTO;
import sqlmap.MybatisManager;

public class Board0DAO {

	public List<Board0DTO> list(int start, int end) {
		System.out.println("BoardDAO0 list() 실행");
		List<Board0DTO> list=null;
		SqlSession session=null;
		//혹시 있을지 모를 예외발생을 처리하기 위해 try~catch문처리
		try {
			session=MybatisManager.getInstance().openSession();
			Map<String,Object> map=new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			list=session.selectList("board0.list",map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return list;
	}

	public void plusReadCount(int num, HttpSession count_session) {
		System.out.println("BoardDAO0 plusReadCount() 실행");
		SqlSession session=null;
		
		try {
			long read_time=0;
			if(count_session.getAttribute("read_time"+num)!=null) {
				read_time=(long)count_session.getAttribute("read_time"+num);
			}
			long current_time=System.currentTimeMillis();
			
			session=MybatisManager.getInstance().openSession();
			if(current_time-read_time>5*1000) {
				session.update("board0.plusReadCount",num);
				session.commit();
				
				count_session.setAttribute("read_time"+num, current_time);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
	}

	public Board0DTO viewReplace(int num) {
		System.out.println("Board0DTO viewReplace() 실행");
		Board0DTO dto=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			dto=session.selectOne("board0.view",num);
//			줄바꿈 처리 코드 추가
			String content=dto.getContent();
//			content=content.replace("\n", "<br>");
			dto.setContent(content);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return dto;		
	}

	public void insert(Board0DTO dto) {
		System.out.println("BoardDAO0 insert() 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.update("board0.insert",dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
	}
	public void update(Board0DTO dto) {
		System.out.println("BoardDAO0 update() 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.update("board0.update",dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
	}

	public void delete(int num) {
		System.out.println("BoardDAO0 delete() 실행");
		delete_comment(num);
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.delete("board0.delete",num);
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
		
		
	}
	
	public void delete_comment(int num) {
		System.out.println("BoardDAO0 delete_comment() 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.delete("board0.delete_comment", num);
			session.commit();
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
		
	}
	public void up(int num) {
		System.out.println("BoardDAO0 up() 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.update("board0.up",num);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
	}

	public List<Board0CommentDTO> commentList(int num) {
		System.out.println("BoardDAO0 commentList() 실행");
		List<Board0CommentDTO> list=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			list = session.selectList("board0.commentList", num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return list;
	}

	public void commentAdd(Board0CommentDTO dto) {
		System.out.println("BoardDAO0 commentAdd() 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.insert("board0.comment", dto);
			session.commit();//auto commit 아님
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	}

	public int count() {
		System.out.println("BoardDAO0 count() 실행");
		int result=0;
		try (SqlSession session=MybatisManager.getInstance().openSession()){
			result=session.selectOne("board0.count");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public List<Board0DTO> searchList(String search_option, String keyword) {
		System.out.println("BoardDAO0 searchList() 실행");
		System.out.println("search_option : "+search_option);
		System.out.println("keyword : "+keyword);
		List<Board0DTO> list=null;
//		try ~ with문 : java1.7부터 사용 가능
//		try(){}문장에서 finally절을 안써도 자동으로 리소스가 정리된다.
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			Map<String,String> map=new HashMap<String, String>();
			map.put("search_option", search_option);
			map.put("keyword", "%"+keyword+"%");
			list=session.selectList("board0.searchList",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public Board0DTO view(int num) {
		System.out.println("BoardDAO0 view() 실행");
		Board0DTO dto=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			dto=session.selectOne("board0.view",num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return dto;
	}

	public void updateStep(int ref, int re_step) {
		System.out.println("BoardDAO0 updateStep() 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			Board0DTO dto=new Board0DTO();
			dto.setRef(ref);
			dto.setRe_step(re_step);
			session.update("board0.updateStep", dto);
			session.commit();//auto commit 아님
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		
	}

	public void reply(Board0DTO dto) {
		System.out.println("BoardDAO0 reply() 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.insert("board0.reply", dto);
			session.commit();//auto commit 아님
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	}
}

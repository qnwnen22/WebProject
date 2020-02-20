package board1.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import board1.dto.Board1CommentDTO;
import board1.dto.Board1DTO;
import sqlmap.MybatisManager;

public class Board1DAO {

	public List<Board1DTO> list(int start, int end) {
		System.out.println("Board1DAO list() 실행");
		List<Board1DTO> list=null;
		SqlSession session=null;
		//혹시 있을지 모를 예외발생을 처리하기 위해 try~catch문처리
		try {
			session=MybatisManager.getInstance().openSession();
			Map<String,Object> map=new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			list=session.selectList("board1.list",map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return list;
	}

	public void plusReadCount(int num, HttpSession count_session) {
		System.out.println("Board1DAO plusReadCount() 실행");
		SqlSession session=null;
		
		try {
			long read_time=0;
			if(count_session.getAttribute("read_time"+num)!=null) {
				read_time=(long)count_session.getAttribute("read_time"+num);
			}
			long current_time=System.currentTimeMillis();
			
			session=MybatisManager.getInstance().openSession();
			if(current_time-read_time>5*1000) {
				session.update("board1.plusReadCount",num);
				session.commit();
				
				count_session.setAttribute("read_time"+num, current_time);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
	}

	public Board1DTO viewReplace(int num) {
		System.out.println("Board1DTO viewReplace() 실행");
		Board1DTO dto=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			dto=session.selectOne("board1.view",num);
//			줄바꿈 처리 코드 추가
			String content=dto.getContent();
			content=content.replace("\r", "<br>");
			dto.setContent(content);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return dto;		
	}

	public void insert(Board1DTO dto) {
		System.out.println("Board1DAO insert() 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.update("board1.insert",dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
	}
	public void update(Board1DTO dto) {
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.update("board1.update",dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
	}

	public void delete(int num) {
		System.out.println("Board1DAO delete() 실행");
		delete_comment(num);
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.delete("board1.delete",num);
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
		
		
	}
	
	public void delete_comment(int num) {
		System.out.println("Board1DAO delete_comment() 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.delete("board1.delete_comment", num);
			session.commit();
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
		
	}
	public void up(int num) {
		System.out.println("Board1DAO up() 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.update("board1.up",num);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
	}

	public List<Board1CommentDTO> commentList(int num) {
		System.out.println("Board1DAO commentList(num) 실행");
		List<Board1CommentDTO> list=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			list = session.selectList("board1.commentList", num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return list;
	}

	public void commentAdd(Board1CommentDTO dto) {
		System.out.println("Board1DAO commentAdd(dto) 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.insert("board1.comment", dto);
			session.commit();//auto commit 아님
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	}

	public int count() {
		System.out.println("Board1DAO count() 실행");
		int result=0;
		try (SqlSession session=MybatisManager.getInstance().openSession()){
			result=session.selectOne("board1.count");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public List<Board1DTO> searchList(String search_option, String keyword) {
		System.out.println("Board1DAO searchList() 실행");
		System.out.println("search_option : "+search_option);
		System.out.println("keyword : "+keyword);
		List<Board1DTO> list=null;
//		try ~ with문 : java1.7부터 사용 가능
//		try(){}문장에서 finally절을 안써도 자동으로 리소스가 정리된다.
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			Map<String,String> map=new HashMap<String, String>();
			map.put("search_option", search_option);
			map.put("keyword", "%"+keyword+"%");
			list=session.selectList("board1.searchList",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public Board1DTO view(int num) {
		System.out.println("Board1DAO view(num) 실행");
		Board1DTO dto=null;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			dto=session.selectOne("board1.view",num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return dto;
	}

	public void updateStep(int ref, int re_step) {
		System.out.println("Board1DAO updateStep(ref, re_step) 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			Board1DTO dto=new Board1DTO();
			dto.setRef(ref);
			dto.setRe_step(re_step);
			session.update("board1.updateStep", dto);
			session.commit();//auto commit 아님
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		
	}

	public void reply(Board1DTO dto) {
		System.out.println("Board1DAO reply(dto) 실행");
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			session.insert("board1.reply", dto);
			session.commit();//auto commit 아님
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		
		
	}
	public int replyCount(int num) {
		System.out.println("Board1DAO replyCount(num) 실행");
		int count=0;
		SqlSession session=null;
		try {
			session=MybatisManager.getInstance().openSession();
			count=session.selectOne("board1.replyCount",num);
			System.out.println("count:"+count);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
		return count;
	}
	
}

package service.dao;

import java.util.HashMap;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import service.dto.ServiceDTO;
import sqlmap.MybatisManager;

public class ServiceDAO {

	//게시물의 총 갯수
	public int count() {
		int result = 0;
		SqlSession session = MybatisManager.getInstance().openSession();
		try {
			result = session.selectOne("service.count");
			System.out.println("result : " + result);
		} catch (Exception e) {
			System.out.println("게시물 갯수 파악 중 오류 밟생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return result;
	}

	//해당 페이지의 게시물 조회
	public List<ServiceDTO> list(int start, int end) {
		List<ServiceDTO> list = null;
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			Map<String, Object> map = new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			list = session.selectList("service.list", map);
		} catch (Exception e) {
			System.out.println("해당 페이지의 게시물 조회 중 오류 발생");
			e.printStackTrace();
		}
		
		return list;
	}

	//게시물 저장
	public void save(ServiceDTO dto) {
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			session.insert("service.save", dto);
			session.commit();
		} catch (Exception e) {
			System.out.println("게시물 저장 중 오류 발생");
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	}

	//num에 대한 게시물 하나를 조회
	public ServiceDTO view(int num) {
		ServiceDTO dto = new ServiceDTO();
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			dto = session.selectOne("service.view", num);
		} catch (Exception e) {
			System.out.println("게시물 하나 조회 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return dto;
	}

	//게시물을 수정함
	public void update(ServiceDTO dto) {
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			session.update("service.update", dto);
			session.commit();
		} catch (Exception e) {
			System.out.println("게시물 수정 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
	}

	//게시물을 검색함
	public List<ServiceDTO> searchList(String search_option, String keyword) {
		List<ServiceDTO> list = null;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", "%" + keyword + "%");
			list = session.selectList("service.searchList", map);
		} catch (Exception e) {
			System.out.println("게시물 검색 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return list;
	}

	//게시물을 클릭할 때 조회수 증가
	public void plusReadCount(int num, HttpSession count_session) {
		SqlSession session=null;
		
		try {
			session=MybatisManager.getInstance().openSession();
			long read_time=0;
			
			if(count_session.getAttribute("read_time_"+num)!=null) {
				read_time=(long)count_session.getAttribute("read_time_" + num);
			}
			
			long current_time = System.currentTimeMillis();//현재시각
			if (current_time - read_time > 24*60*60*1000) {
				session.update("service.plusReadCount", num);
				session.commit();
				
				count_session.setAttribute("read_time_" + num, current_time);
			}
		} catch (Exception e) {
			System.out.println("조회수 증가 처리 중 오류 발생");
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	}

	//파일 이름을 가져옴
	public String getFileName(int num) {
		String result = "";
		
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			result = session.selectOne("service.getFileName", num);
		} catch (Exception e) {
			System.out.println("파일 이름 가져오기 중 오류 발생");
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return result;
	}

	//패스워드를 확인함
	public String passwordCheck(int num, String passwd) {
		String result = null;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String,Object> map=new HashMap<>();
			map.put("num", num);
			map.put("passwd", passwd);
			result=session.selectOne("service.passwordCheck", map);
		} catch (Exception e) {
			System.out.println("패스워드 확인 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return result;
	}

	//해당 게시물의 ref번호를 확인함
	public int refSearch(int num) {
		int result = 0;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			result = session.selectOne("service.refSearch", num);
		} catch (Exception e) {
			System.out.println("ref 번호 확인 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		System.out.println("ref 추출 result 결과값 : " + result);
		return result;
	}

	//해당 게시물을 삭제처리함
	public void delete(int num) {
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			session.update("service.delete", num);
			session.commit();
		} catch (Exception e) {
			System.out.println("게시물 삭제 처리 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
	}

	//답글을 등록함
	public void reple(ServiceDTO dto) {
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			session.insert("service.reple", dto);
			session.commit();
		} catch (Exception e) {
			System.out.println("게시물 저장 중 오류 발생");
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
	}

	//해당 게시물의 답글이 있는지 확인함
	public String reNumSelect(int ref) {
		String result = null;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			result = session.selectOne("service.reNumSelect", ref);
		} catch (Exception e) {
			System.out.println("답글 여부 확인 중 오류 발생");
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		
		return result;
	}

	//해당 게시글과 게시물에 포함된 답글의 갯수를 확인함
	public int refCount(int ref) {
		int result = 0;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			result = session.selectOne("service.refCount", ref);
		} catch (Exception e) {
			System.out.println("특정 게시물에 딸린 총 게시물의 수 조회 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		System.out.println("총 게시물 : " + result);
		
		return result;
	}

	//답글의 고유번호를 가져옴
	public int repleNum(int ref, int refCount) {
		int result = 0;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("ref", ref);
			map.put("re_num", refCount);
			result = session.selectOne("service.repleNum", map);
		} catch (Exception e) {
			System.out.println("답글 번호 출력 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		System.out.println("답글의 번호 : " + result);
		
		return result;
	}
}

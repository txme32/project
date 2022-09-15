package apply.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import apply.dto.ApplyDTO;
import sqlmap.MybatisManager;

public class ApplyDAO {

	//신청 자료를 저장
	public void apply(ApplyDTO dto) {
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			session.insert("studentapply.apply", dto);
			session.commit();
		} catch (Exception e) {
			System.out.println("신청 자료 저장 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
	}

	//전화번호가 중복이라면 true, 중복이 아니라면 false 반환
	public boolean applyCheck(int studentTel) {
		SqlSession session = null;
		boolean result = false;
		
		try {
			session = MybatisManager.getInstance().openSession();
			String checkTel = session.selectOne("studentapply.applycheck", studentTel);
			System.out.println("중복 확인된 이름 : " + checkTel);
			
			if (checkTel != null) {
				result = true;
			}
			
			System.out.println("결과 : " + result);
		} catch (Exception e) {
			System.out.println("전화번호 중복 체크 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return result;
	}

	//신청자료 수 계산
	public int count() {
		int result = 0;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			result = session.selectOne("studentapply.count");
		} catch (Exception e) {
			System.out.println("신청자료 수 계산 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return result;
	}

	//페이지에 해당되는 게시물 출력
	public List<ApplyDTO> list(int start, int end) {
		List<ApplyDTO> list = null;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			list = session.selectList("studentapply.list", map);
		} catch (Exception e) {
			System.out.println("페이지에 해당되는 게시물 출력 중 예외 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}

		return list;
	}
	
}

package memberlist.dao;

import org.apache.ibatis.session.SqlSession;

import memberlist.dto.MemberlistDTO;
import sqlmap.MybatisManager;

public class MemberlistDAO {

	//등록된 계정인지 확인
	public String loginCheck(MemberlistDTO dto) {
		String result = null;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			result = session.selectOne("memberlist.loginCheck", dto);
		} catch (Exception e) {
			System.out.println("등록된 계정 확인 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return result;
	}

	//중복된 아이디인지 확인
	public String idCheck(String userid) {
		String result = null;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			result = session.selectOne("memberlist.idCheck", userid);
		} catch (Exception e) {
			System.out.println("아이디 중복 확인 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return result;
	}

	//아이디가 관리자 계정인지 확인
	public String adminCheck(String userid) {
		String result = null;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			result = session.selectOne("memberlist.adminCheck", userid);
		} catch (Exception e) {
			System.out.println("관리자 계정 확인 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return result;
	}

	//계정을 등록함
	public void join(MemberlistDTO dto) {
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			session.insert("memberlist.join", dto);
			session.commit();
		} catch (Exception e) {
			System.out.println("계정 등록 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
	}

	//유저의 정보를 조회
	public MemberlistDTO userInfo(String userid) {
		MemberlistDTO dto = null;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			dto = session.selectOne("memberlist.userInfo", userid);
		} catch (Exception e) {
			System.out.println("유저 정보 조회 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return dto;
	}

	//유저의 정보를 수정
	public void userEdit(MemberlistDTO dto) {
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			session.update("memberlist.userEdit", dto);
			session.commit();
		} catch (Exception e) {
			System.out.println("유저 정보 수정 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
	}

	//탈퇴한 계정인지 확인
	public String delCheck(String userid) {
		String result = null;
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			result = session.selectOne("memberlist.delCheck", userid);
		} catch (Exception e) {
			System.out.println("계정 탈퇴여부 확인 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return result;
	}

	//계정을 탈퇴처리함
	public void userDel(String userid) {
		SqlSession session = null;
		
		try {
			session = MybatisManager.getInstance().openSession();
			session.update("memberlist.userDel", userid);
			session.commit();
		} catch (Exception e) {
			System.out.println("계정 탈퇴 처리 중 오류 발생");
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
	}
	
}

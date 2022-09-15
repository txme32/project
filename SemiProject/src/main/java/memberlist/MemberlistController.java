package memberlist;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;

import memberlist.dao.MemberlistDAO;
import memberlist.dto.MemberlistDTO;
import util.AlertFn;

@WebServlet("/memberlist_servlet/*")
public class MemberlistController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();//주소 가져옴.
		String contextPath = request.getContextPath();//contextPath 가져옴.
		MemberlistDAO dao = new MemberlistDAO();
		
		if (uri.indexOf("login.do") != -1) {
			String userid = request.getParameter("userid");
			String passwd = request.getParameter("passwd");
			
			System.out.println("아이디 : " + userid);
			System.out.println("패스워드 : " + passwd);
			
			MemberlistDTO dto = new MemberlistDTO();
			dto.setUserid(userid);
			dto.setPasswd(passwd);
			
			String result = dao.loginCheck(dto);
			System.out.println(result);
			
			if(result != null) {//등록된 계정
				String delCheck = dao.delCheck(userid);
				System.out.println("delCheck : " + delCheck);
				
				if (delCheck.equals("Y")) {//탈퇴처리된 계정이라면
					AlertFn.alertBack(response, "삭제된 계정입니다.");
				} else { //로그인 성공
					HttpSession session = request.getSession();
					session.setAttribute("loginId", userid);
					
					String adminuser = dao.adminCheck(userid);
					session.setAttribute("loginAdmin", adminuser);
					
					String page = "/general/index.jsp";
					response.sendRedirect(request.getContextPath() + page);
				}
			} else {//로그인 실패
				AlertFn.alertBack(response, "아이디 또는 비밀번호가 일치하지 않습니다.");
			}
		} else if (uri.indexOf("join.do") != -1) {
			String userid = request.getParameter("userid");
			String passwd = request.getParameter("passwd");
			String email = request.getParameter("email");
			
			String idCheck = dao.idCheck(userid);
			
			if (idCheck != null) {//등록된 계정이 있음
				AlertFn.alertBack(response, "이미 등록된 아이디입니다.");
			} else {
				MemberlistDTO dto = new MemberlistDTO();
				dto.setUserid(userid);
				dto.setPasswd(passwd);
				dto.setEmail(email);
				
				dao.join(dto);
				
				AlertFn.alertLocation(response, "가입되었습니다.", request.getContextPath() + "/log/login.jsp");
			}
		} else if (uri.indexOf("logout.do") != -1) {
			HttpSession session = request.getSession();
			
			session.invalidate();
			
			AlertFn.alertLocation(response, "로그아웃되었습니다.", request.getContextPath() + "/general/index.jsp");
		} else if (uri.indexOf("userInfo.do") != -1) {
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("loginId");
			
			if (userid == null) {//세션이 만료되었다면
				AlertFn.alertLocation(response, "세션이 만료되었습니다.", request.getContextPath() + "/log/login.jsp");
			} else {
				System.out.println("userid : " + userid);
				MemberlistDTO dto = new MemberlistDTO();
				dto = dao.userInfo(userid);
				
				request.setAttribute("dto", dto);
				String page = "/log/userInfo.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
		} else if (uri.indexOf("edit.do") != -1) {
			String userid = request.getParameter("userid");
			
			MemberlistDTO dto = new MemberlistDTO();
			
			dto = dao.userInfo(userid);
			
			request.setAttribute("dto", dto);
			String page = "/log/userEdit.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if (uri.indexOf("userEdit.do") != -1) {
			String userid = request.getParameter("userid");
			String passwd = request.getParameter("passwd");
			String email = request.getParameter("email");
			System.out.println("userid : " + userid + ", passwd : " + passwd + ", email : " + email);
			
			MemberlistDTO dto = new MemberlistDTO();
			dto.setUserid(userid);
			dto.setPasswd(passwd);
			dto.setEmail(email);
			
			dao.userEdit(dto);
			
			AlertFn.alertLocation(response, "회원정보가 수정되었습니다.", request.getContextPath() + "/general/index.jsp");
		} else if (uri.indexOf("delete.do") != -1) {
			String userid = request.getParameter("userid");
			
			dao.userDel(userid);
			
			HttpSession session = request.getSession();
			session.invalidate();
			
			AlertFn.alertLocation(response, "정상적으로 탈퇴처리되었습니다.", request.getContextPath() + "/general/index.jsp");
		} else if (uri.indexOf("home.do") != -1) {
			AlertFn.alertLocation(response, "잘못된 접근입니다.", request.getContextPath() + "/general/index.jsp");
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

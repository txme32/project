package apply;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import apply.dao.ApplyDAO;
import apply.dto.ApplyDTO;
import client.ClientIP;
import page.Pager;
import util.AlertFn;

@WebServlet("/apply_servlet/*")
public class applyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURL().toString();//주소 가져옴
		String contextPath = request.getContextPath();//contextPath 가져옴
		ApplyDAO dao = new ApplyDAO();
		
		if(url.indexOf("apply.do") != -1) { //신청을 시도할 때
			String student_name = request.getParameter("studentName");
			int student_grade = Integer.parseInt(request.getParameter("studentGrade"));
			int student_tel = Integer.parseInt(request.getParameter("studentTel"));
			String student_level = request.getParameter("studentLevel");
			ClientIP clientIP = new ClientIP();
			String ip = clientIP.clientRemoteAddr(request);
			
			ApplyDTO dto = new ApplyDTO();
			
			System.out.println(student_name);
			System.out.println(student_grade);
			System.out.println(student_tel);
			System.out.println(student_level);
			System.out.println(ip);
			
			dto.setStudent_name(student_name);
			dto.setStudent_grade(student_grade);
			dto.setStudent_tel(student_tel);
			dto.setStudent_level(student_level);
			dto.setIp(ip);
			
			boolean check = dao.applyCheck(student_tel);//중복신청을 방지
			if (check) {
				AlertFn.alertLocation(response, "이미 신청하셨습니다.", contextPath + "/general/index.jsp");
			} else {
				dao.apply(dto);
				AlertFn.alertLocation(response, "신청이 완료되었습니다.", contextPath + "/general/index.jsp");
			}
		} else if (url.indexOf("list.do") != -1) { //신청명단을 확인할 때
			int count = dao.count();
			int curPage = 1;
			int pageScale = Integer.parseInt(request.getParameter("pageScale"));
			
			System.out.println("list.do 실행" + count + ", " + curPage + ", " + pageScale);
			
			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			
			Pager pager = new Pager(count, curPage, pageScale);
			int start = pager.getPageBegin();
			int end = pager.getPageEnd();
			
			System.out.println("list.do 실행" + start + ", " + end);
			
			List<ApplyDTO> list = dao.list(start, end);
			
			request.setAttribute("list", list);
			request.setAttribute("pager", pager);
			
			String page = "/admin/list.jsp?pageScale=" + pageScale;
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

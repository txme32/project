package service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.net.InetAddress;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import page.Pager;
import service.dao.ServiceDAO;
import service.dto.ServiceDTO;
import smtp.NaverSMTP;
import util.AlertFn;
import util.Constants;

@WebServlet("/service_servlet/*")
public class ServiceController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();//주소 가져옴.
		String contextPath = request.getContextPath();//contextPath 가져옴.
		ServiceDAO dao = new ServiceDAO();
		String dir = "c:\\upload\\";
		
		if (uri.indexOf("list.do") != -1) {
			int count = dao.count();
			System.out.println("count : " + count);
			int curPage = 1;
			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			Pager pager = new Pager(count, curPage, 10);
			int start = pager.getPageBegin();
			int end = pager.getPageEnd();
			
			List<ServiceDTO> list = dao.list(start, end);
			request.setAttribute("list", list);
			request.setAttribute("pager", pager);
			
			String page = "/general/service.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if (uri.indexOf("save.do") != -1) {
			System.out.println("게시물 저장 실행");
			File uploadDir = new File(dir);
			if (!uploadDir.exists()) {//경로가 존재하지 않는다면 만듦
				uploadDir.mkdir();
			}
			
			MultipartRequest mr = new MultipartRequest(request, dir, Constants.MAX_UPLOAD, "UTF-8", new DefaultFileRenamePolicy());
			
			String writer = mr.getParameter("writer");
			String email = mr.getParameter("email");
			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			String passwd = mr.getParameter("passwd");
			String ip = request.getRemoteAddr();
			if(ip.equalsIgnoreCase("0:0:0:0:0:0:0:1")) {
				InetAddress inetAddress=InetAddress.getLocalHost();
				ip=inetAddress.getHostAddress();
			}
			String filename = " ";
			int filesize = 0;
			
			try {
				Enumeration files = mr.getFileNames();
				while (files.hasMoreElements()) {
					String file = (String)files.nextElement();
					filename = mr.getFilesystemName(file);
					File f1 = mr.getFile(file);
					if (f1 != null) {
						filesize = (int)f1.length();
					}
				}
			} catch (Exception e) {
				System.out.println("파일 정보 저장 중 오류 발생");
				e.printStackTrace();
			}
			
			ServiceDTO dto = new ServiceDTO();
			dto.setWriter(writer);
			dto.setTitle(title);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setEmail(email);
			dto.setIp(ip);
			if(filename == null || filename.trim().equals("")) {
				filename="-";
			}
			dto.setFilename(filename);
			dto.setFilesize(filesize);
			
			dao.save(dto);
			
			String page = "/service_servlet/list.do";
			response.sendRedirect(contextPath + page);
		} else if (uri.indexOf("update.do") != -1) {
			System.out.println("게시물 업데이트 실행");
			File uploadDir = new File(dir);
			if (!uploadDir.exists()) {//경로가 존재하지 않는다면 만듦
				uploadDir.mkdir();
			}
			
			MultipartRequest mr = new MultipartRequest(request, dir, Constants.MAX_UPLOAD, "UTF-8", new DefaultFileRenamePolicy());
			
			int num = Integer.parseInt(mr.getParameter("num"));
			String writer = mr.getParameter("writer");
			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			String passwd = mr.getParameter("passwd");
			String email = mr.getParameter("email");
			String ip = request.getRemoteAddr();
			if(ip.equalsIgnoreCase("0:0:0:0:0:0:0:1")) {
				InetAddress inetAddress=InetAddress.getLocalHost();
				ip=inetAddress.getHostAddress();
			}
			String filename = " ";
			int filesize = 0;
			
			try {
				Enumeration files = mr.getFileNames();
				while (files.hasMoreElements()) {
					String file = (String)files.nextElement();
					filename = mr.getFilesystemName(file);
					File f1 = mr.getFile(file);
					if (f1 != null) {
						filesize = (int)f1.length();
					}
				}
			} catch (Exception e) {
				System.out.println("파일 정보 저장 중 오류 발생");
				e.printStackTrace();
			}
			
			ServiceDTO dto = new ServiceDTO();
			dto.setNum(num);
			dto.setWriter(writer);
			dto.setTitle(title);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setEmail(email);
			dto.setIp(ip);
			
			//새로운 첨부파일이 없다면
			if(filename == null || filename.trim().equals("")) {
				ServiceDTO dto2 = dao.view(num);
				String filename2 = dto2.getFilename();
				int filesize2 = dto2.getFilesize();
				dto.setFilename(filename2);
				dto.setFilesize(filesize2);
			} else {
				dto.setFilename(filename);
				dto.setFilesize(filesize);
			}
			
			//첨부파일을 삭제했다면 실 경로의 파일도 삭제
			String fileDel = mr.getParameter("fileDel");
			if (fileDel != null && fileDel.equals("on")) {
				File file2 = new File(dir + filename);
				file2.delete();
				dto.setFilename("-");
				dto.setFilesize(0);
			}
			
			dao.update(dto);
			
			String page = "/service_servlet/list.do";
			response.sendRedirect(contextPath + page);
		} else if (uri.indexOf("write.do") != -1) {
			System.out.println("게시글 작성 실행");
			System.out.println("num : " + request.getParameter("num"));
			System.out.println("re_num : " + request.getParameter("re_num"));
			System.out.println("mode : " + request.getParameter("mode"));
			MultipartRequest mr = new MultipartRequest(request, dir, Constants.MAX_UPLOAD, "UTF-8", new DefaultFileRenamePolicy());
			String mode = request.getParameter("mode");
			
			if (mode.equals("new")) {//글을 새로 쓴다면
				request.setAttribute("re_num", 1);
				
				String page = "/general/serviceWrite.jsp?mode=new";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
			if (mode.equals("reple")) {//쓰는 글이 답글이라면
				int num = Integer.parseInt(mr.getParameter("num"));
				int ref = dao.refSearch(num);
				
				request.setAttribute("ref", ref);
				
				String page = "/general/serviceWrite.jsp?mode=reple";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
			if (mode.equals("edit")) {//글을 수정한다면
				int num = Integer.parseInt(mr.getParameter("num"));
				
				ServiceDTO dto = dao.view(num);
				
				request.setAttribute("dto", dto);
				
				String page = "/general/serviceWrite.jsp?mode=edit";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
		} else if (uri.indexOf("search.do") != -1) {
			String search_option = request.getParameter("search_option");
			String keyword = request.getParameter("keyword");
			
			List<ServiceDTO> list = dao.searchList(search_option, keyword);
			
			request.setAttribute("list", list);
			request.setAttribute("search_option", search_option);
			request.setAttribute("keyword", keyword);
			
			String page = "/general/service.jsp";
			
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if (uri.indexOf("view.do") != -1) {
			int num = Integer.parseInt(request.getParameter("num"));
			HttpSession session = request.getSession();
			
			dao.plusReadCount(num, session);
			
			ServiceDTO dto = dao.view(num);
			
			String content = dto.getContent();
			content = content.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
			dto.setContent(content);
			
			request.setAttribute("dto", dto);
			
			int ref = dto.getRef();
			
			String num2 = dao.reNumSelect(ref);
			System.out.println("num2 : " + num2);
			
			if (num2 != null) { //만약 해당 글에 답글이 존재한다면
				ServiceDTO dto2 = dao.view(Integer.parseInt(num2));
				request.setAttribute("dto2", dto2);
				request.setAttribute("returnReple", "yes");
			} else {
				request.setAttribute("returnReple", "no");
			}
			
			String page = "/general/serviceRead.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if (uri.indexOf("download.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			String filename = dao.getFileName(num);
			String path = dir + filename;
			
			System.out.println("첨부파일 이름 : " + filename);
			
			byte b[] = new byte[4096];
			FileInputStream fis = new FileInputStream(path);
			
			String mimeType = getServletContext().getMimeType(path);
			if(mimeType==null) {
				mimeType="application/octet-stream;charset=utf-8";
			}
			
			filename = new String(filename.getBytes("utf-8"),"8859_1");
			response.setHeader("Content-Disposition", "attachment;filename="+filename);
			ServletOutputStream out = response.getOutputStream();
			int numRead;
			
			while (true) {
				numRead = fis.read(b, 0, b.length);
				if(numRead == -1) break;//더 이상 내용이 없으면 빠져나감
				out.write(b, 0, numRead);//데이터 쓰기
			}
			
			out.flush();
			out.close();
			fis.close();
		} else if (uri.indexOf("passwordCheck.do") != -1) {
			int num = Integer.parseInt(request.getParameter("num"));
			String passwd = request.getParameter("passwd");
			
			System.out.println("num : " + num + ", passwd : " + passwd);
			
			String result = dao.passwordCheck(num, passwd);
			
			System.out.println("결과 : " + result);
			
			String sendResult = "성공";
			
			if (result != null) {
				request.setAttribute("result", sendResult);
				request.setAttribute("num", num);
				String page = "/general/passwordCheck.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			} else {
				AlertFn.alertBack(response, "비밀번호가 일치하지 않습니다.");
			}
		} else if (uri.indexOf("popUpPage.do") != -1) {
			int num = Integer.parseInt(request.getParameter("num"));
			
			request.setAttribute("num", num);
			String page = "/general/passwordCheck.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if (uri.indexOf("delete.do") != -1) {
			MultipartRequest mr = new MultipartRequest(request, dir, Constants.MAX_UPLOAD, "UTF-8", new DefaultFileRenamePolicy());
			int num = Integer.parseInt(mr.getParameter("num"));
			
			dao.delete(num);
			
			ServiceDTO dto = new ServiceDTO();
			dto = dao.view(num);
			
			//삭제하고자 하는 글이 답글이 아니고 그 글에 답글이 달려있을 때, 답글도 삭제함
			int ref = dto.getRef();
			int refCount = dao.refCount(ref);
			if (refCount == 2) {
				int num2 = dao.repleNum(ref, refCount);
				dao.delete(num2);
			}
			
			String page = "/service_servlet/list.do";
			response.sendRedirect(contextPath + page);
		} else if (uri.indexOf("reple.do") != -1) {
			File uploadDir = new File(dir);
			if (!uploadDir.exists()) {//경로가 존재하지 않는다면 만듦
				uploadDir.mkdir();
			}
			
			MultipartRequest mr = new MultipartRequest(request, dir, Constants.MAX_UPLOAD, "UTF-8", new DefaultFileRenamePolicy());
			
			int ref = Integer.parseInt(mr.getParameter("ref"));
			int re_num = Integer.parseInt(mr.getParameter("re_num"));
			String writer = mr.getParameter("writer");
			String email = mr.getParameter("email");
			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			String passwd = mr.getParameter("passwd");
			String ip = request.getRemoteAddr();
			if(ip.equalsIgnoreCase("0:0:0:0:0:0:0:1")) {
				InetAddress inetAddress=InetAddress.getLocalHost();
				ip=inetAddress.getHostAddress();
			}
			String filename = " ";
			int filesize = 0;
			
			try {
				Enumeration files = mr.getFileNames();
				while (files.hasMoreElements()) {
					String file = (String)files.nextElement();
					filename = mr.getFilesystemName(file);
					File f1 = mr.getFile(file);
					if (f1 != null) {
						filesize = (int)f1.length();
					}
				}
			} catch (Exception e) {
				System.out.println("파일 정보 저장 중 오류 발생");
				e.printStackTrace();
			}
			
			ServiceDTO dto = new ServiceDTO();
			dto.setRef(ref);
			dto.setRe_num(re_num);
			dto.setWriter(writer);
			dto.setTitle(title);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setEmail(email);
			dto.setIp(ip);
			if(filename == null || filename.trim().equals("")) {
				filename="-";
			}
			dto.setFilename(filename);
			dto.setFilesize(filesize);
			
			dao.reple(dto);
			
			String page = "/service_servlet/list.do";
			response.sendRedirect(contextPath + page);
		} else if (uri.indexOf("passSearch.do") != -1) {
			int num = Integer.parseInt(request.getParameter("num"));
			
			ServiceDTO dto = new ServiceDTO();
			dto = dao.view(num);
			
			Map<String, String> emailInfo = new HashMap<String, String>();
			emailInfo.put("from", "wkdw1wndw132@naver.com");
			emailInfo.put("to", dto.getEmail());
			emailInfo.put("title", dto.getWriter() + "님의 비밀번호입니다.");
			
			String content = "";
			
			try {
				String templatePath = request.getRealPath("/emailForm/rePassForm.html");
				System.out.println("templatePath : " + templatePath);
				BufferedReader br = new BufferedReader(new FileReader(templatePath));
				
				String oneLine;
				while ((oneLine = br.readLine()) != null) {
					content += oneLine + "\n";
				}
				
				br.close();
			} catch (Exception e) {
				System.out.println("이메일폼 html로 변환 중 오류 발생");
				e.printStackTrace();
			}
			
			content = content.replace("WRITERAREA", dto.getWriter());
			content = content.replace("PASSWORDAREA", dto.getPasswd());
			
			System.out.println("content : " + content);
			
			emailInfo.put("content", content);
			emailInfo.put("format", "text/html;charset=UTF-8");
			
			try {
				NaverSMTP smtpServer = new NaverSMTP();
				smtpServer.emailSending(emailInfo);
				System.out.println("이메일 전송 성공");
				
				AlertFn.alertBack(response, "등록한 이메일로 비밀번호가 전송되었습니다.");
			} catch (Exception e) {
				System.out.println("이메일 전송 실패");
				e.printStackTrace();
			}
		}	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

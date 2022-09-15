package util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

public class AlertFn {
	
	//message 알림창을 띄운 후 url로 이동
	public static void alertLocation(String message, String url, JspWriter out) {
		try {
			String script = "<script>"
					+ "	alert('" + message + "');"
					+ "	location.href='" + url + "';"
					+ "</script>";
			
			out.println(script);
		} catch (Exception e) {
			System.out.println("알림창 출력 중 문제 발생1");
			e.printStackTrace();
		}
	}
	
	//message 알림창을 띄운 후 뒤로가기
	public static void alertBack(String message, JspWriter out) {
		try {
			String script = "<script>"
					+ " alert('" + message + "');"
					+ "	history.back();"
					+ "</script>";
			
			out.println(script);
		} catch (Exception e) {
			System.out.println("알림창 출력 중 문제 발생2");
			e.printStackTrace();
		}
	}
	
	//servlet에서 message 알림창을 띄운 후 url로 이동
	public static void alertLocation(HttpServletResponse response, String message, String url) {
		try {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = response.getWriter();
			String script = "<script>"
					+ "	alert('" + message + "');"
					+ "	location.href='" + url + "';"
					+ "</script>";
			
			writer.print(script);
		} catch (Exception e) {
			System.out.println("알림창 출력 중 문제 발생3");
			e.printStackTrace();
		}
	}
	
	//servlet에서 message 알림창을 띄운 후 뒤로가기
	public static void alertBack(HttpServletResponse response, String message) {
		try {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = response.getWriter();
			
			String script = "<script>"
					+ " alert('" + message + "');"
					+ "	history.back();"
					+ "</script>";
			
			writer.print(script);
		} catch (Exception e) {
			System.out.println("알림창 출력 중 문제 발생4");
			e.printStackTrace();
		}
	}
}

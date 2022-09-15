package config;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;

//필터 : 요청에 앞서 처리되는 코드 정의
//url pattern : /* 모든 요청
@WebFilter("/*")
public class EncodingFilter extends HttpFilter implements Filter {
	private String charset="utf-8";

	//필터 제거(서버가 멈출때)
	public void destroy() {
		System.out.println("필터가 제거되었습니다.");
	}

	//요청이 들어올때 거쳐가는 코드
	public void doFilter(ServletRequest request, ServletResponse response, 
			FilterChain chain) throws IOException, ServletException {
		System.out.println("필터가 실행되었습니다.");
		request.setCharacterEncoding(charset);
		chain.doFilter(request, response);//여기서 필터가 처리됨
	}

	//필터 초기화(서버가 시작될 때 실행됨)
	public void init(FilterConfig fConfig) throws ServletException {
		System.out.println("필터가 초기화되었습니다.");
	}
}

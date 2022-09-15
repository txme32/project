package apply.dto;

import java.util.Date;

public class ApplyDTO {
	private int num;
	private String student_name;
	private int student_grade;
	private int student_tel;
	private String student_level;
	private Date reg_date;
	private String ip;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getStudent_name() {
		return student_name;
	}
	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}
	public int getStudent_grade() {
		return student_grade;
	}
	public void setStudent_grade(int student_grade) {
		this.student_grade = student_grade;
	}
	public int getStudent_tel() {
		return student_tel;
	}
	public void setStudent_tel(int student_tel) {
		this.student_tel = student_tel;
	}
	public String getStudent_level() {
		return student_level;
	}
	public void setStudent_level(String student_level) {
		this.student_level = student_level;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
}

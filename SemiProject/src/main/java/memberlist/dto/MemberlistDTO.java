package memberlist.dto;

import java.util.Date;

public class MemberlistDTO {
	private String userid;
	private String passwd;
	private String email;
	private char adminuser;
	private Date join_date;
	private char del;
	
	public char getDel() {
		return del;
	}
	public void setDel(char del) {
		this.del = del;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public char getAdminuser() {
		return adminuser;
	}
	public void setAdminuser(char adminuser) {
		this.adminuser = adminuser;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
}

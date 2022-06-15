package place;

import java.sql.*;

public class GradeDataBean {
	private int gId;
	private String uId;
	private int pId;
	private int pGrade;
	private String gSubject;
	private String gContent;
	private Timestamp reg_date;
	
	
	public int getgId() {
		return gId;
	}
	public void setgId(int gId) {
		this.gId = gId;
	}
	public String getuId() {
		return uId;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public int getpGrade() {
		return pGrade;
	}
	public void setpGrade(int pGrade) {
		this.pGrade = pGrade;
	}
	public String getgSubject() {
		return gSubject;
	}
	public void setgSubject(String gSubject) {
		this.gSubject = gSubject;
	}
	public String getgContent() {
		return gContent;
	}
	public void setgContent(String gContent) {
		this.gContent = gContent;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
}

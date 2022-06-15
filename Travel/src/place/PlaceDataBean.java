package place;

import java.sql.*;

public class PlaceDataBean {
	private int pId;
	private String PLACE_NM;
	private String GUGUN_NM;
	private int TRRSRT_LA;
	private int TRRSRT_LO;
	private String TRRSRT_ROAD_NM_ADDR;
	private String TEL_NO;
	private String GRP_NM;
	private String SEASON_NM;
	private String IEM_NM;
	private String CL_NM;
	private String ETC_CN;
	private String img;
	private Timestamp create_time;
	
	
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getPLACE_NM() {
		return PLACE_NM;
	}
	public void setPLACE_NM(String pLACE_NM) {
		PLACE_NM = pLACE_NM;
	}
	public String getGUGUN_NM() {
		return GUGUN_NM;
	}
	public void setGUGUN_NM(String gUGUN_NM) {
		GUGUN_NM = gUGUN_NM;
	}
	public int getTRRSRT_LA() {
		return TRRSRT_LA;
	}
	public void setTRRSRT_LA(int tRRSRT_LA) {
		TRRSRT_LA = tRRSRT_LA;
	}
	public int getTRRSRT_LO() {
		return TRRSRT_LO;
	}
	public void setTRRSRT_LO(int tRRSRT_LO) {
		TRRSRT_LO = tRRSRT_LO;
	}
	public String getTRRSRT_ROAD_NM_ADDR() {
		return TRRSRT_ROAD_NM_ADDR;
	}
	public void setTRRSRT_ROAD_NM_ADDR(String tRRSRT_ROAD_NM_ADDR) {
		TRRSRT_ROAD_NM_ADDR = tRRSRT_ROAD_NM_ADDR;
	}
	public String getTEL_NO() {
		return TEL_NO;
	}
	public void setTEL_NO(String tEL_NO) {
		TEL_NO = tEL_NO;
	}
	public String getGRP_NM() {
		return GRP_NM;
	}
	public void setGRP_NM(String gRP_NM) {
		GRP_NM = gRP_NM;
	}
	public String getSEASON_NM() {
		return SEASON_NM;
	}
	public void setSEASON_NM(String sEASON_NM) {
		SEASON_NM = sEASON_NM;
	}
	public String getIEM_NM() {
		return IEM_NM;
	}
	public void setIEM_NM(String iEM_NM) {
		IEM_NM = iEM_NM;
	}
	public String getCL_NM() {
		return CL_NM;
	}
	public void setCL_NM(String cL_NM) {
		CL_NM = cL_NM;
	}
	public String getETC_CN() {
		return ETC_CN;
	}
	public void setETC_CN(String eTC_CN) {
		ETC_CN = eTC_CN;
	}
	public Timestamp getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Timestamp create_time) {
		this.create_time = create_time;
	}
	
	
}
package transport;

import java.sql.*;

public class PlaceDataBean {
	private int pId;
	private String PLACE_NM;
	private String TRRSRT_ROAD_NM_ADDR;
	private String CRSLK_ADDR;
	private String CRSLK_ROAD_NM;
	private String CHILD_PRTC_ZONE_AT;
	private float CRSLK_LA;
	private float CRSLK_LO;

	
	
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}

	public String getPLACE_NM() {
		return PLACE_NM;
	}
	public void setPLACE_NM(String pLACE_NM) {
		PLACE_NM = pLACE_NM;
	}
	public String getTRRSRT_ROAD_NM_ADDR() {
		return TRRSRT_ROAD_NM_ADDR;
	}
	public void setTRRSRT_ROAD_NM_ADDR(String tRRSRT_ROAD_NM_ADDR) {
		TRRSRT_ROAD_NM_ADDR = tRRSRT_ROAD_NM_ADDR;
	}
	public String getCRSLK_ADDR() {
		return CRSLK_ADDR;
	}
	public void setCRSLK_ADDR(String cRSLK_ADDR) {
		CRSLK_ADDR = cRSLK_ADDR;
	}
	public int getCRSLK_ROAD_NM() {
		return CRSLK_ROAD_NM;
	}
	public void setCRSLK_ROAD_NM(String cRSLK_ROAD_NM) {
		CRSLK_ROAD_NM = cRSLK_ROAD_NM;
	}
	public String getCHILD_PRTC_ZONE_AT() {
		return CHILD_PRTC_ZONE_AT;
	}
	public void setCHILD_PRTC_ZONE_AT(String cHILD_PRTC_ZONE_AT) {
		CHILD_PRTC_ZONE_AT = cHILD_PRTC_ZONE_AT;
	}
	public String getCRSLK_LA() {
		return CRSLK_LA;
	}
	public void setCRSLK_LA(float cRSLK_LA) {
		CRSLK_LA = cRSLK_LA;
	}
	public String getCRSLK_LO() {
		return CRSLK_LO;
	}
	public void setCRSLK_LO(float cRSLK_LO) {
		CRSLK_LO = cRSLK_LO;
	}
}

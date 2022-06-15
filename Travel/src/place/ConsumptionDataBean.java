package place;

public class ConsumptionDataBean {
	private int cId;
	private String PLC_NM;
	private String CTRP_NM;
	private long CARD_USE_AMT;
	private long CARD_UTILIIZA_CAS_CO;
	private long sumValue;
	private String BASE_QUARTER;
	
	
	public long getSumValue() {
		return sumValue;
	}
	public void setSumValue(long sumValue) {
		this.sumValue = sumValue;
	}
	public int getcId() {
		return cId;
	}
	public void setcId(int cId) {
		this.cId = cId;
	}
	public String getPLC_NM() {
		return PLC_NM;
	}
	public void setPLC_NM(String pLC_NM) {
		PLC_NM = pLC_NM;
	}
	public String getCTRP_NM() {
		return CTRP_NM;
	}
	public void setCTRP_NM(String cTRP_NM) {
		CTRP_NM = cTRP_NM;
	}
	public long getCARD_USE_AMT() {
		return CARD_USE_AMT;
	}
	public void setCARD_USE_AMT(long cARD_USE_AMT) {
		CARD_USE_AMT = cARD_USE_AMT;
	}
	public long getCARD_UTILIIZA_CAS_CO() {
		return CARD_UTILIIZA_CAS_CO;
	}
	public void setCARD_UTILIIZA_CAS_CO(long cARD_UTILIIZA_CAS_CO) {
		CARD_UTILIIZA_CAS_CO = cARD_UTILIIZA_CAS_CO;
	}
	public String getBASE_QUARTER() {
		return BASE_QUARTER;
	}
	public void setBASE_QUARTER(String bASE_QUARTER) {
		BASE_QUARTER = bASE_QUARTER;
	}
	
	
}

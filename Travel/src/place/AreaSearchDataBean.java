package place;

import java.sql.Timestamp;

public class AreaSearchDataBean {
	private int asId;
	private int sId;
	private String hashTag;
	private String area;
	private int countTag;
	private Timestamp search_time;
	public int getAsId() {
		return asId;
	}
	public void setAsId(int asId) {
		this.asId = asId;
	}
	public int getsId() {
		return sId;
	}
	public void setsId(int sId) {
		this.sId = sId;
	}
	public String getHashTag() {
		return hashTag;
	}
	public void setHashTag(String hashTag) {
		this.hashTag = hashTag;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public int getCountTag() {
		return countTag;
	}
	public void setCountTag(int countTag) {
		this.countTag = countTag;
	}
	public Timestamp getSearch_time() {
		return search_time;
	}
	public void setSearch_time(Timestamp search_time) {
		this.search_time = search_time;
	}
	
	
}

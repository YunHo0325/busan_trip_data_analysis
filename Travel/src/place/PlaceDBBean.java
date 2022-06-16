package place;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import member.MemDataBean;

public class PlaceDBBean{
	
private static PlaceDBBean instance = new PlaceDBBean();
	
	public static PlaceDBBean getInstance() {
		return instance;
	}
	
	private PlaceDBBean() {}
	
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/busan");
		return (Connection) ds.getConnection();
	}

	public List<PlaceDataBean> getAllPlaces() {
		List<PlaceDataBean> placeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from placeInfo where img is not null";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				placeList = new ArrayList<PlaceDataBean>();
				do {
					PlaceDataBean place = new PlaceDataBean();
					place.setpId(rs.getInt("pId"));
					place.setPLACE_NM(rs.getString("PLACE_NM"));
					place.setGUGUN_NM(rs.getString("GUGUN_NM"));
					place.setTRRSRT_LA(rs.getInt("TRRSRT_LA"));
					place.setTRRSRT_LO(rs.getInt("TRRSRT_LO"));
					place.setTRRSRT_ROAD_NM_ADDR(rs.getString("TRRSRT_ROAD_NM_ADDR"));
					place.setTEL_NO(rs.getString("TEL_NO"));
					place.setGRP_NM(rs.getString("GRP_NM"));
					place.setSEASON_NM(rs.getString("SEASON_NM"));
					place.setIEM_NM(rs.getString("IEM_NM"));
					place.setCL_NM(rs.getString("CL_NM"));
					place.setETC_CN(rs.getString("ETC_CN"));
					place.setImg(rs.getString("img"));
					place.setCreate_time(rs.getTimestamp("create_time"));
					
					placeList.add(place);
				}while(rs.next());
			}
			
			
		}catch(Exception e) {
			System.out.println("select Exception : "+e.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception ex) {
					System.out.println("ResultSet release exception : "+ ex.getMessage());
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception ex) {
					System.out.println("pstmt release exception : "+ ex.getMessage());
				}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception ex) {
					System.out.println("connection release exception : "+ ex.getMessage());
				}
			}
		}
		
		return placeList;
	}
	
	public List<PlaceDataBean> getPlaces(String GUGUN_NM) {
		List<PlaceDataBean> placeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from placeInfo where GUGUN_NM=? and img is not null";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, GUGUN_NM);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				placeList = new ArrayList<PlaceDataBean>();
				do {
					PlaceDataBean place = new PlaceDataBean();
					place.setpId(rs.getInt("pId"));
					place.setPLACE_NM(rs.getString("PLACE_NM"));
					place.setGUGUN_NM(rs.getString("GUGUN_NM"));
					place.setTRRSRT_LA(rs.getInt("TRRSRT_LA"));
					place.setTRRSRT_LO(rs.getInt("TRRSRT_LO"));
					place.setTRRSRT_ROAD_NM_ADDR(rs.getString("TRRSRT_ROAD_NM_ADDR"));
					place.setTEL_NO(rs.getString("TEL_NO"));
					place.setGRP_NM(rs.getString("GRP_NM"));
					place.setSEASON_NM(rs.getString("SEASON_NM"));
					place.setIEM_NM(rs.getString("IEM_NM"));
					place.setCL_NM(rs.getString("CL_NM"));
					place.setETC_CN(rs.getString("ETC_CN"));
					place.setImg(rs.getString("img"));
					place.setCreate_time(rs.getTimestamp("create_time"));
					
					placeList.add(place);
				}while(rs.next());
			}
			
			
		}catch(Exception e) {
			System.out.println("select Exception : "+e.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception ex) {
					System.out.println("ResultSet release exception : "+ ex.getMessage());
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception ex) {
					System.out.println("pstmt release exception : "+ ex.getMessage());
				}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception ex) {
					System.out.println("connection release exception : "+ ex.getMessage());
				}
			}
		}
		
		return placeList;
	}
	
	public List<PlaceDataBean> getGUGUN(){
		List<PlaceDataBean> placeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select distinct(GUGUN_NM) from placeInfo";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				placeList = new ArrayList<PlaceDataBean>();
				do {
					PlaceDataBean place = new PlaceDataBean();
					place.setGUGUN_NM(rs.getString("GUGUN_NM"));
					placeList.add(place);
			
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("select Exception : "+e.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception ex) {
					System.out.println("ResultSet release exception : "+ ex.getMessage());
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception ex) {
					System.out.println("pstmt release exception : "+ ex.getMessage());
				}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception ex) {
					System.out.println("connection release exception : "+ ex.getMessage());
				}
			}
		}
		
		return placeList;
	}
	
	public List<PlaceDataBean> detailPlace(int pId) {
		List<PlaceDataBean> placeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from placeInfo where pId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				placeList = new ArrayList<PlaceDataBean>();
				do {
					PlaceDataBean place = new PlaceDataBean();
					place.setpId(rs.getInt("pId"));
					place.setPLACE_NM(rs.getString("PLACE_NM"));
					place.setGUGUN_NM(rs.getString("GUGUN_NM"));
					place.setTRRSRT_LA(rs.getInt("TRRSRT_LA"));
					place.setTRRSRT_LO(rs.getInt("TRRSRT_LO"));
					place.setTRRSRT_ROAD_NM_ADDR(rs.getString("TRRSRT_ROAD_NM_ADDR"));
					place.setTEL_NO(rs.getString("TEL_NO"));
					place.setGRP_NM(rs.getString("GRP_NM"));
					place.setSEASON_NM(rs.getString("SEASON_NM"));
					place.setIEM_NM(rs.getString("IEM_NM"));
					place.setCL_NM(rs.getString("CL_NM"));
					place.setETC_CN(rs.getString("ETC_CN"));
					place.setImg(rs.getString("img"));
					place.setCreate_time(rs.getTimestamp("create_time"));
					
					placeList.add(place);
			
				}while(rs.next());
			}
			
			
		}catch(Exception e) {
			System.out.println("select Exception : "+e.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception ex) {
					System.out.println("ResultSet release exception : "+ ex.getMessage());
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception ex) {
					System.out.println("pstmt release exception : "+ ex.getMessage());
				}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception ex) {
					System.out.println("connection release exception : "+ ex.getMessage());
				}
			}
		}
		
		return placeList;
	}

	public List<PlaceDataBean> getPlacesBypId(String [] pId_li) {
		List<PlaceDataBean> placeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String pId = "";
		for(int i=0; i<pId_li.length; i++) {
			if(pId != "")
				pId += ",";
			
			pId += pId_li[i];
		}
		
		
		try {
			conn = getConnection();
			String sql = "select * from placeInfo where pId in ("+pId+")";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				placeList = new ArrayList<PlaceDataBean>();
				do {
					PlaceDataBean place = new PlaceDataBean();
					place.setpId(rs.getInt("pId"));
					place.setPLACE_NM(rs.getString("PLACE_NM"));
					place.setGUGUN_NM(rs.getString("GUGUN_NM"));
					place.setTRRSRT_LA(rs.getInt("TRRSRT_LA"));
					place.setTRRSRT_LO(rs.getInt("TRRSRT_LO"));
					place.setTRRSRT_ROAD_NM_ADDR(rs.getString("TRRSRT_ROAD_NM_ADDR"));
					place.setTEL_NO(rs.getString("TEL_NO"));
					place.setGRP_NM(rs.getString("GRP_NM"));
					place.setSEASON_NM(rs.getString("SEASON_NM"));
					place.setIEM_NM(rs.getString("IEM_NM"));
					place.setCL_NM(rs.getString("CL_NM"));
					place.setETC_CN(rs.getString("ETC_CN"));
					place.setImg(rs.getString("img"));
					place.setCreate_time(rs.getTimestamp("create_time"));
					
					placeList.add(place);
			
				}while(rs.next());
			}
			
			
		}catch(Exception e) {
			System.out.println("select Exception : "+e.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception ex) {
					System.out.println("ResultSet release exception : "+ ex.getMessage());
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception ex) {
					System.out.println("pstmt release exception : "+ ex.getMessage());
				}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception ex) {
					System.out.println("connection release exception : "+ ex.getMessage());
				}
			}
		}
		
		return placeList;
	}
	
	public List<PlaceDataBean> searchPlaces(String PLACE_NM) {
		List<PlaceDataBean> placeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from placeInfo where PLACE_NM = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, PLACE_NM);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				placeList = new ArrayList<PlaceDataBean>();
				do {
					PlaceDataBean place = new PlaceDataBean();
					place.setpId(rs.getInt("pId"));
					place.setPLACE_NM(rs.getString("PLACE_NM"));
					place.setGUGUN_NM(rs.getString("GUGUN_NM"));
					place.setTRRSRT_LA(rs.getInt("TRRSRT_LA"));
					place.setTRRSRT_LO(rs.getInt("TRRSRT_LO"));
					place.setTRRSRT_ROAD_NM_ADDR(rs.getString("TRRSRT_ROAD_NM_ADDR"));
					place.setTEL_NO(rs.getString("TEL_NO"));
					place.setGRP_NM(rs.getString("GRP_NM"));
					place.setSEASON_NM(rs.getString("SEASON_NM"));
					place.setIEM_NM(rs.getString("IEM_NM"));
					place.setCL_NM(rs.getString("CL_NM"));
					place.setETC_CN(rs.getString("ETC_CN"));
					place.setImg(rs.getString("img"));
					place.setCreate_time(rs.getTimestamp("create_time"));
					
					placeList.add(place);
			
				}while(rs.next());
			}
			
			
		}catch(Exception e) {
			System.out.println("select Exception : "+e.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception ex) {
					System.out.println("ResultSet release exception : "+ ex.getMessage());
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception ex) {
					System.out.println("pstmt release exception : "+ ex.getMessage());
				}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception ex) {
					System.out.println("connection release exception : "+ ex.getMessage());
				}
			}
		}
		
		return placeList;
	}
}
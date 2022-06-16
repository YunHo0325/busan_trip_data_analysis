package place;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class AreaSearchDBBean {
	private static AreaSearchDBBean instance = new AreaSearchDBBean();
	
	public static AreaSearchDBBean getInstance() {
		return instance;
	}
	
	private AreaSearchDBBean() {}
	
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/busan");
		return (Connection) ds.getConnection();
	}
	
	public List<AreaSearchDataBean> areaSearch(int sId, String hashTag) {
		List<AreaSearchDataBean> areaSearchList = null;
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null; 


		try {
			conn = getConnection();
			String sql = "select * "
					+ "from areaStatistic "
					+ "where sId=? and hashTag=? "
					+ "order by countTag desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sId);
			pstmt.setString(2, hashTag);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				areaSearchList = new ArrayList<AreaSearchDataBean>();
				do {
					AreaSearchDataBean areaSearch = new AreaSearchDataBean();
					areaSearch.setAsId(rs.getInt("asId"));
					areaSearch.setsId(rs.getInt("sId"));
					areaSearch.setHashTag(rs.getString("hashTag"));
					areaSearch.setArea(rs.getString("area"));
					areaSearch.setCountTag(rs.getInt("countTag"));
					areaSearch.setSearch_time(rs.getTimestamp("search_time"));
					
					areaSearchList.add(areaSearch);
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
		
		return areaSearchList;
	}
	
}

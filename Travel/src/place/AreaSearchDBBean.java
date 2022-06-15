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
	
	public int areaSearchRanking(String PLC_NM) {
		List<AreaSearchDataBean> areaSearchList = null;
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		int ranking = 1;
		int ranking_flag = 0;
		String find_str = PLC_NM.split(" ")[0];
		String str = "";
		try {
			conn = getConnection();
			String sql = "SELECT c.PLC_NM, SUM(c.CARD_UTILIIZA_CAS_CO) "
					+ "FROM areaSearch c "
					+ "GROUP BY c.PLC_NM "
					+ "ORDER BY c.PLC_NM desc;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				areaSearchList = new ArrayList<AreaSearchDataBean>();
				do {
					AreaSearchDataBean areaSearch = new AreaSearchDataBean();
					str = rs.getString("PLC_NM");
					areaSearch.setPLC_NM(rs.getString("PLC_NM"));
					areaSearch.setSumValue(rs.getLong("SUM(c.CARD_UTILIIZA_CAS_CO)"));
					areaSearchList.add(areaSearch);
					
					if(str.contains(find_str)) {
						ranking_flag = 1;
						break;
					}
					else {
						ranking += 1;
					}
				}while(rs.next());
				
				if(ranking_flag == 0) {
					ranking = -1;
				}
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
		
		return ranking;
	}
	
}

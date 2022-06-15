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

public class TransDBBean{
	
private static TransDBBean instance = new TransDBBean();
	
	public static TransDBBean getInstance() {
		return instance;
	}
	
	private TransDBBean() {}
	
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/busan");
		return (Connection) ds.getConnection();
	}
	
	public List<TransDataBean> getTime(int pId) {
		List<TransDataBean> transList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select Time from transport where pId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				transList = new ArrayList<TransDataBean>();
				do {
					TransDataBean trans = new TransDataBean();
                    			trans.settId(rs.getInt("tId"));
					trans.setpId(rs.getInt("pId"));
					trans.setPLACE_NM(rs.getString("PLACE_NM"));
					trans.setTRRSRT_ROAD_NM_ADDR(rs.getString("TRRSRT_ROAD_NM_ADDR"));
					trans.setCRSLK_ADDR(rs.getString("CRSLK_ADDR"));
					trans.setCRSLK_ROAD_NM(rs.getString("CRSLK_ROAD_NM"));
					trans.setCHILD_PRTC_ZONE_AT(rs.getString("CHILD_PRTC_ZONE_AT"));
					trans.setCRSLK_LA(rs.getFloat("CRSLK_LA"));
					trans.setCRSLK_LO(rs.getFloat("CRSLK_LO"));
					
					transList.add(trans);
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
	

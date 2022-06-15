package city;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CityDBBean {

	private static CityDBBean instance = new CityDBBean();
	
	public static CityDBBean getInstance() {
		return instance;
	}
	
	private CityDBBean() {}
	
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/busan");
		return (Connection) ds.getConnection();
	}
	
	public List<CityDataBean> getCities(String cId) {
		List<CityDataBean> cityList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from city where cId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cityList = new ArrayList<CityDataBean>();
				do {
					CityDataBean city = new CityDataBean();
					city.setcId(rs.getString("cId"));
					city.setCityId(rs.getString("cityId"));
					city.setCityName(rs.getString("cityName"));
					cityList.add(city);
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
		
		return cityList;
	}
}

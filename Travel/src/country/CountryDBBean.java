package country;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CountryDBBean {
	
	private static CountryDBBean instance = new CountryDBBean();
	
	public static CountryDBBean getInstance() {
		return instance;
	}
	
	private CountryDBBean() {}
	
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/travel");
		return (Connection) ds.getConnection();
	}
	
	public List<CountryDataBean> getCountries() {
		List<CountryDataBean> countryList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from country";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				countryList = new ArrayList<CountryDataBean>();
				do {
					CountryDataBean country = new CountryDataBean();
					country.setcId(rs.getString("cId"));
					country.setcName(rs.getString("cName"));
					country.setCapital(rs.getString("captital"));
					country.setPresident(rs.getString("president"));
					country.setPeople(rs.getInt("people"));
					country.setExplanation(rs.getString("explanation"));
					country.setVolt(rs.getString("volt"));
					country.setReg_date(rs.getTimestamp("reg_date"));
					countryList.add(country);
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
		
		return countryList;
	}
	
	public List<CountryDataBean> detailCountry(String cId) {
		List<CountryDataBean> countryList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from country where cId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				countryList = new ArrayList<CountryDataBean>();
				do {
					CountryDataBean country = new CountryDataBean();
					country.setcId(rs.getString("cId"));
					country.setcName(rs.getString("cName"));
					country.setCapital(rs.getString("capital"));
					country.setPresident(rs.getString("president"));
					country.setPeople(rs.getInt("people"));
					country.setExplanation(rs.getString("explanation"));
					country.setVolt(rs.getString("volt"));
					country.setReg_date(rs.getTimestamp("reg_date"));
					countryList.add(country);
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
		
		return countryList;
	}
}

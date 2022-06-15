package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class WishDBBean {
	private static WishDBBean instance = new WishDBBean();
	
	public static WishDBBean getInstance() {
		return instance;
	}
	
	private WishDBBean() {}
	
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/busan");
		return (Connection) ds.getConnection();
	}
	
	public List<WishDataBean> getWish(String uId) {
		List<WishDataBean> wishList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from wish where uId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				wishList = new ArrayList<WishDataBean>();
				do {
					WishDataBean wish = new WishDataBean();
					wish.setuId(rs.getString("uId"));
					wish.setpId(rs.getInt("pId"));
					wishList.add(wish);
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
		
		return wishList;
	}
	
	public List<WishDataBean> searchWish(String uId, int pId) {
		List<WishDataBean> wishList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from wish where uId=? and pId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uId);
			pstmt.setInt(2, pId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				wishList = new ArrayList<WishDataBean>();
				do {
					WishDataBean wish = new WishDataBean();
					wish.setuId(rs.getString("uId"));
					wish.setpId(rs.getInt("pId"));
					wishList.add(wish);
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
		
		return wishList;
	}
	
	public void insert(WishDataBean wish) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "insert into wish(uId, pId)";
			sql +=" values (?, ?);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  wish.getuId());
			pstmt.setInt(2,  wish.getpId());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("insert Exception : "+e.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception ex) {
					System.out.println("inset release exception : "+ ex.getMessage());
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
	}
	public void delete(String uId, int pId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "delete from wish where uId=? and pId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  uId);
			pstmt.setInt(2,  pId);
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("delete Exception : "+e.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception ex) {
					System.out.println("inset release exception : "+ ex.getMessage());
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
	}
}

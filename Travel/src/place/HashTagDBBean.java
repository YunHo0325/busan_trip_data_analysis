package place;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class HashTagDBBean {
	private static HashTagDBBean instance = new HashTagDBBean();
	
	public static HashTagDBBean getInstance() {
		return instance;
	}
	
	private HashTagDBBean() {}
	
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/busan");
		return (Connection) ds.getConnection();
	}
	
	public List<HashTagDataBean> detailHashTags(int pId) {
		List<HashTagDataBean> hashTagList = null;
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from hashtag where pId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				hashTagList = new ArrayList<HashTagDataBean>();
				do {
					HashTagDataBean hashTag = new HashTagDataBean();
					hashTag.sethId(rs.getInt("hId"));
					hashTag.setpId(rs.getInt("pId"));
					hashTag.setHashTag(rs.getString("hashTag"));
					hashTagList.add(hashTag);
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
		
		return hashTagList;
	}
	

	public List<HashTagDataBean> getTagTypeDetail(String tagType) {
		List<HashTagDataBean> hashTagList = null;
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select distinct(hashTag) from hashtag where tagType=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tagType);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				hashTagList = new ArrayList<HashTagDataBean>();
				do {
					HashTagDataBean hashTag = new HashTagDataBean();
					hashTag.setHashTag(rs.getString("hashTag"));
					hashTagList.add(hashTag);
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
		
		return hashTagList;
	}


	public List<HashTagDataBean> getTagType() {
		List<HashTagDataBean> hashTagList = null;
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select distinct(tagType) from hashtag";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				hashTagList = new ArrayList<HashTagDataBean>();
				do {
					HashTagDataBean hashTag = new HashTagDataBean();
					hashTag.setTagType(rs.getString("tagType"));
					hashTagList.add(hashTag);
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
		
		return hashTagList;
	}
	
	public List<HashTagDataBean> searchHashTags(String search_text) {
		List<HashTagDataBean> hashTagList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from hashtag where hashTag=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, search_text);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				hashTagList = new ArrayList<HashTagDataBean>();
				do {
					HashTagDataBean hashTag = new HashTagDataBean();
					hashTag.sethId(rs.getInt("hId"));
					hashTag.setpId(rs.getInt("pId"));
					hashTag.setHashTag(rs.getString("hashTag"));
					hashTagList.add(hashTag);
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
		
		return hashTagList;
	}
	

	public List<HashTagDataBean> searchManyHashTags(String search_text, String [] hashTag_li) {
		List<HashTagDataBean> hashTagList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			
			String search_text2 = "";
			if(hashTag_li != null) {
				search_text2 = hashTag_li[0];
				for(int i=1; i<hashTag_li.length; i++)
					search_text2 += "', '" + hashTag_li[i];
			}

			String sql = "select distinct(h.pId)"
					+ "from hashtag h join placeInfo p on h.pId = p.pId "
					+ "where p.PLACE_NM like '%"+search_text+"%' or hashTag in ('"+search_text2+"')";
			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, search_text);
//			pstmt.setString(2, search_text2);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				hashTagList = new ArrayList<HashTagDataBean>();
				do {
					HashTagDataBean hashTag = new HashTagDataBean();
					hashTag.setpId(rs.getInt("pId"));
					hashTagList.add(hashTag);
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
		
		return hashTagList;
	}
}

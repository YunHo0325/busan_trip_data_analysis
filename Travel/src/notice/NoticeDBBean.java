package notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class NoticeDBBean {
	private static NoticeDBBean instance = new NoticeDBBean();
	
	public static NoticeDBBean getInstance() {
		return instance;
	}
	
	private NoticeDBBean() {}
	
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/travel");
		return (Connection) ds.getConnection();
	}
	
	public void increaseReadCount(NoticeDataBean notice) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int rc = 0;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "select * from notice where nNum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,  notice.getnNum());
			
			rs = pstmt.executeQuery();
			System.out.println(rs);
			if(rs.next()) {
				rc = rs.getInt("readcount") + 1;
			}
			sql = "update notice set readcount = ? where nNum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rc);
			pstmt.setInt(2, notice.getnNum());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("update Exception : "+e.getMessage());
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
	}
	public void insert(NoticeDataBean notice) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select count(*) from notice";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				System.out.println(rs.getInt(1)+1);
				sql = "insert into notice(subject, reg_date, content, nNum)";
				sql +=" values (?, ?, ?, ?);";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, notice.getSubject());
				pstmt.setTimestamp(2, notice.getReg_date());
				pstmt.setString(3, notice.getContent());
				pstmt.setInt(4, rs.getInt(1)+1);
				pstmt.executeUpdate();
			}
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
	
	public void update(NoticeDataBean notice) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "update notice set subject=?, reg_date=?, content=? where nNum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice.getSubject());
			pstmt.setTimestamp(2, notice.getReg_date());
			pstmt.setString(3, notice.getContent());
			pstmt.setInt(4, notice.getnNum());
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("update Exception : "+e.getMessage());
		}finally {
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
	}
	
	public void delete(NoticeDataBean notice) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "";
			
			sql = "select * from notice where nNum > " + notice.getnNum();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			sql = "delete from notice where nNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,  notice.getnNum());
			pstmt.executeUpdate();
			
			if(rs.next()) {
				do {
					sql = "update notice set nNum = ? where nNum = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, rs.getInt("nNum")-1);
					pstmt.setInt(2, rs.getInt("nNum"));
					pstmt.executeUpdate();
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("delete Exception : "+e.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception ex) {
					System.out.println("rs release exception : "+ ex.getMessage());
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception ex) {
					System.out.println("delete release exception : "+ ex.getMessage());
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
	
	public List<NoticeDataBean> getNotices(int start, int end) {
		List<NoticeDataBean> noticeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from notice order by nNum desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				noticeList = new ArrayList<NoticeDataBean>();
				do {
					NoticeDataBean notice = new NoticeDataBean();
					notice.setnNum(rs.getInt("nNum"));
					notice.setSubject(rs.getString("subject"));
					notice.setReadcount(rs.getInt("readcount"));
					notice.setContent(rs.getString("content"));
					notice.setReg_date(rs.getTimestamp("reg_date"));
					noticeList.add(notice);
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
					System.out.println("select release exception : "+ ex.getMessage());
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
		
		return noticeList;
	}
	public int getNoticeCount() {
		int count = 0;
			
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql="select count(*) from notice";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			System.out.println("select Exception : "+ e.getMessage());
		}finally {
			try {
				if(rs != null)	
					rs.close();
			}catch(Exception e) {
				System.out.println("ResultSet Release Exception : "+e.getMessage());
			}
			try {
				if(pstmt != null)	
					pstmt.close();
			}catch(Exception e) {
				System.out.println("PreparedStatement Release Exception : "+e.getMessage());
			}
			try {
				if(conn != null){
					conn.close();
				}
			}catch(Exception e) {
				System.out.println("Connection Release Exception : "+e.getMessage());
			}
		}
		return count;
	}
	public List<NoticeDataBean> searchNotices(String filter, String search_text, int start, int end) {
		List<NoticeDataBean> noticeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from notice where "+filter+" LIKE '%"+search_text+"%' order by nNum desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				noticeList = new ArrayList<NoticeDataBean>();
				do {
					NoticeDataBean notice = new NoticeDataBean();
					notice.setnNum(rs.getInt("nNum"));
					notice.setSubject(rs.getString("subject"));
					notice.setReadcount(rs.getInt("readcount"));
					notice.setContent(rs.getString("content"));
					notice.setReg_date(rs.getTimestamp("reg_date"));
					noticeList.add(notice);
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
					System.out.println("select release exception : "+ ex.getMessage());
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
		
		return noticeList;
	}
	public int searchNoticeCount(String filter, String search_text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from notice where "+filter+" LIKE '%"+search_text+"%'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
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
					System.out.println("select release exception : "+ ex.getMessage());
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
		
		return count;
	}
	public List<NoticeDataBean> detailNotices(int nNum) {
		List<NoticeDataBean> noticeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from notice where nNum="+nNum;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				noticeList = new ArrayList<NoticeDataBean>();
				do {
					NoticeDataBean notice = new NoticeDataBean();
					notice.setnNum(rs.getInt("nNum"));
					notice.setSubject(rs.getString("subject"));
					notice.setReadcount(rs.getInt("readcount"));
					notice.setContent(rs.getString("content"));
					notice.setReg_date(rs.getTimestamp("reg_date"));
					noticeList.add(notice);
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
					System.out.println("select release exception : "+ ex.getMessage());
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
		
		return noticeList;
	}
	
	
}

package quest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class QuestDBBean {
	private static QuestDBBean instance = new QuestDBBean();
	
	public static QuestDBBean getInstance() {
		return instance;
	}
	
	private QuestDBBean() {}
	
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/travel");
		return (Connection) ds.getConnection();
	}
	
	public void increaseReadCount(QuestDataBean quest) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int rc = 0;
		String sql = "";
		
		try {
			conn = getConnection();
			System.out.println(quest.getNum());
			sql = "select * from quest where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,  quest.getNum());
			
			rs = pstmt.executeQuery();
			System.out.println(rs);
			if(rs.next()) {
				rc = rs.getInt("readcount") + 1;
			}
			sql = "update quest set readcount = ? where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rc);
			pstmt.setInt(2, quest.getNum());
			
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
	public void insert(QuestDataBean quest) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select count(num) from quest";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				System.out.println(rs.getInt(1)+1);
				sql = "insert into quest(uId, subject, passwd, reg_date, content, num)";
				sql +=" values (?, ?, ?, ?, ?, ?);";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,  quest.getuId());
				pstmt.setString(2, quest.getSubject());
				pstmt.setString(3, quest.getPasswd());
				pstmt.setTimestamp(4, quest.getReg_date());
				pstmt.setString(5, quest.getContent());
				pstmt.setInt(6, rs.getInt(1)+1);
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
	
	public void update(QuestDataBean quest) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "update quest set subject=?, passwd=?, reg_date=?, content=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, quest.getSubject());
			pstmt.setString(2, quest.getPasswd());
			pstmt.setTimestamp(3, quest.getReg_date());
			pstmt.setString(4, quest.getContent());
			pstmt.setInt(5, quest.getNum());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("update Exception : "+e.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception ex) {
					System.out.println("update release exception : "+ ex.getMessage());
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
	
	public void delete(QuestDataBean quest) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "";
			
			sql = "select * from quest where num > " + quest.getNum();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			sql = "delete from quest where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,  quest.getNum());
			pstmt.executeUpdate();
			
			if(rs.next()) {
				do {
					sql = "update quest set num = ? where num = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, rs.getInt("num")-1);
					pstmt.setInt(2, rs.getInt("num"));
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
	
	public List<QuestDataBean> getQuests(int start, int end) {
		List<QuestDataBean> questList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from quest order by num desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				questList = new ArrayList<QuestDataBean>();
				do {
					QuestDataBean quest = new QuestDataBean();
					quest.setNum(rs.getInt("num"));
					quest.setuId(rs.getString("uId"));
					quest.setSubject(rs.getString("subject"));
					quest.setPasswd(rs.getString("passwd"));
					quest.setReadcount(rs.getInt("readcount"));
					quest.setReg_date(rs.getTimestamp("reg_date"));
					quest.setContent(rs.getString("content"));
					quest.setAnswer(rs.getString("answer"));
					
					questList.add(quest);
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
		
		return questList;
	}
	public int getAllQuest() {
		List<QuestDataBean> questList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from quest";
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
	public List<QuestDataBean> searchQuests(String filter, String search_text, int start, int end) {
		List<QuestDataBean> questList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from quest where "+filter+" LIKE '%"+search_text+"%' order by num desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				questList = new ArrayList<QuestDataBean>();
				do {
					QuestDataBean quest = new QuestDataBean();
					quest.setNum(rs.getInt("num"));
					quest.setuId(rs.getString("uId"));
					quest.setSubject(rs.getString("subject"));
					quest.setPasswd(rs.getString("passwd"));
					quest.setReadcount(rs.getInt("readcount"));
					quest.setReg_date(rs.getTimestamp("reg_date"));
					quest.setContent(rs.getString("content"));
					quest.setAnswer(rs.getString("answer"));
					
					questList.add(quest);
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
		
		return questList;
	}
	
	public int searchQuestCount(String filter, String search_text) {
		List<QuestDataBean> questList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from quest where "+filter+" LIKE '%"+search_text+"%'";
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
	
	
	public List<QuestDataBean> detailQuests(int num) {
		List<QuestDataBean> questList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from quest where num="+num;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				questList = new ArrayList<QuestDataBean>();
				do {
					System.out.println("ok");
					QuestDataBean quest = new QuestDataBean();
					quest.setNum(rs.getInt("num"));
					quest.setuId(rs.getString("uId"));
					quest.setSubject(rs.getString("subject"));
					quest.setPasswd(rs.getString("passwd"));
					quest.setReadcount(rs.getInt("readcount"));
					quest.setReg_date(rs.getTimestamp("reg_date"));
					quest.setContent(rs.getString("content"));
					quest.setAnswer(rs.getString("answer"));
					System.out.println(rs.getInt("num"));
					questList.add(quest);
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
		
		return questList;
	}
	public List<QuestDataBean> updateQuests(String uId) {
		List<QuestDataBean> questList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from quest where uId=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, uId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("userId").equals(uId)) {
					questList = new ArrayList<QuestDataBean>();
					do {
						QuestDataBean quest = new QuestDataBean();
						quest.setNum(rs.getInt("num"));
						quest.setuId(rs.getString("uId"));
						quest.setSubject(rs.getString("subject"));
						quest.setPasswd(rs.getString("passwd"));
						quest.setReadcount(rs.getInt("readcount"));
						quest.setReg_date(rs.getTimestamp("reg_date"));
						quest.setContent(rs.getString("content"));
						quest.setAnswer(rs.getString("answer"));
						
						questList.add(quest);
					}while(rs.next());
					
				}
			}
			
			
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
		
		return questList;
	}
	public List<QuestDataBean> updateAnswer(String answer, int num) {
		List<QuestDataBean> questList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			System.out.println(answer);
			String sql = "update quest set answer=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, answer);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("update Exception : "+e.getMessage());
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
		
		return questList;
	}
	
	public int getQuestCount() {
		int count = 0;
			
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql="select count(*) from quest";
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
}

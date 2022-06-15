package place;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class GradeDBBean {
	private static GradeDBBean instance = new GradeDBBean();
	
	public static GradeDBBean getInstance() {
		return instance;
	}
	
	private GradeDBBean() {}
	
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/busan");
		return (Connection) ds.getConnection();
	}
	
	public List<GradeDataBean> getGrades(int pId) {
		List<GradeDataBean> gradeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from grade where pId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				gradeList = new ArrayList<GradeDataBean>();
				do {
					GradeDataBean grade = new GradeDataBean();
					grade.setuId(rs.getString("uId"));
					grade.setpId(rs.getInt("pId"));
					grade.setpGrade(rs.getInt("pGrade"));
					grade.setgSubject(rs.getString("gSubject"));
					grade.setgContent(rs.getString("gContent"));
					grade.setReg_date(rs.getTimestamp("reg_date"));
					gradeList.add(grade);
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
		
		return gradeList;
	}
	
	public void insert(GradeDataBean grade) {
		Connection conn = null;
		PreparedStatement pstmt = null;


		String sql = "";
		try {
				conn = getConnection();
				sql = "insert into grade(uId, pId, pGrade, gSubject, gContent, reg_date)";
				sql +=" values (?, ?, ?, ?, ?, ?);";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, grade.getuId());
				pstmt.setInt(2, grade.getpId());
				pstmt.setInt(3, grade.getpGrade());
				pstmt.setString(4, grade.getgSubject());
				pstmt.setString(5, grade.getgContent());
				pstmt.setTimestamp(6, grade.getReg_date());
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
	
	public void update(String uId, String pId, GradeDataBean grade) {
		Connection conn = null;
		PreparedStatement pstmt = null;


		String sql = "";
		try {
				conn = getConnection();
				sql = "update grade set pGrade=?, gSubject=?, gContent=?, reg_date=? where uId=? and pId=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, grade.getpGrade());
				pstmt.setString(2, grade.getgSubject());
				pstmt.setString(3, grade.getgContent());
				pstmt.setTimestamp(4, grade.getReg_date());
				pstmt.setString(5, grade.getuId());
				pstmt.setInt(6, grade.getpId());
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
	}
	
	public void delete(GradeDataBean grade) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "";
			
			sql = "delete from grade where uId= ? and pId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, grade.getuId());
			pstmt.setInt(2, grade.getpId());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("delete Exception : "+e.getMessage());
		}finally {
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
	
	public int searchGrade(String uId, int pId) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from grade where pId=? and uId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pId);
			pstmt.setString(2, uId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = 1;
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
		
		return count;
	}
}

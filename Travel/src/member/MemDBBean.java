package member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import place.PlaceDataBean;

public class MemDBBean {
	private static MemDBBean instance = new MemDBBean();
	
	public static MemDBBean getInstance() {
		return instance;
	}
	
	private MemDBBean() {}
	
	private Connection getConnection() throws Exception{

		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/busan");
		return (Connection) ds.getConnection();
	}
	
	public void insert(MemDataBean member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "insert into member(uId, pwd, uName, age, sex, email)";
			sql +=" values (?, ?, ?, ?, ?, ?);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  member.getuId());
			pstmt.setString(2,  member.getPwd());
			pstmt.setString(3,  member.getuName());
			pstmt.setInt(4,  member.getAge());
			pstmt.setString(5,  member.getSex());
			pstmt.setString(6,  member.getEmail());
			
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
	
	public void update(MemDataBean member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "update member set uId=?, pwd=?, uName=?, age=?, sex=?, email=?, phone=?, img=? where uId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  member.getuId());
			pstmt.setString(2,  member.getPwd());
			pstmt.setString(3,  member.getuName());
			pstmt.setInt(4, member.getAge());
			pstmt.setString(5,  member.getSex());
			pstmt.setString(6,  member.getEmail());
			pstmt.setString(7,  member.getPhone());
			pstmt.setString(8, member.getImg());
			pstmt.setString(9, member.getuId());
			
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
	
	public void delete(String uId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "delete from member where uId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uId);
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
	
	public List<MemDataBean> getMembers() {
		List<MemDataBean> memberList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberList = new ArrayList<MemDataBean>();
				do {
					MemDataBean member = new MemDataBean();
					member.setuId(rs.getString("uId"));
					member.setPwd(rs.getString("pwd"));
					member.setuName(rs.getString("uName"));
					member.setAge(rs.getInt("age"));
					member.setSex(rs.getString("sex"));
					member.setEmail(rs.getString("email"));
					member.setPhone(rs.getString("phone"));
					member.setImg(rs.getString("img"));
					member.setReg_date(rs.getTimestamp("reg_date"));
					memberList.add(member);
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
		
		return memberList;
	}

	
	  public List<MemDataBean> getAdmin() { 
		  List<MemDataBean> memberList = null;
		  Connection conn = null; 
		  PreparedStatement pstmt = null; 
		  ResultSet rs = null;
		  try { 
			  conn = getConnection(); 
			  String sql ="select * from member where uId='admin'"; 
			  pstmt = conn.prepareStatement(sql); 
			  rs =pstmt.executeQuery();
	  
			  if(rs.next()) { 
				  memberList = new ArrayList<MemDataBean>(); 
				  do { 
					  MemDataBean member = new MemDataBean(); 
					  member.setuId(rs.getString("uId"));
					  member.setPwd(rs.getString("pwd")); 
					  member.setuName(rs.getString("uName"));
					  member.setAge(rs.getInt("age")); 
					  member.setSex(rs.getString("sex"));
					  member.setEmail(rs.getString("email"));
					  member.setPhone(rs.getString("phone")); 
					  member.setImg(rs.getString("img"));
					  member.setReg_date(rs.getTimestamp("reg_date"));
					  memberList.add(member);
				  }while(rs.next()); }
				  
				  
			  }catch(Exception e) {
				  System.out.println("insert Exception : "+e.getMessage()); 
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
						  try { conn.close(); 
						  }catch(Exception ex) {
							  System.out.println("connection release exception : "+ ex.getMessage()); 
						  } 
					  } 
				  }
			  
			  return memberList; 
	  }
	 
	public List<MemDataBean> searchMembers(String uId) {
		List<MemDataBean> memberList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		if(uId == null)
			return memberList;
		try {
			conn = getConnection();
			String sql = "select * from member where uId='"+uId+"'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberList = new ArrayList<MemDataBean>();
				do {
					MemDataBean member = new MemDataBean();
					member.setuId(rs.getString("uId"));
					member.setPwd(rs.getString("pwd"));
					member.setuName(rs.getString("uName"));
					member.setAge(rs.getInt("age"));
					member.setSex(rs.getString("sex"));
					member.setEmail(rs.getString("email"));
					member.setPhone(rs.getString("phone"));
					member.setImg(rs.getString("img"));
					member.setReg_date(rs.getTimestamp("reg_date"));
					memberList.add(member);
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
		
		return memberList;
	}
	
	public List<MemDataBean> detailMembers(String uId) {
		List<MemDataBean> memberList = null;
		List<PlaceDataBean> placeList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from member as m join place as p on m.uId = p.pid where uId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberList = new ArrayList<MemDataBean>();
				do {
					MemDataBean member = new MemDataBean();
					member.setuId(rs.getString("uId"));
					member.setPwd(rs.getString("pwd"));
					member.setuName(rs.getString("uName"));
					member.setAge(rs.getInt("age"));
					member.setSex(rs.getString("sex"));
					member.setEmail(rs.getString("email"));
					member.setPhone(rs.getString("phone"));
					member.setImg(rs.getString("img"));
					member.setReg_date(rs.getTimestamp("reg_date"));
					memberList.add(member);
				}while(rs.next());
				placeList = new ArrayList<PlaceDataBean>();
				do {
					PlaceDataBean place = new PlaceDataBean();
					place.setpId(rs.getInt("pId"));
					place.setPLACE_NM(rs.getString("PLACE_NM"));
					place.setGUGUN_NM(rs.getString("GUGUN_NM"));
					place.setTRRSRT_LA(rs.getInt("TRRSRT_LA"));
					place.setTRRSRT_LO(rs.getInt("TRRSRT_LO"));
					place.setTRRSRT_ROAD_NM_ADDR(rs.getString("TRRSRT_ROAD_NM_ADDR"));
					place.setTEL_NO(rs.getString("TEL_NO"));
					place.setGRP_NM(rs.getString("GRP_NM"));
					place.setSEASON_NM(rs.getString("SEASON_NM"));
					place.setIEM_NM(rs.getString("IEM_NM"));
					place.setCL_NM(rs.getString("CL_NM"));
					place.setETC_CN(rs.getString("ETC_CN"));
					place.setCreate_time(rs.getTimestamp("create_time"));
					
					placeList.add(place);
				}while(rs.next());
			}
			
			
		}catch(Exception e) {
			System.out.println("insert Exception : "+e.getMessage());
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
		
		return memberList;
	}
	public List<MemDataBean> updateMembers(String uId) {
		List<MemDataBean> memberList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from member where uId=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, uId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("uId").equals(uId)) {
					memberList = new ArrayList<MemDataBean>();
					do {
						MemDataBean member = new MemDataBean();
						member.setuId(rs.getString("uId"));
						member.setPwd(rs.getString("pwd"));
						member.setuName(rs.getString("uName"));
						member.setAge(rs.getInt("age"));
						member.setSex(rs.getString("sex"));
						member.setEmail(rs.getString("email"));
						member.setPhone(rs.getString("phone"));
						member.setImg(rs.getString("img"));
						member.setReg_date(rs.getTimestamp("reg_date"));
						memberList.add(member);
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
		
		return memberList;
	}
	
	
}

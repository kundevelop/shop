package shop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

// emp 테이블을 CRUD하는 static 메서드의 컨테이너
public class EmpDAO {
	public static int insertEmp(String empId, String empPw, String empName, String empJob)
			throws Exception {
		int row = 0;
	    // DB 접근
		Connection conn = DBHelper.getConnection(); 
	      
	    String sql = "insert ... ?, ?, ?, ?";
	    PreparedStatement stmt=conn.prepareStatement(sql);
	    stmt.setString(1, empId);
	    stmt.setString(2, empPw);
	    stmt.setString(3, empName);
	    stmt.setString(4, empJob);
	    
	    row = stmt.executeUpdate();
	    
	    conn.close();
	    return row;
		
	}
	
	
	// HashMap<String, Object> : null이면 로그인 실패, 아니면 성공
	// String empId, String empPw : 로그인폼에서 사용자가 입력한 id/pw
	
	   // 호출코드 HashMap<String, Object> m = EmpDAO.empLogin("admin", "1234");
	   public static HashMap<String, Object> empLogin(String empId, String empPw)
	                                       throws Exception {
	      HashMap<String, Object> resultMap = null;
	      
	      // DB 접근
	      Connection conn = DBHelper.getConnection(); 
	      
	      String sql = "select emp_id empId, emp_name empName, grade from emp where active = 'ON' and emp_id =? and emp_pw = password(?)";
	      PreparedStatement stmt=conn.prepareStatement(sql);
	      stmt.setString(1,empId);
	      stmt.setString(2,empPw);
	      ResultSet rs = stmt.executeQuery();
	      if(rs.next()) {
	         resultMap = new HashMap<String, Object>();
	         resultMap.put("empId", rs.getString("empId"));
	         resultMap.put("empName", rs.getString("empName"));
	         resultMap.put("grade", rs.getInt("grade"));
	      }
	      conn.close();
	      return resultMap;
	   }
	   
	   
	   
	   //empList 
	   public static ArrayList<HashMap<String, Object>> selectempList(int startRow, int rowPerPage) throws Exception {
			ArrayList<HashMap<String, Object>> empList =
					new ArrayList<HashMap<String, Object>>();
		   
		      // DB 접근
		      Connection conn = DBHelper.getConnection(); 
		      
		      String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?, ?";
			  PreparedStatement stmt = conn.prepareStatement(sql);
			  stmt.setInt(1, startRow);
			  stmt.setInt(2, rowPerPage);
			  ResultSet rs = stmt.executeQuery();
			  
				while(rs.next()) {
					HashMap<String, Object> m = new HashMap<String, Object>();
					m.put("empId", rs.getString("empId"));
					m.put("empName", rs.getString("empName"));
					m.put("empJob", rs.getString("empJob"));
					m.put("hireDate", rs.getString("hireDate"));
					m.put("active", rs.getString("active"));
					empList.add(m);
				}
				conn.close();
				return empList;
		   
	   }
	   
	   //카테고리 리스트
	   public static ArrayList<HashMap<String, Object>> CntCategory() throws Exception {
		   ArrayList<HashMap<String, Object>> categoryList =
				   new ArrayList<HashMap<String, Object>>();
		   
		    Connection conn = DBHelper.getConnection();
		    String sql = "SELECT *,(SELECT COUNT(*) FROM category) cnt FROM category "; //테이블이 나눠져 있어서 서브쿼리를 사용
			PreparedStatement stmt = null;
			ResultSet rs = null; 
		    stmt = conn.prepareStatement(sql);
		    rs = stmt.executeQuery();
		    
			int totalCount = 0;
			
			while(rs.next()){
				if(totalCount == 0){
					totalCount = rs.getInt("cnt");
				}
				
				HashMap<String, Object> list = new HashMap<String, Object>();
				list.put("category", rs.getString("category"));
				list.put("createDate", rs.getString("create_date"));
				list.put("cnt", rs.getString("cnt"));
				categoryList.add(list);
			}
		   
		 
		   return categoryList;
	   }
	   
	   //카테고리 삭제
	   public static int DeleteCategory (String category, String createDate) throws Exception{
			
			//db 연결
			Connection conn = DBHelper.getConnection();
			PreparedStatement stmt = null;
			
			String sql= "DELETE FROM category WHERE category = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category);
			stmt.setString(2, createDate);
			
			int row = stmt.executeUpdate();
			

		   conn.close();
		   return row;
	   }
	   		
	   
	}

package shop.dao;

import java.sql.*;
import java.util.*;

public class CategoryDAO {
	
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
		   
			conn.close();
			return categoryList;
	   }
	   
	   
	   //카테고리 추가(addCategoryAction)
	   public static int addCategoryAction (String categoryadd) throws Exception{
		   
		    Connection conn = DBHelper.getConnection();
			PreparedStatement stmt = null;

		    String sql= "INSERT INTO category(category, create_date) VALUES(?,NOW())";
		    stmt = conn. prepareStatement(sql);
		    stmt.setString(1, categoryadd);
		    
		    int row = stmt.executeUpdate();
		   
		    
		   
		    conn.close();
		    return row;
	   }
	   
	   
	 
	   //카테고리 삭제
	   public static int deleteCategory (String category, String createDate) throws Exception{
			
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
	   
	   //modifyCategoryAction
	   public static int modifyCategoryAction (String modifyCategory, String category)
	   										throws Exception{
		   
		    Connection conn = DBHelper.getConnection();
		    
		    String sql = "UPDATE category SET category=? WHERE category=?";
		    PreparedStatement stmt = null;
		    
		    
		    stmt = conn.prepareStatement(sql);
		    stmt.setString(1, modifyCategory);
		    stmt.setString(2, category);
		    
		    int row = stmt.executeUpdate();
		   
		   
		    conn.close();
		    return row;
	   }	
	   
	   

}

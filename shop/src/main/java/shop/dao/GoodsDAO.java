package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDAO {
	
	public static ArrayList<HashMap<String, Object>> selectCategoryList() throws Exception{
		ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "select category,"
				+ " count(*) AS cnt"
				+ "	from goods"
				+ "	group by category"
				+ " order by category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {

			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", rs.getString("category"));
			m.put("cnt", rs.getInt("cnt"));
			categoryList.add(m);
		}
		conn.close();
		
		return categoryList;
		
	}
	
	
	public static ArrayList<HashMap<String, Object>> selectGoodsList(
					String category, int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter
		String sql2= "select *"
				+ " from goods"
				+ " WHERE category LIKE ?"
				+ " order by update_date desc"
				+ " limit ?, ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, "%"+category+"%");
		stmt2.setInt(2, startRow);
		stmt2.setInt(3, rowPerPage);
		
		ResultSet rs2 = stmt2.executeQuery();
		while(rs2.next()) {
			HashMap<String, Object> m2 = new HashMap<String, Object>();
			m2.put("goodsNo", rs2.getInt("goods_no"));
			m2.put("category", rs2.getString("category"));
			m2.put("empId", rs2.getString("emp_id"));
            m2.put("filename", rs2.getString("filename"));
			m2.put("goodsTitle", rs2.getString("goods_title"));
			m2.put("goodsContent", rs2.getString("goods_content"));
			m2.put("goodsPrice", rs2.getInt("goods_price"));
			m2.put("goodsAmount", rs2.getInt("goods_amount"));
			m2.put("updateDate", rs2.getString("update_date"));
			list.add(m2);
		}
		
		conn.close();
		
		return list;
	}
	
	public static ArrayList<HashMap<String, Object>> selectCategorytuple(String category) throws Exception {
		ArrayList<HashMap<String, Object>> categorytuple =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql3 = "SELECT COUNT(*) cnt"
				+ " FROM goods "
				+ "WHERE category LIKE ?";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setString(1, "%"+category+"%");
		ResultSet rs3 = stmt3.executeQuery();
		
		conn.close();
		return categorytuple;
		}
		
		
	}

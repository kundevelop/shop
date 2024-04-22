package shop.dao;

import java.sql.*;
import java.util.*;
public class CustomerDAO {
	
	//회원 가입 중복 체크
	public static boolean addCustomerIdCheck(String customerId) throws Exception{
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs= null;
		
		//아이디 중복확인 쿼리
		String sql = "SELECT mail FROM customer WHERE mail = ? ";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		rs = stmt.executeQuery();
		
		boolean checkId = false;
		
		if(rs.next()) {
			checkId = true;
		}
		
		conn.close();
		return checkId;
	
	}
	
	
	//회원가입 
	public static int addCustomerId(String customerId, String customerPw,String customerName,  String customerBirth,  String customerGender) 
			throws Exception{
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt2 = null;
		int row = 0 ;
		/*"INSERT INTO customer(mail, customer_pw, customer_name, birth, gender, update_date, create_date)
		VALUES(?, ?, ?, ?, ? , now(), now())*/
		
		String sql = "INSERT INTO customer(mail, customer_pw, customer_name, birth, gender, update_date, create_date) VALUES(?, ?, ?, ?, ?, NOW(), NOW());";
		
		stmt2 = conn.prepareStatement(sql);
		stmt2.setString(1, customerId);
		stmt2.setString(2, customerPw);
		stmt2.setString(3, customerName);
		stmt2.setString(4, customerBirth);
		stmt2.setString(5, customerGender);	
		
		
		
		row = stmt2.executeUpdate();
		
		conn.close();
		return row;
		
	}
	
	//로그인 
	public static HashMap<String, Object> customerLogin(String customerId,String customerPw) throws Exception {
		HashMap<String, Object> resultMap = null;
		
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT mail AS customerId, customer_Pw AS customerPw FROM customer WHERE mail=? AND customer_Pw= password(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setString(2, customerPw);
		//System.out.println(customerId +"<--customerId");
		//System.out.println(customerPw +"<--customerPw");
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("customerId",rs.getString("customerId")); 
			resultMap.put("customerPw",rs.getString("customerPw")); 
		}
		
		conn.close();
		return resultMap;
		
	}
	
	

}

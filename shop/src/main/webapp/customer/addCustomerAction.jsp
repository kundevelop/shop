<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="shop.dao.*"%>

<%
    //�α��� ���� �б� : ���� ���� �̸� - loginCustomer
    
    if(session.getAttribute("loginCustomer") !=null) {
        response.sendRedirect("/shop/customer/goodsList.jsp");
        return;
    }
    
    //�ַ��޼��� �޾ƿ���
    String errMsg = request.getParameter("errMsg");
    

%>

<%
	String customerId = request.getParameter("customerId");
	int customerPw = Integer.parseInt(request.getParameter("customerPw"));
	String customerName = request.getParameter("customerName");
	int customerBirth = Integer.parseInt(request.getParameter("customerBirth"));
	String customerGender = request.getParameter("customerGender");
	
	System.out.println(customerId + "<--customerId");
	System.out.println(customerPw + "<--customerPw");
	System.out.println(customerName + "<--customerName");
	System.out.println(customerBirth + "<--customerBirth");
	System.out.println(customerGender + "<--customerGender");
	
	/*"insert into customer(customer_id, customer_pw, customer_name, birth, gender, update_date, create_date)
		values(?, ?, ?, ?, ? , now(), now())*/
	
	// DB ����
	Connection conn = DBHelper.getConnection(); 	
	String sql = "insert into customer('customer_id', customer_pw, customer_name, birth, gender, update_date, create_date) values(?, ?, ?, ?, ? , now(), now())";
	
	PreparedStatement stmt=conn.prepareStatement(sql);
	stmt.setString(1, customerId);
	stmt.setInt(2, customerPw);
	stmt.setString(3, customerName);
	stmt.setInt(4, customerBirth);
	stmt.setString(5, customerGender);	
	


%>    

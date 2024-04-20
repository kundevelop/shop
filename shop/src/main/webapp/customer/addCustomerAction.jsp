	<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="shop.dao.*"%>

<%
    //로그인 인증 분기 : 세션 변수 이름 - loginCustomer
    
    if(session.getAttribute("loginCustomer") !=null) {
        response.sendRedirect("/shop/customer/goodsList.jsp");
        return;
    }
    
    //애러메세지 받아오기
    String errMsg = request.getParameter("errMsg");
    

%>

<%
	
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	String customerName = request.getParameter("customerName");
	String customerBirth = request.getParameter("customerBirth");
	String customerGender = request.getParameter("customerGender");
	
	System.out.println(customerId + "<--customerId");
	System.out.println(customerPw + "<--customerPw");
	System.out.println(customerName + "<--customerName");
	System.out.println(customerBirth + "<--customerBirth");
	System.out.println(customerGender + "<--customerGender");
%>

<%	
	boolean checkId =CustomerDAO.addCustomerIdCheck(customerId);
	if(checkId == true){
		
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkId="+checkId);
		
	}

	int row = CustomerDAO.addCustomer(customerId, customerPw, customerName, customerBirth, customerGender);
	
	if(row>0) {
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
	} else {
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
	}
	
	
	


%>    

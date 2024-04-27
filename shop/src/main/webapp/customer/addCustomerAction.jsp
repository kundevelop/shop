<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="shop.dao.*"%>

<%
    //로그인 인증 분기 : 세션 변수 이름 - loginCustomer
    
    if(session.getAttribute("loginCustomer") !=null) {
        response.sendRedirect("/shop/customer/goodsList.jsp");
        return;
    }
	//request.setCharacterEncoding("utf-8");
    
    //애러메세지 받아오기
    String errMsg = request.getParameter("errMsg");
%>

<%
	
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	String customerName = request.getParameter("customerName");
	String customerBirth = request.getParameter("customerBirth");
	String customerGender = request.getParameter("customerGender");
	
	//디버깅
	System.out.println(customerId + "<--customerId");
	System.out.println(customerPw + "<--customerPw");
	System.out.println(customerName + "<--customerName");
	System.out.println(customerBirth + "<--customerBirth");
	System.out.println(customerGender + "<--customerGender");
	
%>


<%	
	
	boolean checkId = CustomerDAO.addCustomerIdCheck(customerId);
	System.out.println(checkId + "<---checkId");
	

	if(checkId == true){ //true면 아이디가 중복된것이기 때문에 회원가입 Form 으로 
		
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkId="+checkId);
		
	} else {
		int row = CustomerDAO.addCustomerId(customerId, customerPw, customerName, customerBirth, customerGender);
		if(row>0) {
			response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		} else {
			response.sendRedirect("/shop/customer/addCustomerForm.jsp");
		}
		
		
	}
	
	//sendRediraect 로 넘어가도 밑에 분기문은 동작함 그래서 else 문안에 입력하였음

	/*
	int row = CustomerDAO.addCustomerId(customerId, customerPw, customerName, customerBirth, customerGender);
	
	if(row>0) {
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
	} else {
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
	}
	*/

%>    

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
		
	//session.removeAttribute("loginMember"); 다른 정보가 들어갈수있음
    
    session.invalidate(); //세션 공간 초기화(포멧)
    
    //System.out.println(session.getId() + "<---- session.invalidate()");
    
	response.sendRedirect("/shop/customer/customerLoginForm.jsp");
%>

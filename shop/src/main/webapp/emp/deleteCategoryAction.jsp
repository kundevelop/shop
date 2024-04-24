<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>    
<%@ page import = "java.util.*" %>
<%@ page import = "shop.dao.*" %>
    
<%
    // 인증분기  : 세션변수 이름 - loginEmp
    if(session.getAttribute("loginEmp") == null) {
        response.sendRedirect("/shop/emp/empLoginForm.jsp");
        return;
    }
%>


<%
	String category= request.getParameter("category");
	String createDate= request.getParameter("createDate");
	
	// DAO 호출 
	int deletedRows = CategoryDAO.deleteCategory(category, createDate);
	
	//System.out.println(deletedRows + "<--deletedRows");
	
	
    if(deletedRows == 1) {
        System.out.println("삭제성공");
        response.sendRedirect("/shop/emp/categoryList.jsp");
    } else {
    	System.out.println("삭제실패");
    	response.sendRedirect("/shop/emp/categoryList.jsp");
    }


%>

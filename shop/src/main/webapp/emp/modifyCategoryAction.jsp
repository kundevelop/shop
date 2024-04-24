<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "shop.dao.*" %>
<!-- Controller Layer -->
<%
    // 인증분기  : 세션변수 이름 - loginEmp
    if(session.getAttribute("loginEmp") == null) {
        response.sendRedirect("/shop/emp/empLoginForm.jsp");
        return;
    }

    String category = request.getParameter("category");
    String modifyCategory = request.getParameter("modifyCategory");
%>

<%
	//DAO 호출
	int modifyCRows = CategoryDAO.modifyCategoryAction(modifyCategory, category);

    
    
    if(modifyCRows == 1) {
        System.out.println("카테고리 수정 완료");
		response.sendRedirect("/shop/emp/categoryList.jsp");
    
    } else {
    	System.out.println("카테고리 수정 실패");
    	response.sendRedirect("/shop/emp/categoryList.jsp");
    }

%>

   
   
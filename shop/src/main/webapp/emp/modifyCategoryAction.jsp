<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
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
    Connection conn = null;
    Class.forName("org.mariadb.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
    
    String sql = "UPDATE category SET category=? WHERE category=?";
    PreparedStatement stmt = null;
    ResultSet rs= null;
    
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, modifyCategory);
    stmt.setString(2, category);
    
    int row = stmt.executeUpdate();
    
    //System.out.println(row);

    
    
    if(row == 1) {
        System.out.println("카테고리 수정 완료");
		response.sendRedirect("/shop/emp/categoryList.jsp");
    
    } else {
    	System.out.println("카테고리 수정 실패");
    	response.sendRedirect("/shop/emp/categoryList.jsp");
    }

%>

   
   
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>    
<%@ page import = "java.util.*" %>

<%
    // 인증분기  : 세션변수 이름 - loginEmp
    if(session.getAttribute("loginEmp") == null) {
        response.sendRedirect("/shop/emp/empLoginForm.jsp");
        return;
    }
%>

<%
    int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
    Connection conn = null;
    Class.forName("org.mariadb.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    String sql= "DELETE FROM goods WHERE goods_no=?";
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, goodsNo);
    
    int row = stmt.executeUpdate();
    
    if(row == 1) {
        System.out.println("삭제성공");
        response.sendRedirect("/shop/emp/goodsList.jsp");
    } else {
    	System.out.println("삭제실패");
    	response.sendRedirect("/shop/emp/goodsList.jsp");
    }
    
    

%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "shop.dao.*" %>
    
<%
    //post로 넘겻으면 인코딩
    request.setCharacterEncoding("UTF-8");

    // 인증분기  : 세션변수 이름 - loginEmp
    if(session.getAttribute("loginEmp") == null) {
        response.sendRedirect("/shop/emp/empLoginForm.jsp");
        return;
    }
%>

<%
    String categoryadd = request.getParameter("categoryadd");

    System.out.println(categoryadd + "<----categoryadd");
    
    
    //DB연결(비빌번호 노출방지)
    Connection conn = DBHelper.getConnection();
	PreparedStatement stmt = null;

    String sql= "INSERT INTO category(category, create_date) VALUES(?,NOW())";
    stmt = conn. prepareStatement(sql);
    stmt.setString(1, categoryadd);
    
    int row = stmt.executeUpdate();
	if(row == 1) {
        
		System.out.println("입력성공");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	} else { 
		System.out.println("입력실패");
		response.sendRedirect("/shop/emp/categoryList.jsp");
        return;
	}
    
%>    

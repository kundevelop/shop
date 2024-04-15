<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import = "java.net.*"%>
<%@ page import = "shop.dao.*" %>
<%
    // 인증분기  : 세션변수 이름 - loginEmp
    if(session.getAttribute("loginEmp") == null) {
        response.sendRedirect("/shop/emp/empLoginForm.jsp");
        return;
    }
%>
<%
    //요청 분석
    String empId = request.getParameter("empId");
    String active = request.getParameter("active");
    
	if(active.equals("ON")){
		active = "OFF";
	} else {
		active = "ON";
	}
	
	String sql = null;
	sql = "update emp set active = ? where emp_id = ?";
    //DB연결(비빌번호 노출방지)
    Connection conn = DBHelper.getConnection();
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, active);
	stmt.setString(2, empId);
	System.out.println(stmt);
	int row = 0;
	row = stmt.executeUpdate();
	
	if(row == 1){
		//변경 성공
		System.out.println("변경 성공");
	} else {
		//변경 실패
		System.out.println("변경 실패");
	}
	
	response.sendRedirect("/shop/emp/empList.jsp");
%>

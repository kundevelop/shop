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
	} else  {
		active = "ON";
	}
	
	int modifyRows = EmpDAO.modifyEmpActive(active,empId);
	
	response.sendRedirect("/shop/emp/empList.jsp");
%>

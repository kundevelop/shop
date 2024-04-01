<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
    //로그인 인증 분기 : 세션 변수 이름 - loginEmp
    
    if(session.getAttribute("loginEmp") !=null) {
        response.sendRedirect("/shop/emp/empList.jsp");
        return;
    }
    
%>

<%
    String empId = null;
    String empPw = null;
	/*
	   select emp_id empId 
	   from emp
	   where active='ON' and emp_id =? and emp_pw = password(?) 
	*/
    
    empId = request.getParameter("empId");
    empPw = request.getParameter("empPw");
    
    Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
    String sql="SELECT emp_id empId FROM emp WHERE active='ON' AND emp_id =? AND emp_pw = password(?)";
    stmt1 = conn.prepareStatement(sql);
    stmt1.setString(1, "empId");
    stmt1.setString(2, "empPw");
    rs1= stmt1.executeQuery();		
   
    
    if(rs1.next()) {
        System.out.println("로그인 성공");
        response.sendRedirect("/shop/empList.jsp");
     
     
    } else {

        System.out.println("로그인 실패");
        String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인 해주세요", "utf-8");
	    response.sendRedirect("/shop/empLoginForm.jsp?errMsg="+errMsg);
   
    }
        
    
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 액션</title>
</head>
<body>
</body>
</html>
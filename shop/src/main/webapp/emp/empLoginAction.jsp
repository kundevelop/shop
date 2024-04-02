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
    System.out.println("empId:" + empId);
    empPw = request.getParameter("empPw");
    System.out.println("empPw:" + empPw);
    
    
    Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
    String sql="SELECT emp_id empId FROM emp WHERE active='ON' AND emp_id=? AND emp_pw= password(?)";
    stmt = conn.prepareStatement(sql);
    System.out.println(stmt);
    stmt.setString(1, empId); // stmt.setString(1, "empId"); 문자열로 값을 받아버리면 비교자체를 값을 받아서 안하기때문에 오류는 안뜨지만 로그인이 안된다
    stmt.setString(2, empPw);
    rs= stmt.executeQuery();		
   
    
    if(rs.next()) {
        System.out.println("로그인 성공");
        session.setAttribute("loginEmp", rs.getString("empId")); 
        response.sendRedirect("/shop/emp/empList.jsp");
     
     
    } else {
        System.out.println("로그인 실패");
        String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인 해주세요", "utf-8");
	    response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg="+errMsg);
   
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
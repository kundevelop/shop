<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
	//인증 분기  
	if(session.getAttribute("loginEmp")!= null){
		response.sendRedirect("/shop/emp/empList.jsp");
	}

	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
	
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	
	String sql = "SELECT emp_id empId, emp_name empName, grade FROM emp WHERE emp_id=? AND emp_pw = password(?)";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, empId);
	stmt.setString(2, empPw);
	rs = stmt.executeQuery();
	

	if(rs.next()){
		//로그인 성공시
		//하나의 세션변수안에 여러개의 값을 저장하기 위해서 HashMap타입을 사용
		HashMap<String, Object> loginEmp = new HashMap<String, Object>();
		loginEmp.put("empId",rs.getString("empId")); //로그인된 id
		loginEmp.put("empName",rs.getString("empName")); // 로그인된 name
		loginEmp.put("grade",rs.getInt("grade")); // 로그인된 grade
		
		session.setAttribute("loginEmp", loginEmp);
	
		response.sendRedirect("/shop/emp/empList.jsp");
	}else{
		//로그인 실패시 
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
	}
	
		//디버깅 (loginEmp 세션변수)	
		//HashMap<String, Object> m = (HashMap<String, Object>)session.getAttribute("loginEmp");
		//System.out.println((String) m.get("empId"));
		//System.out.println((String) m.get("empName"));
		//System.out.println((Integer) m.get("grade"));
%>    
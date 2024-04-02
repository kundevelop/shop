<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>


<!-- Controller Layer -->

<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<%
	// request 분석
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int startRow = (currentPage-1)*rowPerPage;
	// 화면에 표시할 직원리스트 개수 DB에서 가져오기
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String empCntSql = "SELECT COUNT(*) cnt FROM emp";
	PreparedStatement empCntStmt = null;
	ResultSet empCntRs = null;
	
	empCntStmt = conn.prepareStatement(empCntSql);
	empCntRs = empCntStmt.executeQuery();
	
	int empCnt = 0;
	while(empCntRs.next()){
		empCnt = empCntRs.getInt("cnt");
	}
	System.out.println("empCnt : " + empCnt);
	
	// 가장 마지막 페이지
	int lastPage = empCnt / rowPerPage;
	if(empCnt % rowPerPage != 0){
		lastPage = empCnt / rowPerPage + 1;
	}

%>

<!-- Model Layer -->

<%
	// 특수한 형태의 데이터(RDBMS:mariadb) 
	// -> API사용(JDBC API)하여 자료구조(ResultSet) 취득 
	// -> 일반화된 자료구조(ArrayList<HashMap>)로 변경 -> 모델 취득
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?, ?";
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, startRow);
	stmt.setInt(2, rowPerPage);
	rs = stmt.executeQuery(); 
	// JDBC API 종속된 자료구조 모델 ResultSet  -> 기본 API 자료구조(ArrayList)로 변경
	
	ArrayList<HashMap<String, Object>> list
		= new ArrayList<HashMap<String, Object>>();
	
	// ResultSet -> ArrayList<HashMap<String, Object>>
	while(rs.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("empId", rs.getString("empId"));
		m.put("empName", rs.getString("empName"));
		m.put("empJob", rs.getString("empJob"));
		m.put("hireDate", rs.getString("hireDate"));
		m.put("active", rs.getString("active"));
		list.add(m);// rs 행의수만큼 맵이 만들어지고 그것들이 리스트에 들어간다
	}
	// JDBC API 사용이 끝났다면 DB자원들을 반납
    empCntStmt.close();
    empCntRs.close();
                    
    rs.close();
    stmt.close();
                    
    conn.close();
%>

<!-- View Layer : 모델(ArrayList<HashMap<String, Object>>) 출력 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
	<h1>사원 목록</h1>
	<table border="1">
		<tr>
			<th>empId</th>
			<th>empName</th>
			<th>empJob</th>
			<th>hireDate</th>
			<th>active</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=(String)(m.get("empId"))%></td>
					<td><%=(String)(m.get("empName"))%></td>
					<td><%=(String)(m.get("empJob"))%></td>
					<td><%=(String)(m.get("hireDate"))%></td>
					<td>	
						<a href='modifyEmpActive.jsp?active=<%=(String)(m.get("active"))%>'>
							<%=(String)(m.get("active"))%>
						</a>
					</td>
				</tr>
		<%		
			}
		%>
	</table>
    
                    <div class="page">
                    <nav aria-label="Page navigation">
                      <ul class="pagination justify-content-center">
                      <%
                        if(currentPage > 1 && currentPage < lastPage){
                      %>
                            <li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=1">&laquo;</a></li>
                            <li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
                            <li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
                            <li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage+1%>">&rsaquo;</a></li>
                            <li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage%>">&raquo;</a></li>
                      <%
                        }else if(currentPage == 1){
                      %>
                            <li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
                            <li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage+1%>">&rsaquo;</a></li>
                            <li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage%>">&raquo;</a></li>
                      <%
                        }else if(currentPage == lastPage){
                      %>
                            <li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=1">&laquo;</a></li>
                            <li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
                            <li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
                      <%
                        }
                      %>
                        
                      </ul>
                    </nav>
                </div>
</body>
</html>
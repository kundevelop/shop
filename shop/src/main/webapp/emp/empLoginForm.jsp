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
    
    //애러메세지 받아오기
    String errMsg = request.getParameter("errMsg");
    

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
    <h1>로그인</h1>
    <form method="post" action="/shop/emp/empLoginAction.jsp">
    
        <div>
            
			<%
				if(errMsg != null) {
							
			%>
				<%=errMsg %>
			<%
					
				}
			%>	
				
		</div>
        <div>아이디:<input type="text" name="empId"></div> <br>
        <div>비밀번호:<input type="password" name="empPw"></div>
        <button type="submit">로그인</button>
        
        
    </form>
</body>
</html>
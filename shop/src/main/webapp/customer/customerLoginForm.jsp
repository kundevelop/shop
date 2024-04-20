<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
    //로그인 인증 분기 : 세션 변수 이름 - loginCustomer
    
    if(session.getAttribute("loginCustomer") !=null) {
        response.sendRedirect("/shop/customer/goodsList.jsp");
        return;
    }
    
    //애러메세지 받아오기
    String errMsg = request.getParameter("errMsg");
    

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 로그인</title>
</head>
<body>
	<h1>고객 로그인</h1>
	<form method = "post" action=/shop/customer/customerLoginAction.jsp>
	
	     <div>
            
			<%
				if(errMsg != null) {
							
			%>
				<%=errMsg %>
			<%
					
				}
			%>	
				
		</div>
        <div>아이디:<input type="text" name="customerId"></div> <br>
        <div>비밀번호:<input type="password" name="customerPw"></div>
        <button type="submit">로그인</button>
        <a href="/shop/customer/addCustomerForm.jsp">회원가입</a>
	
	
	
	</form>
</body>
</html>
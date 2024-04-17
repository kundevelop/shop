<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	
	<form method = "post" action="/shop/customer/addCustomerAction.jsp">
	
		<label for="cid">아이디</label>
		<input type="text" name = customerId id = cid>
		
		<label for="cpw">비밀번호</label>
		<input type="password" name = customerPw id = cpw>
		
		<label for="cname">이름</label>
		<input type="text" name = customerName id = cname>
		
		<label for="cbirth">생일</label>
		<input type="date" name = customerBirth id = cbirth>
		
		<label for="cgnder">성별</label>
		<select name="customerGender">
			<option value="">성별을 선택해주세요</option>
			<option value="남">남</option>
			<option value="여">여</option>
		</select>
		
	</form>

</body>
</html>
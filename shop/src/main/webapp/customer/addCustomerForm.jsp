<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
    //�α��� ���� �б� : ���� ���� �̸� - loginCustomer
    
    if(session.getAttribute("loginCustomer") !=null) {
        response.sendRedirect("/shop/customer/goodsList.jsp");
        return;
    }
    
    //�ַ��޼��� �޾ƿ���
    String errMsg = request.getParameter("errMsg");
    

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>ȸ������</h1>
	
	<form method = "post" action="/shop/customer/addCustomerAction.jsp">
	
		<label for="cid">���̵�</label>
		<input type="text" name = customerId id = cid>
		
		<label for="cpw">��й�ȣ</label>
		<input type="password" name = customerPw id = cpw>
		
		<label for="cname">�̸�</label>
		<input type="text" name = customerName id = cname>
		
		<label for="cbirth">����</label>
		<input type="date" name = customerBirth id = cbirth>
		
		<label for="cgnder">����</label>
		<select name="customerGender">
			<option value="">������ �������ּ���</option>
			<option value="��">��</option>
			<option value="��">��</option>
		</select>
		
	</form>

</body>
</html>
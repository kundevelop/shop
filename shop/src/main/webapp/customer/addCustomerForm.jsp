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
    
    String checkUserId = null;
    
    boolean checkId = Boolean.parseBoolean(request.getParameter("checkId"));
    
    System.out.println(checkId + "<---checkId");
    
    if(checkId == true) {
    	checkUserId = "�̹� �ִ� ���̵� �Դϴ�.";
    }

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
		<table>
			<tr>
			
				<td>
					<label for="cid">���̵�</label>
					<input type="text" name = customerId id = cid>
				</td>
			</tr>
			
			<tr>
				<td>
					<label for="cpw">��й�ȣ</label>
					<input type="password" name = customerPw id = cpw>
				</td>
			
			<tr>
			
			<tr>
				<td>
					<label for="cname">�̸�</label>
					<input type="text" name = customerName id = cname>
				
				</td>
			
			<tr>
			
			<tr>
				<td>
					<label for="cbirth">����</label>
					<input type="date" name = customerBirth id = cbirth>
				</td>
			
			<tr>
			
			<tr>
				<td>
					<label for="cgnder">����</label>
					<select name="customerGender">
						<option value="">������ �������ּ���</option>
						<option value="��">��</option>
						<option value="��">��</option>
					</select>
				</td>
			
			<tr>
			
			<tr>
				<td>
					<%
						 if(checkId == true) {
					%>
						<%=checkUserId%>
						
					<%
						 }
					
					%>
					
				</td>
		
			<tr>
			
		</table>
		
		<button type = "submit">ȸ������</button>
		
	</form>

</body>
</html>
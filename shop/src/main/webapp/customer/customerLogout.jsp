<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
		
	//session.removeAttribute("loginMember"); �ٸ� ������ ��������
    
    session.invalidate(); //���� ���� �ʱ�ȭ(����)
    
    //System.out.println(session.getId() + "<---- session.invalidate()");
    
	response.sendRedirect("/shop/customer/customerLoginForm.jsp");
%>

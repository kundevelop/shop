<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<% 
    //로그인 인증 분기 : 세션 변수 이름 - loginCustomer
    
    if(session.getAttribute("loginCustomer") !=null) {
        response.sendRedirect("/shop/customer/goodsCList.jsp");
        return;
    }

%>
<head>
    <style>
        a {
            text-decoration-line: none;
        }
        
    </style>
</head>



<div>
    <a href="/shop/customer/customerLogout.jsp">로그아웃</a>

    
</div>

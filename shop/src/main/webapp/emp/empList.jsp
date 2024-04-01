<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //로그인 인증 분기 : 세션 변수 이름 - loginEmp
    
    if(session.getAttribute("loginEmp") ==null) {
        response.sendRedirect("/shop/emp/empList.jsp");
        return;
    }
    
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>emp 리스트</title>
</head>
<body>
    <h1>사원 목록</h1>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- Controller Layer -->
<%
    // 인증분기  : 세션변수 이름 - loginEmp
    if(session.getAttribute("loginEmp") == null) {
        response.sendRedirect("/shop/emp/empLoginForm.jsp");
        return;
    }
%>

<%
    String category = request.getParameter("category");

    //System.out.println(category +"<---category")
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Grandiflora+One&display=swap');
    </style>
    <style>
        .font{
            font-family:"Grandiflora One", cursive;
            font-weight: bold;
            font-optical-sizing: auto;
            font-style: normal;
        }
        
          #imgDiv {
            max-width: 50%;
            max-height: 50%;
        } 
        
    </style>
</head>
<body>
    <!-- 메인메뉴 -->
    <div>
        <jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
    </div>
    <h1>카테고리 수정하기</h1>
    <form method="post" action="/shop/emp/modifyCategoryAction.jsp?category=<%=category%>">
        <div>기존 카테고리 이름:<%=category%></div>
        <label>변경할 카테고리 이름:</label>
        <input type="text" name="modifyCategory" value="<%=category != null ? category : null%>"> 
        <button type="submit">수정하기</button>
    

    </form>


</body>
</html>
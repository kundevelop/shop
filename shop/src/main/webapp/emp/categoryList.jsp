<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "shop.dao.*" %>
    
<!-- Controller Layer -->

<%
    // 인증분기  : 세션변수 이름 - loginEmp
    if(session.getAttribute("loginEmp") == null) {
        response.sendRedirect("/shop/emp/empLoginForm.jsp");
        return;
    }

	
%>

<!-- model layer -->
<%
	//DAO 호출
	ArrayList<HashMap<String, Object>> categoryList= CategoryDAO.CntCategory();
		
    
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
        a {
            text-decoration-line: none;
        }
    </style>
</head>
<body class="font">
        <h1 style="text-align: center">카테고리 관리</h1>
        <!-- 메인메뉴 -->
        <div>
            <jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
        </div>
        <div>
            <%
                for(HashMap list : categoryList){
            %>  
                <div>
                    <div>제목 :<%=(String)list.get("category")%></div>
                    <div>작성일 :<%=(String)list.get("createDate")%></div>
                    <div>
                        <a  href="/shop/emp/modifyCategoryForm.jsp?category=<%=(String)list.get("category")%>">수정</a>
                        <a  href="/shop/emp/deleteCategoryAction.jsp?category=<%=(String)list.get("category")%>&createDate=<%=(String)list.get("createDate")%>">삭제</a>
                    </div>
                </div>
                <hr>
            <%
                }
            %>
            <div>
                
                <div>
                	
                    <a href="/shop/emp/addCategoryForm.jsp">카테고리 추가</a>
                </div>
            </div>
        </div>
</body>
</html>
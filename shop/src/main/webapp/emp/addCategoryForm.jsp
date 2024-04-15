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

<!-- Model Layer -->
<%
    //DB연결(비빌번호 노출방지)
    Connection conn = DBHelper.getConnection();
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    
    String sql = "SELECT category FROM category";
    stmt = conn.prepareStatement(sql);
    rs = stmt.executeQuery();
    ArrayList<String> cate = new ArrayList<String>();
    
    while (rs.next()) {
    	cate.add(rs.getString("category"));    
    }
    //디버깅
    //System.out.println(cate);


%>    
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
    <!-- 메인메뉴 -->
    <div>
        <jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
    </div>
    
    <h1>카테고리 추가</h1>
    <form method = "post" action="/shop/emp/addCategoryAction.jsp">
        <div>
            <label for = "categoryadd">카테고리 이름:</label>
            <input type = "text" name= "categoryadd" id ="categoryadd">
        </div>
    <div>
    
        <button type="submit">추가하기</button>
    </div>
    
    
    
    </form>
</body>
</html>
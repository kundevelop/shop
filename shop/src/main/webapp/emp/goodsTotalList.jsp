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

<%
    /* 페이징 */
    int currentPage = 1;
    if(request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }
    
    
    int rowPerPage = 10; //한페이지에 보여주는 갯수
    int startRow = (currentPage-1)*rowPerPage;
    
    
    //DB연결(비빌번호 노출방지)
    Connection conn = DBHelper.getConnection();
    
    
    // 가장 마지막 페이지
    String pageSql = "SELECT COUNT(*) AS cnt FROM goods";
    
    PreparedStatement  pageStmt = null;
    ResultSet  pageRs = null;
    
    pageStmt = conn.prepareStatement( pageSql);
    pageRs =  pageStmt.executeQuery();
    
    int totalRow = 0;
    while( pageRs.next()){
    	 totalRow =  pageRs.getInt("cnt");
    }
    System.out.println("totalRow : " + totalRow);
    
    int lastPage = totalRow / rowPerPage;
    if(totalRow % rowPerPage != 0){
        lastPage = lastPage + 1;
    }   
    
    /*  
        null이면 SELECT * FROM goods
        null이 아니면 SELECT * FROM goods WHERE category=?

    */

    // request 분석
    String category = request.getParameter("category");
    System.out.println("category :" + category);
    
    if(category == null) {
        category = "";
        
    }
%>

<!-- Model Layer -->

<%
    // 특수한 형태의 데이터(RDBMS:mariadb) 
    // -> API사용(JDBC API)하여 자료구조(ResultSet) 취득 
    // -> 일반화된 자료구조(ArrayList<HashMap>)로 변경 -> 모델 취득
    
    /*
    String sql = "select category, 
    goods_title AS goodsTitle, 
    goods_price AS goodsPrice, 
    goods_amount AS goodsAmount,  
    from goods 
    order by category asc 
    limit ?,?";
    */

    PreparedStatement stmt = null;
    ResultSet rs = null;
    String sql = "select category, goods_title AS goodsTitle, goods_price AS goodsPrice, goods_amount AS goodsAmount from goods order by category asc limit ?,?";
    stmt = conn.prepareStatement(sql);
    stmt. setInt(1, startRow);
    stmt. setInt(2, rowPerPage);
    rs = stmt.executeQuery(); 
    
    ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		
		m.put("category", rs.getString("category"));
		m.put("goodsTitle", rs.getString("goodsTitle"));
		
		m.put("goodsPrice", rs.getString("goodsPrice"));
		m.put("goodsAmount", rs.getString("goodsAmount"));
		categoryList.add(m);
	}
	// 디버깅
	System.out.println(categoryList);
    
    //자원 반납
    pageStmt.close();
    pageRs.close();
    
    rs.close();
    stmt.close();
    
    conn.close();
 %>
 



<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>goodList</title>
            <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Grandiflora+One&display=swap');
    </style>
    <style>
        .container{
            font-family:"Grandiflora One", cursive;
            font-weight: bold;
            font-optical-sizing: auto;
            font-style: normal;
        }
    
        .main{
            text-align: center;
        }
        
        .table{
            text-align: center;
            width: 700px;
            margin-left: 80px;
            
            
        }
        
        a{
            text-decoration: none;
        }
        
        a.page-link{
            color: #000000;
        }
        
        a.page-link:hover{
            background-color: #000000;
            color: #FFFFFF;
        }
    </style>
</head>
<body>
 <!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<div>
		<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>	
	</div>

	<!-- 서브메뉴 카테고리별 상품리스트 -->
	
		<a href="/shop/emp/goodsList.jsp">뒤로가기</a>
        <div class="container">
        <div class="row">
        <div class="col"></div>
        <div class="main col-8">
        <h1>전체 상품보기</h1>
        <table class="table table-hover" border="1" >
        
        
            <tr>
                
                <th>애니제목</th>
                <th>굿즈이름</th>
                <th>굿즈가격</th>
                <th>남은양</th>
            
            </tr>
		<%
			for(HashMap<String, Object> m : categoryList) {
		%>
            <tr>
                <td>
    				<a href="/shop/emp/goodsTotalList.jsp?category=<%=(String)(m.get("category"))%>">
    					<%=(String)(m.get("category"))%>
    					
    				</a>
                </td>
                
                <td><%=(String)(m.get("goodsTitle"))%></td>
                <td><%=(String)(m.get("goodsPrice"))%></td>
                <td><%=(String)(m.get("goodsAmount"))%></td>
                
            </tr>	
		<%		
			}
		%>
        </table>
	
    
    <!-- 굿즈 리스트  -->
    <div class="page">
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <%
                    if (currentPage > 1 && currentPage < lastPage) {
                %>
                    <li class="page-item"><a class="page-link"
                        href="/shop/emp/goodsTotalList.jsp?currentPage=1">&laquo;</a></li>
                    <li class="page-item"><a class="page-link"
                        href="/shop/emp/goodsTotalList.jsp?currentPage=<%=currentPage - 1%>">&lsaquo;</a></li>
                    <li class="page-item"><a class="page-link"
                        href="/shop/emp/goodsTotalList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
                    <li class="page-item"><a class="page-link"
                        href="/shop/emp/goodsTotalList.jsp?currentPage=<%=currentPage + 1%>">&rsaquo;</a></li>
                    <li class="page-item"><a class="page-link"
                        href="/shop/emp/goodsTotalList.jsp?currentPage=<%=lastPage%>">&raquo;</a></li>
                <%
                    } else if (currentPage == 1) {
                %>
                    <li class="page-item"><a class="page-link"
                        href="/shop/emp/goodsTotalList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
                    <li class="page-item"><a class="page-link"
                        href="/shop/emp/goodsTotalList.jsp?currentPage=<%=currentPage + 1%>">&rsaquo;</a></li>
                    <li class="page-item"><a class="page-link"
                        href="/shop/emp/goodsTotalList.jsp?currentPage=<%=lastPage%>">&raquo;</a></li>
                <%
                    } else if (currentPage == lastPage) {
                %>
                    <li class="page-item"><a class="page-link"
                        href="/shop/emp/goodsTotalList.jsp?currentPage=1">&laquo;</a></li>
                    <li class="page-item"><a class="page-link"
                        href="/shop/emp/goodsTotalList.jsp?currentPage=<%=currentPage - 1%>">&lsaquo;</a></li>
                    <li class="page-item"><a class="page-link"
                        href="/shop/emp/goodsTotalList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
                <%
                    }
                %>

            </ul>
        </nav>
    </div>
    <!-- 굿즈 리스트 끝 -->
    
    </div>
    <div class="col"></div>
    </div>
    </div>


</body>
</html>

<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>    
<%@ page import = "java.util.*" %>
<%@ page import = "shop.dao.*" %>

<%     
	//로그인 인증 분기 : 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") == null) { //null 이면 로그인이 안된상태 이므로 로그인폼으로 돌아감
	    response.sendRedirect("/shop/customer/customerLoginForm.jsp");
	    return;
	}
	
	//애러메세지 받아오기
	String errMsg = request.getParameter("errMsg");

%>    

<%
 	// 페이징 1 
 	// 페이지 출력 할 개수 설정, 검색할 테이블 행의 index 값 설정 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String category = request.getParameter("category"); // null이면 전체 출력 , null이 아니면 특정 카테고리만 출력 
	
	int rowPerPage = 10; // 페이지 출력 데이터 수
	
	// 검색을 시작할 행의 인덱스를 나타내는 변수 
	// startRow > SQL limit
	int startRow = (currentPage-1)*rowPerPage; 
	
%>
 
<!-- Model Layer -->

<%
	//DB연결(비빌번호 노출방지)
    Connection conn = DBHelper.getConnection();
	
	// 카테고리 sql
    ArrayList<HashMap<String, Object>> categoryList= GoodsDAO.selectCategoryList();
    
    ArrayList<HashMap<String, Object>> goodslist= GoodsDAO.selectGoodsList(category, startRow, rowPerPage);

		
        String sql3 = "SELECT COUNT(*) cnt FROM goods WHERE category LIKE ?";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setString(1, "%"+category+"%");
		ResultSet rs3 = stmt3.executeQuery();
        
        
		// 행 개수 담을 변수
        
		int totalRow = 0;
		if(rs3.next()) {
			totalRow = rs3.getInt("cnt");
		}
		
		
		// 총 페이지 수 
		int lastPage = totalRow / rowPerPage; // 전체 행 개수 / 한 페이지 출력 수 
		if(totalRow % rowPerPage !=0) {
			// 페이지 출력 된 데이터 행의 개수가 20씩 떨어지지 않으면 다음 페이지 생성
			lastPage = lastPage+1; 
		}
        
		
%> 
    
<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 리스트</title>
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
        
          #imgDiv {
            max-width: 50%;
            max-height: 50%;
        } 
        
    </style>
</head>
<body class="font">
	<!-- 메인 메뉴 -->

	<a href="/shop/customer/customerLogout.jsp">로그아웃</a>

	
	<!-- 서브 메뉴 카테고리별 상품리스트 -->
	<div>
		<a href="/shop/emp/goodsTotalList.jsp">전체</a>
		<%
			for(HashMap m : categoryList) {
		%>
				<a href="/shop/customer/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
					<%=(String) (m.get("category")) %>
					(<%=(Integer) (m.get("cnt"))%>)
				</a>	
		<%
			}
		%>
	</div>
	
	<!-- 상품 리스트 -->
	<div style="display: flex; flex-wrap: wrap;">
		<%
			for(HashMap<String, Object> m2 : goodslist) {
		%>
			<div style="width: 300px; margin: 10px; border: 1px solid #ccc; padding: 10px;">	
                <div >
                    <img alt="이미지" id="imgDiv" src="/shop/upload/<%=(String)(m2.get("filename"))%>">
                </div>  
                
				<div>
					상품번호:<%=(Integer)m2.get("goodsNo") %>
				</div>
                
				<div>
					카테고리:<%=(String)m2.get("category") %>
				</div>	
				<div>
					제목:<%=(String)m2.get("goodsTitle") %>
				</div>
                
                <div>
                    가격:<%=(Integer)m2.get("goodsPrice") %>
                </div>
                
                <div>
                    수량:<%=(Integer)m2.get("goodsAmount") %>
                </div>
                <div>
                    <a href = "">수정</a>
                    <a href = "deleteGoodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">삭제</a>
                    
                </div>
			</div>		
		<%
			}
		%>
	</div>
	
	<!-- 페이지 -->
	<div>
		<%
			if(currentPage > 1) {
 		%>
 				<a href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">이전</a>
 		<%
			}
		%>
		
		<%
			if(currentPage < lastPage) {
		%>
				<a href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">다음</a>
		<%
			}
		%>
	</div>
	
</body>
</html>
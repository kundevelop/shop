<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>    
<%@ page import = "java.util.*" %>

<%     
		if(session.getAttribute("loginEmp") == null) {
			response.sendRedirect("/shop/emp/empLoginForm.jsp");
			return;
		}
%>    

<%
 	// 페이징 1 
 	// 페이지 출력 할 개수 설정, 검색할 테이블 행의 index 값 설정 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String category = request.getParameter("category"); // null이면 전체 출력 , null이 아니면 특정 카테고리만 출력 
	
	int rowPerPage = 12; // 페이지 출력 데이터 수
	
	// 검색을 시작할 행의 인덱스를 나타내는 변수 
	// startRow > SQL limit
	int startRow = (currentPage-1)*rowPerPage; 
	
%>
 
<!-- Model Layer -->

<%
	// JDBC 드라이버
	Class.forName("org.mariadb.jdbc.Driver");	
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	// 카테고리 sql
	String sql = "select category, count(*) AS cnt from goods group by category order by category";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>(); 
	// 카테고리 리스트 
	while(rs.next()) {

		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("category", rs.getString("category"));
		m.put("cnt", rs.getInt("cnt"));
		categoryList.add(m);
	}
	// 카테고리 리스트 디버깅
	System.out.println("categoryList:" + categoryList);
	
	
	// 상품 리스트
	// list 배열안에 hashmap 형식으로 저장

	String sql2 = "SELECT * FROM goods where category LIKE ? ORDER BY update_date desc limit ?, ?";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, "%"+category+"%"); // %나루토%
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	
	ResultSet rs2 = stmt2.executeQuery();
	
	ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		while(rs2.next()) {
	
		
			// <> 파라미터 생략 가능
			HashMap<String, Object> m2 = new HashMap<>();
				m2.put("goodsNo", rs2.getInt("goods_no"));
				m2.put("category", rs2.getString("category"));
				m2.put("empId", rs2.getString("emp_id"));
                m2.put("filename", rs2.getString("filename"));
				m2.put("goodsTitle", rs2.getString("goods_title"));
				m2.put("goodsContent", rs2.getString("goods_content"));
				m2.put("goodsPrice", rs2.getInt("goods_price"));
				m2.put("goodsAmount", rs2.getInt("goods_amount"));
				m2.put("updateDate", rs2.getString("update_date"));
				// HaspMap타입을 list 형식에 저장 
				goodsList.add(m2);
		}
		
		// 페이징2 페이지 목록 수 계산
		// 특정 카테고리 데이터 행 개수
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
<title>Insert title here</title>
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
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<div>
		<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>
	</div>
	
	<!-- 서브 메뉴 카테고리별 상품리스트 -->
	<div>
		<a href="/shop/emp/goodsTotalList.jsp">전체</a>
		<%
			for(HashMap m : categoryList) {
		%>
				<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
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
			for(HashMap<String, Object> m2 : goodsList) {
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
 				<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">이전</a>
 		<%
			}
		%>
		
		<%
			if(currentPage < lastPage) {
		%>
				<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">다음</a>
		<%
			}
		%>
	</div>
	
</body>
</html>
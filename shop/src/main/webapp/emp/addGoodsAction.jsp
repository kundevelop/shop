<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
    //post로 넘겻으면 인코딩
    request.setCharacterEncoding("UTF-8");

    // 인증분기  : 세션변수 이름 - loginEmp
    if(session.getAttribute("loginEmp") == null) {
        response.sendRedirect("/shop/emp/empLoginForm.jsp");
        return;
    }
%>

<%
    /* session 설정값 : 입력시 로그인 emp의 emp_id값이 필요해서.. */
        HashMap<String,Object> loginMember 
        = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
        System.out.println((String)(loginMember.get("empId"))+"아이디정보 addGoodsAction.jsp");
%>
    
<%
    //1. 요청 분석
    
    String goodsTitle = request.getParameter("goodsTitle");
    int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
    int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
    String goodsContent = request.getParameter("goodsContent");
    
    
    //디버깅
    System.out.println(goodsTitle + "<------goodsTitle");
    System.out.println(goodsPrice + "<------goodsPrice");
    System.out.println(goodsAmount + "<------goodsAmount");
    System.out.println(goodsContent + "<------goodsContent");
    
    
    //2. 비지니스 코드
    
    String addsql = "INSERT INTO goods(category, emp_id, goods_title, goods_content, goods_price,goods_amount) VALUES()";
    Class.forName("org.mariadb.jdbc.Driver");
    
	//자원초기화
	Connection conn = null;
	PreparedStatement stmt = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
    
	System.out.println(stmt);
	
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("입력성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	} else {
		System.out.println("입력실패");
	}

	// 3. 목록(addDiaryForm.jsp)을 재요청(redirect) 하게 한다
	response.sendRedirect("/shop/emp/addGoodsForm.jsp");


%>
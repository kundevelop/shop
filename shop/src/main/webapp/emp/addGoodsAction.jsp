<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import = "shop.dao.*" %>

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
        
%>
    
<%
    //1. 요청 분석
    
    String category = request.getParameter("category");
    String goodsTitle = request.getParameter("goodsTitle");
    int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));  
    String goodsContent = request.getParameter("goodsContent");
    int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
    
    
    Part part = request.getPart("goodsImg");
    String originalName = part.getSubmittedFileName();
    
    // 원본이름에서 확장자만 분리
    int dotIdx = originalName.lastIndexOf(".");
    String ext = originalName.substring(dotIdx); // . png
    
    System.out.println(dotIdx + "<------dotIdx");
            
    UUID uuid = UUID.randomUUID();
    String filename = uuid.toString().replace("-", "");
    filename = filename + ext;
    
    //디버깅
    System.out.println(category + "<------category");
    System.out.println(goodsTitle + "<------goodsTitle");
    System.out.println(filename + "<------filename");
    System.out.println(goodsPrice + "<------goodsPrice");
    System.out.println(goodsAmount + "<------goodsAmount");
    System.out.println(goodsContent + "<------goodsContent");
    
    
    //2. 비지니스 코드
    
    String addsql = "INSERT INTO goods(category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date, create_date) VALUES(?, ?, ?, ?, ?, ?, ?, NOW(),NOW())";
    Class.forName("org.mariadb.jdbc.Driver");
    
    //DB연결(비빌번호 노출방지)
    Connection conn = DBHelper.getConnection();
	PreparedStatement stmt = null;
	
    
	stmt = conn.prepareStatement(addsql);	
	stmt.setString(1,category);
	stmt.setString(2,(String)loginMember.get("empId"));
	stmt.setString(3,goodsTitle);
	stmt.setString(4,filename);
	stmt.setString(5,goodsContent);
	stmt.setInt(6,goodsPrice);
	stmt.setInt(7,goodsAmount);
    
    
    
	System.out.println(stmt);
	
	int row = stmt.executeUpdate();
	
	if(row == 1) {
    	 //insert 성공하면 파일 업로드
        //part => 1)is => 2)os => 3)빈파일
        // 1)
        InputStream is = part.getInputStream();
        // 3)+2)
        String filePath = request.getServletContext().getRealPath("upload");
        File f = new File(filePath, filename);// 빈파일
        OutputStream os = Files.newOutputStream(f.toPath()); // os + file 
        is.transferTo(os);
        
        os.close();
        is.close();
	}
    
%>
    
<%
	if(row == 1) {
        
		System.out.println("입력성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	} else { 
		System.out.println("입력실패");
		response.sendRedirect("/shop/emp/addGoodsForm.jsp");
        return;
	}
    /*
        File f = new File(filePath, rs.getString(filename))
        df.delete()
    */

%>
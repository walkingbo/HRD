<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	//파라미터 인코딩 설정 
 	request.setCharacterEncoding("utf-8");
 	//전송된 파라미터 읽기 
 	String custno = request.getParameter("custno");
 	String custname = request.getParameter("custname");
 	String phone = request.getParameter("phone");
 	String address = request.getParameter("address");
 	String joindate = request.getParameter("joindate");
 	String grade = request.getParameter("grade");
 	String city = request.getParameter("city");
 	
 	
 	
 	//앞의 숫자 4개를 가져와서 년도 4자리 정수만들기 
 	int year1 = Integer.parseInt(joindate.substring(0,4));
 	int month1 = Integer.parseInt(joindate.substring(5,7));
 	int day1 = Integer.parseInt(joindate.substring(8));
 	java.sql.Date updatedate1 = new java.sql.Date(year1-1900,month1-1,day1);
 	
 	/*
 	//년 4자리 가져 오기 
 	String year = joindate.substring(0,4);
 	//월 2자리 가져오기 
 	String month = joindate.substring(5,7);
 	//일 2자리 가져오기 
 	String day = joindate.substring(8);
 	
 	//입력한 날짜를 가지고 Date 객체 만들기 
 	Calendar cal = new GregorianCalendar(Integer.parseInt(year),Integer.parseInt(month)-1,Integer.parseInt(day));
 	java.sql.Date registerDate = new java.sql.Date(cal.getTimeInMillis());
 	*/
 	
 	//데이터 베이스 접속 
 	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection(
			"jdbc:oracle:thin:@192.168.0.100:1521/xe",
			"user12","user12");
	//SQL 만들기 
	PreparedStatement pstmt = con.prepareStatement(
			"update member_tbl_02 set custname=?,phone=?,address=?,joindate=?,grade=?,city=? where custno=?");
 	//물음표에 값 바인딩
 	pstmt.setString(1,custname);
 	pstmt.setString(2,phone);
 	pstmt.setString(3,address);
 	pstmt.setDate(4, updatedate1);
 	pstmt.setString(5,grade);
 	pstmt.setString(6,city);
 	pstmt.setInt(7,Integer.parseInt(custno));
	//SQL 실행
	pstmt.executeUpdate();
 	
	pstmt.close();
	con.close();
	
 %>   

<body>

</body>

</html>
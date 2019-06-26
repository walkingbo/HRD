<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
//custno를 이용해서 데이터 찾아오기 
int custno = Integer.parseInt(request.getParameter("custno"));
//데이터베이스 연결 코드 
Class.forName("oracle.jdbc.OracleDriver");
Connection con = DriverManager.getConnection(
		"jdbc:oracle:thin:@192.168.0.100:1521/xe",
		"user12","user12");
//입력 받아야 하는 항목이 있으면 ?로 작성 
PreparedStatement pstmt = con.prepareStatement(
		"select  * from member_tbl_02 where custno=?");
	pstmt.setInt(1,custno);
	//SQL실행 
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	String custname = rs.getString("custname");
	String phone = rs.getString("phone");
	String address = rs.getString("address");
	Date joindate = rs.getDate("joindate");
	String grade = rs.getString("grade");
	String city = rs.getString("city");
	
	rs.close();
	pstmt.close();
	con.close();
%>
<body>
<h2 align="center">홈쇼핑 회원 정보 수</h2>
	<form action="update.jsp" id="updateform">
		<table align="center" border="1">
			<tr>
				<td align="center">회원번호(자동발생)</td>
				<td><input type="text" name="custno" id="custno" value="<%=custno%>" readonly="readonly"/></td>
			</tr>
			<tr>
				<td align="center">회원성명</td>
				<td><input type="text" name="custname" id="custname" value="<%=custname%>"/></td>
			</tr>
			<tr>
				<td align="center">회원전화</td>
				<td><input type="text" name="phone" id="phone" size="30" value="<%=phone%>"/></td>
			</tr>
			<tr>
				<td align="center">회원주소</td>
				<td><input type="text" name="address" id="address" size="50" value="<%=address%>"/></td>
			</tr>
			<tr>
				<td align="center">가입일자</td>
				<td><input type="text" name="joindate" id="joindate" value="<%=joindate %>" readonly="readonly"/></td>
			</tr>
			<tr>
				<td align="center">고객등급[A:VIP,B:일반,C:직원]</td>
				<td><input type="text" name="grade" id="grade" value="<%=grade%>"/></td>
			</tr>
			<tr>
				<td align="center">도시코드</td>
				<td><input type="text" name="city" id="city" value="<%=city%>"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="수정" id="updatebtn"/>
				<input type="button" value="조회" id="searchbtn"/>
				</td>
			</tr>
		</table>
	
	</form>
	
	
	<script>
	document.getElementById("searchbtn").addEventListener("click",function(e){
		location.href="list.jsp"
	})
	document.getElementById("updatebtn").addEventListener("click",function(e){
		
			var custno = document.getElementById("custno")
			var custname = document.getElementById("custname")
			var phone = document.getElementById("phone")
			var address = document.getElementById("address")
			var joindate = document.getElementById("joindate")
			var grade = document.getElementById("grade")
			var city = document.getElementById("city")
		
			//폼의 데이터를 가지고 update.jsp 파일에 ajax 요청
			//ajax 객체 생성 
			var request = new XMLHttpRequest();
			//전송할 URL을 생성
			var url = "update.jsp?"
			//URL에 파라미터 붙이기 
			url += "custno=" + custno.value;
			url += "&custname=" + custname.value;
			url += "&phone=" + phone.value;
			url += "&address=" + address.value;
			url += "&joindate=" + joindate.value;
			url += "&grade=" + grade.value;
			url += "&city=" + city.value;
		
			//ajax 요청을 생성 
			request.open('GET',encodeURI(url))
			request.send('')
			
			//요청에 성공했을 때 수행할 내용 작성
			request.onreadystatechange = function(){
				if(request.readyState ==4){
					alert("회원정보수정이 완료되었습니다.")
				}
			}
			
		});
	
	</script>
</body>
</html>
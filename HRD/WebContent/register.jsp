<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection(
			"jdbc:oracle:thin:@192.168.0.100:1521/xe",
			"user12","user12");
	//입력 받아야 하는 항목이 있으면 ?로 작성 
	PreparedStatement pstmt = con.prepareStatement(
			"select max(custno) from member_tbl_02");
	//?가 있으면 물음표를 채우기
	//select 구문은 ResultSet으로 받아야하고 
	//나머지는 정수로 받으면 됩니다.
	//실행할 때 select는 executeQuery()
	//나머지는 executeUpdate()
	ResultSet rs = pstmt.executeQuery();
	//결과를 저장할 변수 
	int maxno =-1;
	//가장 큰 글번호 찾기
	if(rs.next()){
		maxno=rs.getInt("max(custno)");
	}
	//마직막 번호 + 1
	maxno = maxno +1 ;
	
	//현재 날짜 가져 오기 
	java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
	//toString을 호출하면 yyyy-MM-DD형식의 문자열로 리턴 
	String disp = today.toString();
	//-를 ""으로 변환 
	disp= disp.replace("-", "");
	
	
%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2 align="center">홈쇼핑 회원 등록</h2>
	<form action="insert.jsp" id="registerform">
		<table align="center" border="1">
			<tr>
				<td align="center">회원번호(자동발생)</td>
				<td><input type="text" name="custno" id="custno" value="<%=maxno%>" readonly="readonly"/></td>
			</tr>
			<tr>
				<td align="center">회원성명</td>
				<td><input type="text" name="custname" id="custname"/></td>
			</tr>
			<tr>
				<td align="center">회원전화</td>
				<td><input type="text" name="phone" id="phone" size="30"/></td>
			</tr>
			<tr>
				<td align="center">회원주소</td>
				<td><input type="text" name="address" id="address" size="50"/></td>
			</tr>
			<tr>
				<td align="center">가입일자</td>
				<td><input type="text" name="joindate" id="joindate" value="<%=disp %>"/></td>
			</tr>
			<tr>
				<td align="center">고객등급[A:VIP,B:일반,C:직원]</td>
				<td><input type="text" name="grade" id="grade"/></td>
			</tr>
			<tr>
				<td align="center">도시코드</td>
				<td><input type="text" name="city" id="city"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="등록" id="registerbtn"/>
				<input type="button" value="조회" id="searchbtn"/>
				</td>
			</tr>
		</table>
	
	</form>
</body>
<script>
	document.getElementById("registerbtn").addEventListener("click",function(e){
		var custname = document.getElementById("custname")
		if(custname.value.trim().length == 0){
			alert("회원명이 입력되지 않았습니다.")
			custname.focus()
			return;
		}
		
		var phone = document.getElementById("phone")
		if(phone.value.trim().length == 0){
			alert("전화번호가 입력되지 않았습니다.")
			phone.focus()
			return;
		}
		
		var address = document.getElementById("address")
		if(address.value.trim().length == 0){
			alert("회원주소가 입력되지 않았습니다.")
			address.focus()
			return;
		}
		
		var grade = document.getElementById("grade")
		if(grade.value.trim().length == 0){
			alert("회원등급이 입력되지 않았습니다.")
			grade.focus()
			return;
		}else if(grade.value != 'A' && grade.value != 'B' && grade.value != 'C' ){
			alert("회원등급은 A,B,C로 만 입력할 수 있습니다.")
			grade.focus()
			return;
		}
		
		var city = document.getElementById("city")
		if(city.value.trim().length == 0){
			alert("도시가 입력되지 않았습니다.")
			city.focus()
			return;
		}
		
		//폼의 데이터 전송
		//document.getElementById("registerform").submit();
		
		//폼의 데이터를 가지고 insert.jsp 파일에 ajax 요청
		//ajax 객체 생성 
		var request = new XMLHttpRequest();
		//전송할 URL을 생성
		var url = "insert.jsp?"
		//URL에 파라미터 붙이기 
		url += "custno=" + document.getElementById("custno").value;
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
				alert("회원등록이 완료되었습니다.")
			}
		}
		
	});
	//조회 버튼을클릭하면 
	document.getElementById("searchbtn").addEventListener("click",function(e){
		//페이지 이동 
		location.href="list.jsp"
	});
</script>

</html>
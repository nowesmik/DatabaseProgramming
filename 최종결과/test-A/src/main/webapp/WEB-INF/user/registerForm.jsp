<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
   function userCreate(){
      if(form.email.value == "") {
         alert("이메일을 입력하십시오.");
         form.email.focus();
         return false;
      }
      var emailExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
      if(emailExp.test(form.email.value)==false) {
         alert("이메일 형식이 올바르지 않습니다.");
         form.email.focus();
         return false;
      }
      if(form.password.value == "") {
         
         alert("비밀번호를 입력하십시오.");
         form.password.focus();
         return false;
      }
      if(form.password.value != form.password2.value) {
         alert("비밀번호가 일치하지 않습니다.");
         form.password2.focus();
         return false;
      }
      if (form.name.value == "") {
         alert("이름을 입력하십시오.");
         form.name.focus();
         return false;
      }
      if(form.gender.value == "") {
         alert("성별을 선택하십시오.");
         form.gender.focus();
         return false;
      }
      if(form.age.value == "") {
         alert("나이를 입력하십시오.");
         form.age.focus();
         return false;
      }
      if(form.phone.value == "") {
         alert("전화번호를 입력하십시오.");
         form.gender.focus();
         return false;
      }
      var phoneExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
      if(phoneExp.test(form.phone.value)==false) {
         alert("전화번호 형식이 올바르지 않습니다.");
         form.phone.focus();
         return false;
      }
      form.submit();
      
   }
</script>
<title>Register</title>
<style>
	body {
  margin: 0;
  padding: 0;
  font-family: "Trebuchet MS", Dotum;
  display: flex;
  flex-flow: column nowrap;
  justify-content: center;
  align-items: center;
  overflow-x: hidden;  
}
h1 {
  margin: 2em 0 1.5em 0;
}
nav {
  width: 100%;
  display: flex;
  justify-content: center;
  position: relative;
  background: #CED8F6;
}
ul, li {
  margin: 0;
  padding: 0;
  list-style: none;
}
#main-menu > li {
  float: left;
  position: relative;
}
#main-menu > li > a {
  font-size: 0.85rem;
  color: black;
  text-align: center;
  text-decoration: none;
  letter-spacing: 0.05em;
  display: block;
  padding: 14px 36px;
  border-right: 1px solid rgba(0,0,0,0.15);
  text-shadow: 1px 1px 1px rgba(0,0,0,0.2);
}
#main-menu > li:nth-child(1) > a {
  border-left: 1px solid rgba(0,0,0,0.15);
}
#sub-menu {
  position: absolute;
  background: #CED8F6;
  opacity: 0;
  visibility: hidden;
  transition: all 0.15s ease-in;
}
#sub-menu > li {
  padding: 16px 28px;
  border-bottom: 1px solid rgba(0,0,0,0.15);
  
}
#sub-menu > li >  a {
  color: black;
  text-decoration: none;
}
#main-menu > li:hover #sub-menu {
  opacity: 1;
  visibility: visible;
}
#sub-menu > li >  a:hover {
 text-decoration: underline;
}
 	#title {
 		text-align: center;
 		font-size: 25px;
 	}
 	#joinTable, #lectureTable{
 		text-align: center;
 		border: 1px solid black;
 		margin-left: auto;
 		margin-right: auto;
 	}
 	#joinTable{
 		width: 550px;
 		height: 500px;
 	}
 	#lectureTable, #tags{
 		border: 1px solid black;
 		width: 350px;
 		height: 100px;
 		margin-left: auto;
 		margin-right: auto;
 	}
#joinDiv {
	text-align: center;
 	border: 1px solid grey;
 	margin-bottom:  50px;
 	margin: 50px;
 	padding-top: 10px;
	padding-bottom: 50px;
	padding-left: 30px;
	padding-right:30px;
	width: 400px;
}
#table1{
	margin: auto;
}
</style>
</head>
<body>
<br>
<h1>TRAVELMATE</h1>
<br>
<nav>
   <ul id="main-menu">
      <li><a href="<c:url value='/user/home' />">HOME</a></li>
      <li><a href="#">MYHOME</a>
            <ul id="sub-menu">
               <li><a href="<c:url value='/group/myApplyList' />">MYAPPLICATION</a></li>
               <li><a href="<c:url value='/group/myGroup' />">MYGROUP</a></li>
            </ul>
      </li>
      <li><a href="#">TRAVELGROUP</a>
         <ul id="sub-menu">
            <li><a href="<c:url value='/group/create/form' />">GROUP CREATE</a></li>
            <li><a href="<c:url value='/group/search/form' />">GROUP SEARCH</a></li>
            <li><a href="<c:url value='/group/list' />">GROUP LIST</a></li>
         </ul>
      </li>
      <li><a href="<c:url value='/group/manageGroupList' />">MANAGE</a>
      </li>
   </ul>
</nav>
<div id="joinDiv">
	<h4 id="title">MemberShip</h4>
	<form name="form" method="POST" action="<c:url value='/user/register' /> ">
	<table id="table1">
		<tr>
			<td>이메일: </td>
			<td><input type="text" name="email"></td>
		</tr>
		<tr>
			<td>비밀번호: </td>
			<td><input type="password" name="password"></td>
		</tr>
		<tr>
			<td>비밀번호 확인: </td>
			<td><input type="password" name="password2"></td>
		</tr>
		<tr>
			<td>이름: </td>
			<td><input type="text" name="name"></td>
		</tr>
		<tr>
			<td>휴대폰 번호(ex.010-1234-5678)</td>
			<td><input type="text" name="phone"></td>
		</tr>
		<tr>
			<td>나이대</td>
			<td>
				<select name="age">
					<option value="1">10대</option>
					<option value="2">20대</option>
					<option value="3">30대</option>
					<option value="4">40대</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				<select name="gender">
					<option value="1">남자</option>
					<option value="2">여자</option>
				</select>
			</td>
		</tr>
	</table>
	<br><br>
	<input type="button" value="회원 가입" onClick="userCreate()"> &nbsp;
	</form>
</div>
</body>
</html>
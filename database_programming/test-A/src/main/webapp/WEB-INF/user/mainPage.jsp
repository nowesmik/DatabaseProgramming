<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainPage</title>
<style>
h1{
text-align:center;
font-family:"Trebuchet MS", Dotum;
margin: 2em 0 1.5em 0;
}
h2{
text-align:center;
font-family:"Trebuchet MS", Dotum;
}
body {
  margin: 0;
  padding: 0;
  font-family:"Trebuchet MS", Dotum;
  display: flex;
  flex-flow: column nowrap;
  justify-content: center;
  align-items: center;
  overflow-x: hidden;  
}
nav {
  width: 100%;
  display: flex;
  justify-content: center;
  position: relative;
  background:  #CED8F6;
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
 		
#first{
 	border: 1px solid black;
 	text-align: center;
 }
#loginB, #userRB, #logout, #toMP{
	color: #08088A;
	font-weight: bold;
	background: #CED8F6;
	text-decoration: none;
	font-family:"Trebuchet MS", Dotum;
}
#div1, #div2{
	border: 1px solid #CED8F6;
	margin : auto;
	padding: 10px;
	text-align: center;
	width: 300px;
	height: 100px;
	border-style: outset;
	font-family:"Trebuchet MS", Dotum;
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
<br>
<br>
	<h2>
		Travel with us! <br>
		같이 갈 여행친구를 찾아보세요
	<br><br>
	</h2>
	<c:if test= "${user.user_id eq null }" >
		<div id="div1">
			<br>
			<a href="<c:url value='/user/login/form' />" id="loginB">로그인</a> <br><br>
			<a href="<c:url value='/user/register/form' />" id="userRB">회원가입</a>
		</div>
	</c:if>
	<c:if test= "${user.user_id ne null }" >
      <div id="div2">
      이름: ${user.name } (로그인) <br>
       <br>
      <a href="<c:url value='/user/view' >
         </c:url> " id="toMP">마이페이지로 이동</a>
      <br><br>
      <a href="<c:url value= '/user/logout' />" id="logout">로그아웃</a>
      </div>
   </c:if>
</body>
</html>
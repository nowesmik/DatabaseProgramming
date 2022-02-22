<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script>
   function login() {
      if (form.email.value == "") {
         alert("ID를 입력해주세요.");
         form.email.focus();
         return false;
      } 
      if (form.password.value == "") {
         alert("비밀번호를 입력해주세요.");
         form.password.focus();
         return false;
      }      
      form.submit();
   }
</script>
<style type = "text/css">
h1{
text-align:center;
font-family:"Trebuchet MS", Dotum;
margin: 2em 0 1.5em 0;
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
 		
#loginform {
width:400px;
margin-bottom: 100px;
padding: 70px;
border-style: double;
border : 1px double #D8D8D8;
}
#tobemember{
color: #0040FF;

a:link {
color: black;
}
a:visited {
color: black;
}
h5 {
display: inline;
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
<br><br>
<div id="loginform" >
 <form  name="form" method="POST" action="<c:url value='/user/login' />">
	<h2><b>MEMBER LOGIN</b></h2>
	<c:if test="${loginFailed}">
	  	  <br><font color="red"><c:out value="${exception.getMessage()}" /></font><br>
	    </c:if>
	<h4> ID : </h4>
	<input type="text" style="width:240" name="email">
	<h4> 비밀번호 : </h4>
	<input type="password" style="width:240" name="password"><br><br>
	<a href="<c:url value='/user/register/form' />" id="userRB">회원가입</a><br><br>
	<input type="button" value="로그인" onClick="login()"> &nbsp;	
</form>
</div>
</body>
</html>
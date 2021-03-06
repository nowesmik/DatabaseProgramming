<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.*" %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYPAGE</title>
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
 #title {
 		text-align: center;
 		font-size: 50px;
 }
 #forUpdate, #forHome {
 	diplay: inline;
 }
 
 #goHome, #updateB {
 	color: #08088A;
	font-weight: bold;
	background:  #CED8F6;
	text-decoration: none;
 }
 #div1{
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

<script type="text/javascript">
function home(targetUri) {
	form.action = targetUri;
	form.submit();
}
</script>
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
<div id="div1">
	<h4 id="title">My Page</h4>
	<table id="table1">
		<tr>
			<td>?????? </td>
			<td>&nbsp;${user.name }</td>
		</tr>
		<tr>
			<td>????????? ?????? </td>
			<td>&nbsp;&nbsp;${user.email }</td>
		</tr>
		<tr>
			<td>????????? ??????</td>
			<td>&nbsp;${user.phone }</td>
		</tr>
		<tr>
			<td>?????????</td>
			<td>&nbsp;
			<c:if test="${user.age eq '1'}"> 
					<c:out value="10???" />
			</c:if>
			<c:if test="${user.age eq '2'}">
				<c:out value="20???" />
			</c:if>
			<c:if test="${user.age eq '3'}"> 
					<c:out value="30???" />
			</c:if>
			<c:if test="${user.age eq '4'}">
				<c:out value="40???" />
			</c:if>
			</td> 
		</tr>
		<tr>
			<td>??????</td>
			<td>&nbsp;
				<c:set var= "gender" value="${user.gender}" />
				<c:if test="${gender eq '1'}"> 
					<c:out value="??????" />
				</c:if>
				<c:if test="${gender eq '2'}">
					<c:out value="??????" />
				</c:if>
			</td>
		</tr>
	</table>
</div>
<div id="div2">
	<a href="<c:url value= '/user/home'>
		<c:param name='memberId' value='${user.user_id }' />
	</c:url>" id="goHome">?????????</a>
	<a href="<c:url value= '/user/update/form' >
	<c:param name='userId' value='${user.user_id }' />
	</c:url>" id="updateB">????????????</a>		
</div>
<br>
</body>
</html>
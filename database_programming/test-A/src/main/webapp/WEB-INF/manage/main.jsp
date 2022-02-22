<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.util.*" %>
<%@page import = "model. *" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%
    request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Group Manage</title>
<style>
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
th{
	background : #CED8F6;
	color: white;
}
#manageT{
	text-align: center;
	border: 1px solid #E6E6E6;
	width: 500px;
	height: auto;
}
a{
	text-decoration: none;
}
a:link {
	color: black;
}
a:visited {
	color: black;
}
#gname{
	color: blue;
}
</style>
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
<h2>그룹 관리</h2>
<table id="manageT">
	<tr>
		<th>그룹 명 </th>
		<th>인원</th>
		<th>기간</th>
	</tr>
	
	<c:forEach var="tg" items="${groupList}">
		<tr>
			<td>
			<a href="<c:url value='/group/manageGroup'>
						   <c:param name='groupId' value='${tg.groupId}'/>
						 </c:url>" id="gname">
				  ${tg.groupName}</a>
			</td>
			<td>
				<c:set var="num" value="${tg.numberOfUsers}" />
				<c:if test="${num eq '3' }" >
					<c:out value="3명" />
				</c:if>
				<c:if test="${num eq '4' }" >
					<c:out value="4명" />
				</c:if>
				<c:if test="${num eq '5' }" >
					<c:out value="5명" />
				</c:if>
				<c:if test="${num eq '6' }" >
					<c:out value="6명" />
				</c:if>
				<c:if test="${num eq '7' }" >
					<c:out value="7명" />
				</c:if>
				<c:if test="${num eq '8' }" >
					<c:out value="8명" />
				</c:if>
				<c:if test="${num eq '9' }" >
					<c:out value="9명" />
				</c:if>
				<c:if test="${num eq '10' }" >
					<c:out value="10명" />
				</c:if>
				<c:if test="${num eq '11' }" >
					<c:out value="10명이상" />
				</c:if>
				<c:if test="${num eq '0' }" >
					<c:out value="상관없음" />
				</c:if>
			</td>
			<td>
				<c:if test="${tg.term == '0' }">
						미지정
					</c:if>
					<c:if test="${tg.term == '1' }" >
						1박2일
					</c:if>
						<c:if test="${tg.term == '2' }" >
						2박3일
					</c:if>
						<c:if test="${tg.term == '3' }" >
						3박4일
					</c:if>
						<c:if test="${tg.term == '7' }" >
						1주일
					</c:if>
						<c:if test="${tg.term == '30' }" >
						한달
					</c:if>
			</td>
		</tr>
	</c:forEach>
	
</table>

</body>
</html>
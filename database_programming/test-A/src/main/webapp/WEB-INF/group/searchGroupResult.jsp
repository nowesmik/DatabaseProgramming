<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %> 
<%@page import="java.util.*" %>    
<%@page import="model.*, controller. *" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SEARCH RESULT</title>
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
h2,p{
font-family: "Trebuchet MS", Dotum;
text-align: center;
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
#resultTable{
      border: 1px solid #E6E6E6;
      width: 500px;
      height: auto;
      margin: 0;
      text-align: center;
   }
   
th{
   background : #084B8A;
   color: white;
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
#bc{
   color: blue;
}
</style>

<style>
   
</style>
</head>
<body>
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
      <li><a href="#">MANAGE</a>
      </li>
   </ul>
</nav>
<br><br>
<div id ="result">
<table id="resultTable">
   <tr>
      <th>번호</th>
      <th>그룹명</th>
      <th>여행장소</th>
      <th>여행기간</th>
      <th>모집성별</th>
      <th>모집나이대</th>
      <th>교통수단</th>
      <th>모집인원</th>
   </tr>
   <c:if test="${searchFailed}">
      <tr>
         <td colspan="6"><c:out value="${exception.getMessage()}" /></td>
      </tr>
   </c:if>
   <c:forEach var="tg" items="${groupList}" varStatus= "status"> 
      <tr>
         <td><c:out value="${status.count}" /></td>
         <td>
            <a href= "<c:url value='/group/view' >
               <c:param name='groupId' value='${tg.groupId }' />
               </c:url>" id="bc">${tg.groupName }</a>
         </td>
         <td>${tg.place}</td>
         
         <td>
         <c:set var="gen" value="${tg.genderType }" />
         <c:if test="${gen eq '0'}" >
            <c:out value="상관없음" />
         </c:if>
         <c:if test="${gen eq '1'}" >
            <c:out value="남성" />
         </c:if>
         <c:if test="${gen eq '2'}" >
            <c:out value="여성" />
         </c:if>
         </td>
         
         <td>
         <c:set var="age" value="${tg.age}"/>
         <c:if test="${age eq '0'}">
            <c:out value="상관없음"/>
         </c:if>
         <c:if test="${age eq '1'}">
            <c:out value="10대"/>
         </c:if>
         <c:if test="${age eq '2'}">
            <c:out value="20대"/>
         </c:if>
         <c:if test="${age eq '3'}">
            <c:out value="30대"/>
         </c:if>
         <c:if test="${age eq '4'}">
            <c:out value="40대"/>
         </c:if>
         </td>
         
         <td>
         <c:set var="num" value="${tg.numberOfUsers}"/>
         <c:if test="${num eq '3'}">
            <c:out value="3"/>
         </c:if>
         <c:if test="${num eq '4'}">
            <c:out value="4"/>
         </c:if>
         <c:if test="${num eq '5'}">
            <c:out value="5"/>
         </c:if>
         <c:if test="${num eq '6'}">
            <c:out value="6"/>
         </c:if>
         <c:if test="${num eq '7'}">
            <c:out value="7"/>
         </c:if>
         <c:if test="${num eq '8'}">
            <c:out value="8"/>
         </c:if>
         <c:if test="${num eq '9'}">
            <c:out value="9"/>
         </c:if>
         <c:if test="${num eq '10'}">
            <c:out value="10"/>
         </c:if>
         <c:if test="${num eq '11'}">
            <c:out value="10명 이상"/>
         </c:if>
         </td>
         <td>${tg.trafficType}
         </td>
      </tr>
   </c:forEach>
   </table>
   </div>
</body>
</html>
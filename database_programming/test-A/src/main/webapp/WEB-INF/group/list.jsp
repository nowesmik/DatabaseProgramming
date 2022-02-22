<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GroupList</title>
<script>
<% 
   out.println("window.onload = function showResult() {");
   String rst = String.valueOf(request.getAttribute("errorResult"));
   if(rst != null){
      if(rst.equals("gender")){
         out.println("alert('팀장의 성별과 조건의 성별이 어긋납니다'); ");
      }
      if(rst.equals("age")){
         out.println("alert('팀장의 나이대와 조건의 나이대가 어긋납니다'); ");
   }
}
out.println("}");
%>
</script>
<style type = "text/css">
h1{
text-align:center;
font-family:"Trebuchet MS", Dotum;
}
h2,p{
text-style:bold;
text-align:center;
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
th{
   background : #CED8F6;
   color: white;
}
#allList{
   width: 600px;
   height: auto;
   margin: auto;
   text-align:center;
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
color:blue;
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
<div>
<h2>
   TravelGroup<br>
         원하는 여행 메이트를 찾아보세요!
</h2>
<p>*인원모집이 완료된 그룹은 조회할 수 없습니다*</p>   
</div>
<br>
<table id="allList">
   <tr> 
      <th>여행그룹 명 </th>
      <th>소개</th>
      <th>기간</th>
      <th>인원</th>
   </tr>
   <c:forEach var="group" items="${groupList}"> <!-- List<TravelGroup>이 반환됨. -->
      <c:set var="maxNum" value="${group.numberOfUsers}" />
      <c:set var="groupMembers" value="${fn:length(group.groupMembers)}" />
      <c:if test="${maxNum ne groupMembers}" >
         <tr>
            <td>
            <a href= "<c:url value='/group/view' >
               <c:param name='groupId' value='${group.groupId}' />
               </c:url>" id="bc">${group.groupName}</a>
            </td>
            <td>${group.description}</td>
            <td>
               <c:if test="${group.term == '0' }">
                                        미지정
               </c:if>
               <c:if test="${group.term == '1' }" >
					1박2일
			   </c:if>
				<c:if test="${group.term == '2' }" >
					2박3일
				</c:if>
				<c:if test="${group.term == '3' }" >
					3박4일
				</c:if>
				<c:if test="${group.term == '7' }" >
					1주일
				</c:if>
				<c:if test="${group.term == '30' }" >
					한달
				</c:if>
            </td>
            <td>${groupMembers}/${maxNum}</td>
         </tr>
      </c:if>
   </c:forEach>
</table>
</body>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>    
<%@page import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Group View</title>
<%
   out.println("<script> ");
   out.println("window.onload = function showResult() {");
   String rst =  request.getParameter("result");
   
   if(rst != null){
      if(rst.equals("-1"))
         out.println("alert('이미 해당 그룹에 신청하였습니다.'); ");
      else if(rst.equals("2"))
         out.println("alert('이미 해당 그룹에 존재하는 멤버입니다.'); ");
      else if(rst.equals("3"))
         out.println("alert('성별 조건에 맞지 않기 때문에 신청에 실패하였습니다.'); ");   
      else if(rst.equals("4"))
         out.println("alert('나이대 조건에 맞지 않기 때문에 신청에 실패하였습니다.'); ");   
   }
   out.println(" } </script>");
   %>
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
#groupDiv{
   float: left;
   width: 50%;
   height: auto;
   border: 1px solid #E6E6E6;
}
#groupInfo{
   margin: auto;
   padding: 15px;
   width: auto;
   heigth: 300px;
}
#memberDiv{
   float: right;
   width: 320px;
   heigth: auto;
   border: 1px solid #E6E6E6;
}
#memberList{
   margin: auto;
   padding: 10px;
}
table{
margin:auto;
}
th, #bc, #bc2{
   background : #CED8F6;
   color: black;
   text-align: center;
   padding: 5px;
   
}
#bc,#bc2{
   width: 80px;
}
#addMDiv{
   float: right;
   width: 320px;
   heigth: 200px;
   border: 1px solid #E6E6E6;
}
#applyT{
   text-align: center;
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
<div id="groupDiv">
      <table id="groupInfo">
         <tr>
            <td id="bc">그룹명</td>
            <td>${Group.groupName}</td>
         </tr>
         <tr>
            <td id="bc" >소개</td>
            <td colspan="2">${Group.description}</td>
         </tr>
         <tr>
            <td id="bc" >모집인원</td>
            <td>${Group.numberOfUsers}명</td>
            <td id="bc">생성일자</td>
            <td>${Group.createdDate}</td>
         </tr>
         <tr>
            <td id="bc2">여행장소</td>
            <td style="width: 100px;">${Group.place}</td>
            <td id="bc2">모집성별</td>
            <td>
               <c:set var="gen" value="${Group.genderType}" />
               <c:if test="${gen eq '1'}">
                  <c:out value="남성" />
               </c:if>
               <c:if test="${gen eq '2'}">
                  <c:out value="여성" />
               </c:if>
               <c:if test="${gen eq '0'}">
                  <c:out value="상관없음" />
               </c:if>
            </td>
         </tr>
         <tr>
            <td id="bc2">모집나이대</td>
            <td style="width: 100px;">
               <c:set var="age" value="${Group.age}" />
               <c:if test="${age eq '0'}">
                  <c:out value="상관없음" />
               </c:if>
               <c:if test="${age eq '1'}">
                  <c:out value="10대" />
               </c:if>
               <c:if test="${age eq '2'}">
                  <c:out value="20대" />
               </c:if>
               <c:if test="${age eq '3'}">
                  <c:out value="30대" />
               </c:if>
               <c:if test="${age eq '4'}">
                  <c:out value="40대" />
               </c:if>
            </td>
            <td id="bc2">여행기간</td>
            <td>
               <c:if test="${Group.term == '0' }">
                                       미지정
               </c:if>
               <c:if test="${Group.term == '1' }" >
                  1박2일
               </c:if>
               <c:if test="${Group.term == '2' }" >
                  2박3일
               </c:if>
               <c:if test="${Group.term == '3' }" >
                  3박4일
               </c:if>
               <c:if test="${Group.term == '7' }" >
                  1주일
               </c:if>
               <c:if test="${Group.term == '30' }" >
                                         한달
               </c:if>
            </td>
         </tr>
      </table>
</div>

<div id="memberDiv"> 
         
      <table id="memberList" style="width: 250px;">
         <caption>GroupMembers</caption>
         <tr>
            <th>이름</th>
            <th>나이대</th>
            <th>성별</th>
         </tr>
         <!-- user 수 만큼 출력됨. -->
         <c:forEach var="tgUsers" items="${Group.groupMembers}">
            <tr>
               <td>&nbsp;${tgUsers.name}</td>
               <td>&nbsp;
                  <c:if test="${tgUsers.age eq '1'}">
                     <c:out value="10대" />
                  </c:if>
                  <c:if test="${tgUsers.age eq '2'}">
                     <c:out value="20대" />
                  </c:if>
                  <c:if test="${tgUsers.age eq '3'}">
                     <c:out value="30대" />
                  </c:if>
                  <c:if test="${tgUsers.age eq '4'}">
                     <c:out value="40대" />
                  </c:if>
               </td>
               <td>&nbsp;
                  <c:if test="${tgUsers.gender eq '1'}">
                     <c:out value="남성" />
                  </c:if>
                  <c:if test="${tgUsers.gender eq '2'}">
                     <c:out value="여성" />
                  </c:if>
               </td>
            </tr>
         </c:forEach>
      </table>
      
</div>

<div id="addMDiv">
<form name="form" method="POST" action="<c:url value= '/group/apply'  >
   <c:param name="groupId" value="${Group.groupId }"/>
   </c:url>" onsubmit='return frmsubmit();'>
<table id="applyT">
<tr>
   <td><h5 style="color: red;">조건에 맞는 분만 신청이 가능합니다.</h5></td>
</tr>
<tr>
   <td><input type="text" name="comments" /> </td>
</tr>
<tr>
   <td><input type="submit" value="팀원 신청하기" onClick= "showResult()"/></td>
</tr>
</table>
</form>
<br>
</div>
</body>
</html>
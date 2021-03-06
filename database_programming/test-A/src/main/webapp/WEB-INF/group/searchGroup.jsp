<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>    
<%@page import="model.*, controller. *" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GroupSearch</title>
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
#intro{
      font-size: 15px;
      border-bottom: 1px dashed black;
      text-align: center;
      margin: 0;
}
#searchT{
   border: 1px solid #BDBDBD;
   width: 500px;
   heigh: auto;
   text-align: center;
   margin: auto;
   padding: 10px;
}
#gSearchB {
   background : #CED8F6;
   color: black;
   float: right;
}
th{
   width: 150px;
   background : #CED8F6;
   color: black;
}
#result {
   margin-bottom: 30px;
}
#resultTable{
   border: 1px solid #E6E6E6;
   width: 500px;
   height: auto;
   margin: 0;
   text-align: center;
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
#gName{
   color: blue;
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
<div id="intro">
<h2><b>TRAVELGROUP</b></h2>
<p><b>????????? ????????? ??????????????????.<br>
??????????????? ?????? ????????? ?????? ??? ???????????????.</b></p>
</div>
<div id="search">
   <h2 style="text-align: center;">Group Search</h2>
   
   <form name="form" method="POST" action="<c:url value='/group/search' />" >
      <table id="searchT">
         <tr>
            <th>????????????</th>
               <td><input type="text" name="place" onFocus="this.value='' " /></td>   
         </tr>
         <tr>
            <th>????????????</th>
            <td>
               <select name="term">
                  <option value="-1" <c:if test="${term eq null}">selected</c:if>>-????????????-</option>
                  <option value="1" <c:if test="${term eq '1'}">selected</c:if>>1???2???</option>
                  <option value="2" <c:if test="${term eq '2'}">selected</c:if>>2???3???</option>
                  <option value="3" <c:if test="${term eq '3'}">selected</c:if>>3???4???</option>
                  <option value="7" <c:if test="${term eq '7'}">selected</c:if>>1??????</option>
                  <option value="30" <c:if test="${term eq '30'}">selected</c:if>>1??????</option>
                  <option value="0" <c:if test="${term eq '0'}">selected</c:if>>?????????</option>
               </select>
            </td>
         </tr>
         <tr>
            <th>????????????</th>
            <td>
               <select name="genderType">
                  <option value="-1" <c:if test="${genderType eq null }">selected</c:if>>-????????????- </option>
                  <option value="1" <c:if test="${genderType eq '1' }">selected</c:if>>??????</option>
                  <option value="2" <c:if test="${genderType eq '2' }">selected</c:if>>??????</option>
                  <option value="0" <c:if test="${genderType eq '0' }">selected</c:if>>????????????</option>
               </select>
            </td>
         </tr>
         <tr>
            <th>???????????????</th>
            <td>
               <select name="age">      
                  <option value="-1" <c:if test="${Age eq null}">selected</c:if>>-????????????-</option>
                  <option value="1" <c:if test="${Age eq '1'}">selected</c:if>>10???</option>
                  <option value="2" <c:if test="${Age eq '2'}">selected</c:if>>20???</option>
                  <option value="3" <c:if test="${Age eq '3'}">selected</c:if>>30???</option>
                  <option value="4" <c:if test="${Age eq '4'}">selected</c:if>>40???</option>
                  <option value="0" <c:if test="${Age eq '0'}">selected</c:if>>????????????</option>
               </select>
            </td>
         </tr>
         <tr>
            <th>????????????</th>
            <td>
               <select name="numberOfUsers">
                     <option value="-1" <c:if test="${num eq null}">selected</c:if>>-????????????-</option>
                     <option value="3" <c:if test="${num eq '3'}">selected</c:if>>3</option>
                     <option value="4" <c:if test="${num eq '4'}">selected</c:if>>4</option>
                     <option value="5" <c:if test="${num eq '5'}">selected</c:if>>5</option>
                     <option value="6" <c:if test="${num eq '6'}">selected</c:if>>6</option>
                     <option value="7" <c:if test="${num eq '7'}">selected</c:if>>7</option>
                     <option value="8" <c:if test="${num eq '8'}">selected</c:if>>8</option>
                     <option value="9" <c:if test="${num eq '9'}">selected</c:if>>9</option>
                     <option value="10" <c:if test="${num eq '10'}">selected</c:if>>10</option>
                     <option value="11" <c:if test="${num eq '11'}">selected</c:if>>10??? ??????</option>
               </select>
            </td>
         </tr>
         <tr>
            <th>????????????</th>
            <td>
              <select name="trafficType">      
                  <option value="-1" <c:if test="${trafficType eq null}">selected</c:if>>-????????????-</option>
                  <option value="??????" <c:if test="${trafficType eq '??????'}">selected</c:if>>??????</option>
                  <option value="?????????" <c:if test="${trafficType eq '?????????'}">selected</c:if>>?????????</option>
                  <option value="?????????" <c:if test="${trafficType eq '?????????'}">selected</c:if>>?????????</option>
                  <option value="KTX" <c:if test="${trafficType eq 'KTX'}">selected</c:if>>KTX</option>
                  <option value="?????????" <c:if test="${trafficType eq '?????????'}">selected</c:if>>?????????</option>
               </select>
            </td>
         </tr>
      </table>
      <br><br>
      <input type="submit" value="????????????" id="gSearchB" onClick="changeSelected()">
   </form>
</div>


<!-- ?????? ?????? ?????? ?????? -->
   <br>
   
<c:if test="${not empty groupList || searchFailed ne null}">
   <h2>?????? ?????? ??????</h2>
      <div id ="result">
      <table id="resultTable" style="width: 850px">
      <tr>
         <th>??????</th>
         <th>?????????</th>
         <th>????????????</th>
         <th>????????????</th>
         <th>????????????</th>
         <th>???????????????</th>
         <th>????????????</th>
         <th>????????????</th>
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
                  </c:url>" id="gName">${tg.groupName }</a>
            </td>
            <td>${tg.place }</td>
            <td>
               <c:if test="${tg.term == '0' }">
                                           ?????????
               </c:if>
               <c:if test="${tg.term == '1' }" >
                  1???2???
               </c:if>
                <c:if test="${tg.term == '2' }" >
                  2???3???
               </c:if>
                <c:if test="${tg.term == '3' }" >
                  3???4???
               </c:if>
                <c:if test="${tg.term == '7' }" >
                  1??????
               </c:if>
                <c:if test="${tg.term == '30' }" >
                                         ??????
               </c:if>
            </td>
            <td>
            <c:set var="gen" value="${tg.genderType }" />
            <c:if test="${gen eq '0'}" >
               <c:out value="????????????" />
            </c:if>
            <c:if test="${gen eq '1'}" >
               <c:out value="??????" />
            </c:if>
            <c:if test="${gen eq '2'}" >
               <c:out value="??????" />
            </c:if>
            </td>
            <td>
               <c:set var="age" value="${tg.age }" />
               <c:if test="${age eq '0'}">
                  <c:out value="????????????" />
               </c:if>
               <c:if test="${age eq '1'}">
                  <c:out value="10???" />
               </c:if>
               <c:if test="${age eq '2'}">
                  <c:out value="20???" />
               </c:if>
               <c:if test="${age eq '3'}">
                  <c:out value="30???" />
               </c:if>
               <c:if test="${age eq '4'}">
                  <c:out value="40???" />
               </c:if>
            </td>
            <td>
               <c:set var="tra" value="${tg.trafficType }" />
               <c:if test="${tra eq '??????'}">
                  <c:out value="??????" />
               </c:if>
               <c:if test="${tra eq '?????????'}">
                  <c:out value="?????????" />
               </c:if>
               <c:if test="${tra eq '?????????'}">
                  <c:out value="?????????" />
               </c:if>
               <c:if test="${tra eq 'KTX'}">
                  <c:out value="KTX" />
               </c:if>
                  <c:if test="${tra eq '?????????'}">
                  <c:out value="?????????" />
               </c:if>
            </td>
            <td>
               <c:set var="num" value="${tg.numberOfUsers }" />
               <c:if test="${num eq 0}">
                  <c:out value="????????????" />
               </c:if>
                <c:if test="${num eq 3}">
                  <c:out value="3" />
               </c:if>
                 <c:if test="${num eq 4}">
                  <c:out value="4" />
               </c:if>
                 <c:if test="${num eq 5}">
                  <c:out value="5" />
               </c:if>
                 <c:if test="${num eq 6}">
                  <c:out value="6" />
               </c:if>
                 <c:if test="${num eq 7}">
                  <c:out value="7" />
               </c:if>
                 <c:if test="${num eq 8}">
                  <c:out value="8" />
               </c:if>
                 <c:if test="${num eq 9}">
                  <c:out value="9" />
               </c:if>
                 <c:if test="${num eq 10}">
                  <c:out value="10" />
               </c:if>
               <c:if test="${num eq 11}">
                  <c:out value="10?????????" />
               </c:if>
            </td>
         </tr>
      </c:forEach>
      </table>
      </div>
 </c:if>
</body>
</html>
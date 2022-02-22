<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>    
<%@page import="model.*,controller.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddGroupList</title>
<script type="text/javascript">
<% 
	String ex = (String)request.getAttribute("errorResult");
	System.out.println("들어왔는지" + ex);
	if(ex != null){
		if(ex.equals("age")){
			System.out.println("들어왔는지" + true);
			out.println("alert('나이 조건이 맞지 않습니다.');");
		} else if (ex.equals("gender")) {
			System.out.println("들어왔는지" + true);
			out.println("alert('성별 조건이 맞지 않습니다.');");
		} else if (ex.equals("groupName")) {
			System.out.println("들어왔는지" + true);
			out.println("alert('그룹 이름이 중복됩니다. 다시 입력하세요!');");
		} else if (ex.equals("emptyName")) {
			System.out.println("들어왔는지" + true);
			out.println("alert('그룹 이름이 비었습니다. 다시 입력하세요!');");
		} else if (ex.equals("emptyDescription")) {
			System.out.println("들어왔는지" + true);
			out.println("alert('소개가 비었습니다. 다시 입력하세요!');");
		} else if (ex.equals("emptyPlace")){
			System.out.println("들어왔는지" + true);
			out.println("alert('여행 장소가 비었습니다. 다시 입력하세요!');");
		} else {
			out.println("alert('에러발생!');");
		}
	}
%>
</script>
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
table{
margin:auto;
}
#intro{
      font-size: 15px;
      border-bottom: 1px dashed black;
      text-align: center;
      margin: 0;
}
#addGroup{
      border: 1px solid #E6E6E6;
      width: 550px;
      height: 300px;
   }
#bc{
   width: 150px;
   background : #CED8F6;
   color: black;
   text-align:center;
}
#gAddB{
   background : #CED8F6;
   color: black;
   float: right;
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
<h2>TravelGroup</h2>
<p><b>그룹 등록 후, 마음에 드는 팀원을 찾아보세요.<br>
그룹 등록을 위한 조건을 입력 및 선택해주세요.</b></p>
</div>
   
<div id="gAddDic">
   <h2 style="text-align: center;">Group Create</h2>
   
   <form name="form" method="POST" action="<c:url value='/group/create' />">   
      <table id= "addGroup">
         <tr>
            <td id="bc">모집인원</td>
            <td>
               <select name="numberOfUsers">
                  <option value="3" selected>3</option>
                  <option value="4">4</option>
                  <option value="5">5</option>
                  <option value="6">6</option>
                  <option value="7">7</option>
                  <option value="8">8</option>
                  <option value="9">9</option>
                  <option value="10">10</option>
                  <option value="11">10명 이상</option>
               </select>
            </td>
            <td id="bc">교통수단</td>
            <td>
               <select name="trafficType">
                  <option value="버스" selected>버스</option>
                  <option value="비행기">비행기</option>
                  <option value="지하철">지하철</option>
                  <option value="KTX">KTX</option>
                  <option value="렌트카">렌트카</option>
               </select>
            </td>
         </tr>
         <tr>
            <td id="bc">여행 그룹 명</td>
            <td><input type="text" name="groupName" onFocus="this.value='' " 
               <%-- <c:if test="${creationFailed }"> value="${Group.groupName }"</c:if> --%>
               ></td>
            <td id="bc">여행기간</td>
            <td><select name="term">
               <option value="1">1박 2일</option>
               <option value="2">2박 3일</option>
               <option value="3">3박 4일</option>
               <option value="7">1주일</option>
               <option value="30">한달</option>
               <option value="0">미지정</option>
            </select>
            
            </td>
         </tr>
         <tr>
            <td id="bc">소개</td>
            <td colspan="3"><input type="text" name="description" onFocus="this.value=''' " 
                  style="width:300px;"
               <c:if test="${creationFaild }">value="${Group.description }" </c:if>
            /> </td>
         </tr>
         <tr>
            <td id="bc">여행 장소</td>
            <td><input type="text" name="place" onFocus="this.value='' " 
               <c:if test="${creationFailed }"> value="${Group.Place }"</c:if>
               /></td>
            <td id="bc">모집성별</td>
            <td>
               <select name="genderType">
                  <option value="0">상관없음</option>
                  <option value="1">남성</option>
                  <option value="2">여성</option>
               </select>
            </td>
         </tr>
         <tr>
            <td id="bc">모집나이대</td>
            <td>
               <select name="age">
                  <option value="0">상관없음</option>
                  <option value="1">10대</option>
                  <option value="2">20대</option>
                  <option value="3">30대</option>
                  <option value="4">40대</option>
               </select>
            </td>
            <td id="bc">팀장 Id</td>
            <td>${userId}</td>
         </tr>
      </table>
      <br><br>
      <input type="submit" value="생성하기" onClick="addGroup()" id="gAddB"/> 
      <br><br>
   </form>
</div>
</body>
</html>
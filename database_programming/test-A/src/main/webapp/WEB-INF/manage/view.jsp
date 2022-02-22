<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "model.*" import="java.util.ArrayList" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹 관리 </title>
<%
	out.println("<script>");
	out.println("window.onload = function showResult() {");
	Object rst = request.getParameter("result");
	if(rst != null){	
		out.println("alert('지원서를 더이상 받을 수 없습니다!!(인원꽉참)'); ");
	}
	
out.println("}</script>");
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
 	#main1 ,#main2 {
 		text-align: center;
 		border: 1px solid #BDBDBD;
 		margin: 20px;
 		width: 700px;
 		height: 30px;
 		}
 	#userlist, #applyList{
 		text-align: center;
 		border: 1px solid #BDBDBD;
 		margin-bottom: 50px;
 		width: 700px;
 		height: 30px;
 		
 	}
 th, #bc{
 		width: 150px;
		background : #CED8F6;
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
#acceptB, #rejectB{
	float: right;
}
#acceptB {color: blue;}
#rejectB {color: red;}
#gManageUpdateB, #gDeleteB {
		background: #E6E6E6;
		color: black;
		float: right;
}
 </style>
 
<script>
function memberDelete() {
	return confirm("정말 삭제하시겠습니까?");		
}
function memberAccept() {
	return confirm("멤버로 수락하시겠습니까?");
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
<br><br>
<table id="main1">
		<tr>
			<td id="bc">그룹 명</td>
			<td>${Group.groupName } </td>
			<td id="bc">모집인원</td>
			<td>
				<c:set var="num" value="${Group.numberOfUsers }" />
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
			<td id="bc">여행기간</td>
			<td>
				<c:set var="term" value="${Group.term }" />
				<c:if test="${term eq '1' }" >
					<c:out value="1박2일" />
				</c:if>
				<c:if test="${term eq '2' }" >
					<c:out value="2박3일" />
				</c:if>
				<c:if test="${term eq '3' }" >
					<c:out value="3박4일" />
				</c:if>
				<c:if test="${term eq '7' }" >
					<c:out value="1주일 " />
				</c:if>
				<c:if test="${term eq '30' }" >
					<c:out value="한달" />
				</c:if>
				<c:if test="${term eq '0' }" >
					<c:out value="미지정" />
				</c:if>
			</td>
		</tr>
</table>

<table id="main2">
	<tr>
		<td id="bc">여행장소</td>
		<td>${Group.place} </td>
		<td id="bc">교통수단</td>
		<td>
			<c:set var="tra" value="${Group.trafficType }" />
            <c:if test="${tra eq '버스'}">
                  <c:out value="버스" />
            </c:if>
            <c:if test="${tra eq '비행기'}">
                  <c:out value="비행기" />
            </c:if>
            <c:if test="${tra eq '지하철'}">
                  <c:out value="지하철" />
            </c:if>
            <c:if test="${tra eq 'KTX'}">
                  <c:out value="KTX" />
            </c:if>
            <c:if test="${tra eq '렌트카'}">
                  <c:out value="렌트카" />
            </c:if>
         </td>
	</tr>
	<tr>
		<td id="bc">개설 일자</td>
		<td>${Group.createdDate }</td>
		<td id="bc">모집성별</td>
		<td>
			<c:set var="gen" value="${Group.genderType }" />
			<c:if test="${gen eq '0' }" >
				<c:out value="상관없음" />
			</c:if>
			<c:if test="${gen eq '1'}" >
				<c:out value="남성" />
			</c:if>
			<c:if test="${gen eq '2'}" >
				<c:out value="여성" />
			</c:if>
		</td>
	</tr>
	<tr>
		<%-- <td id="bc">팀장</td>
		<td>${Group.leaderId}</td> --%>
		<td id="bc">모집나이대</td>
		<td >
			<c:set var="age" value="${Group.age }" />
			<c:if test="${age eq '1' }" >
				<c:out value="10대" />
			</c:if>
			<c:if test="${age eq '2' }" >
				<c:out value="20대" />
			</c:if>
			<c:if test="${age eq '3' }" >
				<c:out value="30대" />
			</c:if>
			<c:if test="${age eq '4' }" >
				<c:out value="40대" />
			</c:if>
			<c:if test="${age eq '0' }" >
				<c:out value="상관없음" />
			</c:if>
		</td>
	</tr>
	<tr>
		<td id="bc">소개</td>
		<td>${Group.description }</td>
	</tr>
</table>

<a><h3>멤버 리스트</h3></a>

<table id= "userlist">
	<tr>
		<th>&nbsp;</th>
		<th>이름</th>
		<th>나이대</th>
		<th>성별</th>
	</tr>
	
	<c:forEach var="gmList" items="${Group.groupMembers}" varStatus="status" >
		<tr>			
			<td><c:out value='${status.count }' /></td>
			<td>${gmList.name }</td>
			<td>
			   <c:set var="age" value="${gmList.age}" />
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
			<td>
				<c:set var="gen" value="${gmList.gender}" />
				<c:if test="${gen eq '1'}"> 
					<c:out value="남성" />
				</c:if>
				<c:if test="${gen eq '2'}"> 
					<c:out value="여성" />
				</c:if>
			</td>
		</tr>
	</c:forEach>
	
</table>

<a><h3>신청자 리스트</h3></a>
<table id="applyList">
	
		<tr>
			<th>&nbsp;</th>
			<th>멤버 id</th>
			<th>이름</th>
			<th>작성한 코멘트</th>
			<th>신청 날짜</th>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
		</tr>
		
		<c:forEach var="aList" items="${applyList}" varStatus="status" >
			<c:if test="${aList.isApproved eq '0'}">
				<tr>
					<td><c:out value="${status.count }" />
					<td>${aList.memberId}</td>
					<td>${aList.memberName}</td>
					<td style="width: 300px;">${aList.comment }</td>
					<td>${aList.applyDate }</td>
					<td><a href= "<c:url value='/group/manageGroup/applyAccept' > 
						<c:param name="groupId" value="${Group.groupId}" />
						<c:param name="memberId" value="${aList.memberId}" />
						<c:param name="isAccepted" value="true" />
						</c:url>" id="acceptB">수락</a></td>
					<td><a href= "<c:url value='/group/manageGroup/applyAccept' > 
						<c:param name="groupId" value="${Group.groupId}" />
						<c:param name="memberId" value="${aList.memberId}" />
						<c:param name="isAccepted" value="false" />
						</c:url>" id="rejectB">거절</a></td>
				</tr>
			</c:if>
		</c:forEach>
</table>

<table>
		<tr>
			<td><a href="<c:url value='/group/manageGroup/update/form' >
				<c:param name='groupId' value='${Group.groupId}' />
				</c:url> " id="gManageUpdateB">정보 수정</a>
			</td>
			<td> <a href="<c:url value='/group/manageGroup/delete' >
				<c:param name="groupId" value="${Group.groupId }" />
				</c:url>" id="gDeleteB">그룹 삭제</a>
			</td>
		</tr>
</table>
<br><br>
</body>
</html>
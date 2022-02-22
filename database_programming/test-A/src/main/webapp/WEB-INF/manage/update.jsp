<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="controller.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>manage update page</title>

<script>
	function groupModify() {
		if(form.groupName.value == ""){
			alert("그룹 명을 입력하시오.");
			form.groupName.focus();
			return false;
		}
		if(form.description.value == ""){
			alert("그룹 소개를 작성하십시오.");
			form.description.focus();
			return false;
		}
		form.submit();
		
	}
</script>
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
 #main1, #main2{
 		text-align: center;
 		border: 1px solid #BDBDBD;
 		margin-top: 50px;
 		margin-bottom: 20px;
 		width: 700px;
 		height: 30px;
 		}
 #userlist{
 		text-align: center;
 		border: 1px solid #BDBDBD;
 		margin-bottom: 50px;
 		width: 700px;
 		height: 30px;
 	}
 	#bc{
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
#mDeleteB {
	color: red;
}
#updateB, #back {
	background: #CED8F6;
	color: black;
}
#table1 {float: right;}
</style>
</head>
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
<form name="form" method="POST" action="<c:url value='/group/manageGroup/update'>
	<c:param name="groupId" value="${Group.groupId}" />
	<c:param name="groupMemberList" value="${groupMemberList}" />
</c:url>" >

<table id="main1">
		<tr>
			<td id="bc">그룹 명(group_id: ${Group.groupId})</td>
			<td><input type="text" name="groupName" value="${Group.groupName} " ></td>
			<td id="bc">모집인원</td>
			<td> 
				<%
					int nowNumber = (Integer)request.getAttribute("nowNumber");
					if(nowNumber < 3) { nowNumber = 3; }
					request.setAttribute("nowNumOfMem", nowNumber);
				%>
				<select name="numberOfUsers">
				<c:forEach begin="${nowNumOfMem}" varStatus="status" end="10">
					<option value="${status.index}" <c:if test="${status.index == Group.numberOfUsers}"> selected </c:if>>${status.index}명</option> 
				</c:forEach>
				</select>
			</td>
			<td id="bc">기간</td>
			<td>
				<select name="term">
						<c:set var= "term" value="${Group.term}" />
						<option value="1" <c:if test="${term eq 1}"> selected </c:if>>1박2일</option> 
						<option value="2" <c:if test="${term eq 2}"> selected </c:if>>2박3일</option> 
						<option value="3" <c:if test="${term eq 3}"> selected </c:if>>3박4일</option> 
						<option value="7" <c:if test="${term eq 7}"> selected </c:if>>1주일</option> 
						<option value="30" <c:if test="${term eq 30}"> selected </c:if>>한달</option> 
						<option value="0" <c:if test="${term eq 0}"> selected </c:if>>미지정</option> 
				</select>
			</td>
		</tr>
</table>

<table id="main2">
	<tr>
	    <td id="bc">여행장소</td>
	           <td><input type="text" name="place" value="${Group.place} " ></td>          
		<td id="bc">교통수단</td>
				<td>
					<select name="trafficType">
						<c:set var="TrafficT" value="${Group.trafficType }" />
						<option <c:if test="${TrafficT eq '버스'}"> selected </c:if>>버스</option> 
						<option <c:if test="${TrafficT eq '비행기'}"> selected </c:if>>비행기</option> 
						<option <c:if test="${TrafficT eq '지하철'}"> selected </c:if>>지하철</option> 
						<option <c:if test="${TrafficT eq 'KTX'}"> selected </c:if>>KTX</option> 
						<option <c:if test="${TrafficT eq '렌트카'}"> selected </c:if>>렌트카</option> 
					</select>
				</td>
	</tr>
	<tr>
		<td id="bc">개설 일자</td>
		<td>${Group.createdDate }</td>
		<td id="bc">모집성별</td>
		<td><select name="genderType">
				<c:set var="gender" value="${Group.genderType }" />
				<c:if test="${gender eq '1'}">
					<option value="1" <c:if test="${gender eq '1'}">selected</c:if>>남성</option>
				</c:if>
				<c:if test="${gender eq '2'}">
					<option value="2" <c:if test="${gender eq '2'}">selected</c:if>>여성</option>
				</c:if>
				<option value="0" <c:if test="${gender eq '0'}">selected</c:if>>상관없음</option>
			</select></td>
	</tr>
	<tr>
		<td id="bc">팀장</td>
		<td>
			<select name="leaderId">
					<c:forEach var="member" items="${Group.groupMembers}">
						<option value="${member.user_id}"
							<c:if test="${member.user_id eq Group.leaderId}">selected</c:if>
							>${member.name}</option>
					</c:forEach>
			</select>
		
		</td>
		<td id="bc">모집나이대</td>
		<td>
			<select name="age" >
			<% 
				Group tg = (Group)request.getAttribute("Group");
				int age = Integer.valueOf(tg.getAge());
				request.setAttribute("age", age);
			%>
			<c:forEach begin="0" varStatus="status" end="${age}">
				<c:if test="${status.index != 1 }">
					<option value="${status.index}" <c:if test="${status.index == age}">selected</c:if>>				
						<c:if test="${status.index == 0 }">
							상관없음
						</c:if>
						<c:if test="${status.index == 1 }">
							10대
						</c:if>
						<c:if test="${status.index == 2 }">
							20대
						</c:if>
						<c:if test="${status.index == 3 }">
							30대
						</c:if>
						<c:if test="${status.index == 4 }">
							40대
						</c:if>
					</option>
				</c:if>
			</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<td id="bc">소개</td>
		<td><input type="text" name="description" value="${Group.description } " style="width:250px"></td>
	</tr>
</table>

<br>

<h3>팀원 리스트</h3>
<table id= "userlist">
	<tr>
		<td id="bc">이름</td>
	</tr>
	
	<c:forEach var="member" items="${Group.groupMembers}">
		<tr>
			<td>${member.name}</td>
		</tr>
	</c:forEach>
	
</table>

<table id="table1">
	<tr>
		<td><input type="button" value="저장하기" onClick="groupModify()" id="updateB"> &nbsp;</td>	
		<td><a href="<c:url value='/group/manageGroup'>
			<c:param name="groupId" value="${Group.groupId}" />
			</c:url> " id="back">돌아가기</a> </td>
	</tr>
</table>
</form>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="model.*, controller. *" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<script>
	
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
#pTable{
	margin: auto;
	width: 400px;
	height: 200px;
	text-align: center;
}
#myPost{
	text-align: center;
	
}
#bc{
	background : #CED8F6;
	color: white;
}
a{
	text-decoration: none;
}
a:link {
	color: blue;
}
a:visited {
	color: black;
}
#pUpdateB, #pDeleteB, #pListB{
	background: #E6E6E6;
	color: black;
}
#cDeleteB {
	color: blue;
}
#commL{
	border: 1px solid black;
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

<div id="onePost">
<h3 style="text-align: center;">게시글 상세보기</h3>
	
	<table id="pTable">
		<tr>
			<td id="bc">작성자</td>
			<td>${post.userName }</td>
			<td id="bc">날짜</td>
			<td>${post.createdDate }</td>
		</tr>
		<tr>
			<td id="bc">제목</td>
			<td colspan="3">${post.title }</td>
		</tr>
		<tr>
			<td rowspan="2" id="bc">내용</td>
			<td rowspan= "2" colspan="3">${post.content}</td>
		</tr>
	</table>

</div>


<br>
	<c:set var="myPost" value="${post.writer_id}" />
	<c:if test="${myPost eq userId}">
		
	<table>
		<tr>
			<td> <a href=" <c:url value= '/post/update/form' >
			<c:param name='postId' value='${post.postId}' />
			<c:param name='memberId' value="${post.writer_id}" />
			</c:url>" id="pUpdateB">게시글 수정</a></td>
			<td>&nbsp;</td>
			<td><a href="<c:url value='/post/delete'>
			<c:param name='postId' value='${post.postId}' />
			<c:param name='groupId' value='${post.group_id}' />
			<c:param name='memberId' value='${post.writer_id}' />
			</c:url>" id="pDeleteB">삭제하기</a>
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	</c:if>
	
<a href="<c:url value='/post/list'>
			<c:param name='groupId' value='${post.group_id}' />
			</c:url>" id="pListB">목록으로
</a>
<br><br>
<div id="addComment">
		
	<form name="form" method="POST" action="<c:url value='/comment/register' >
		<c:param name='groupId' value='${post.group_id}' />
		<c:param name='postId' value='${post.postId }' />
		</c:url> ">
		
		<input type="text" name="content" >
		<input type="submit" value="댓글 쓰기" />
	</form>
	
	<br>
</div>
<div id="commL">
	<c:forEach var="cm" items="${commList}" varStatus="status" >
	<table id="commentList">
		<tr>
			<td>${status.count}</td>
			<td colspan="2" style="width: 200px;">${cm.member_name}</td>
			<td>${cm.createdDate}</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2" style="width: 200px;">${cm.content}</td>
			<c:if test="${memberId eq cm.writer_id }">
			<td style="text-align:right"><a href="<c:url value='/comment/delete'>
					<c:param name='comment_id' value='${cm.comment_id}'/>
					<c:param name='member_id' value='${cm.writer_id}'/>
					<c:param name='postId' value='${post.postId }' />
					</c:url>" id="cDeleteB">삭제</a></td>
			</c:if>
		</tr>
	</table>
	<hr>
	</c:forEach>
</div>
<br><br>
</body>
</html>
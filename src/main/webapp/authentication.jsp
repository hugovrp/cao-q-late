<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Cão Q-Late</title>
	</head>
	
	<body>
		<c:if test="${ sessionScope.status != true }">
			<jsp:forward page="login.jsp"/>
		</c:if>
	</body>
</html>
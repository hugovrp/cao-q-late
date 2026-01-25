<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
   
<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Agendamentos</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="./static/css/global.css">
	    <link rel="stylesheet" href="./static/css/scheduling.css">
	</head>
	
	<body>
	    <div class="sidebar">
	        <div class="sidebar-header">
	            <h1>🐕 Cão Q-Late</h1>
	        </div>
	
	        <ul>
	            <li><a href="index.jsp">📊 <span>Dashboard</span></a></li>
	            <li><a href="client_home.jsp">👥 <span>Clientes</span></a></li>
	            <li><a href="dog_home.jsp">🐶 <span>Cães</span></a></li>
	            <li><a href="service_home.jsp">✂️ <span>Serviços</span></a></li>
	            <li><a href="scheduling_home.jsp" class="active">📅 <span>Agendamentos</span></a></li>
	            <li><a href="service_provision_home.jsp">🎯 <span>Prestar Serviços</span></a></li>
	        </ul>
	
	        <div class="sidebar-footer">
	            <c:if test="${sessionScope.status == true}">
	                <a href="controller?handler=Logout" class="logout-btn">
	                    🚪 <span>Sair</span>
	                </a>
	            </c:if>
	        </div>
	    </div>
	
	    <div class="main-content">
	        <div class="top-bar">
	            <h2>📅 Gerenciar Agendamentos</h2>
	            <a href="index.jsp" class="back-btn">← Voltar ao Dashboard</a>
	        </div>
	
	        <div id="alertBox" class="alert" 
			     data-success="${not empty param.success}" 
			     data-error="${not empty param.error}">
			</div>
	
	        <div class="actions-grid">	        
	            <div class="action-card">
	                <form action="controller" method="post">
	                	<button class="action-content">
	                		<div class="action-icon">➕</div>
			                <h3>Novo Agendamento</h3>
			                <p>Agende serviços para um cão</p>
	                	</button>
	                    <input type="hidden" name="handler" value="ShowScheduling">
	                </form>
	            </div>
	            
	            <div class="action-card">
	                <form action="controller" method="post">
	                	<button class="action-content">
	                		<div class="action-icon">📋</div>
	                        <h3>Ver Agendamentos</h3>
	                        <p>Consulte e gerencie agendamentos</p>
	                	</button>
	                    <input type="hidden" name="handler" value="ShowListScheduling">
	                </form>
	            </div>
	        </div>
	    </div>
	
		<script type="module" src="./static/js/scheduling_home.js"></script>
	</body>
</html>
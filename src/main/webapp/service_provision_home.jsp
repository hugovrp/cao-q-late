<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
   
<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Prestação de Serviços</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="./static/css/global.css">
	    <link rel="stylesheet" href="./static/css/service_provision.css">
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
	            <li><a href="scheduling_home.jsp">📅 <span>Agendamentos</span></a></li>
	            <li><a href="service_provision_home.jsp" class="active">🎯 <span>Prestar Serviços</span></a></li>
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
	            <h2>🎯 Prestação de Serviços</h2>
	            <a href="index.jsp" class="back-btn">← Voltar ao Dashboard</a>
	        </div>
	
	        <div class="intro-section">
	            <p>Gerencie a prestação de serviços do seu petshop. Registre serviços realizados e acompanhe o faturamento através de relatórios detalhados.</p>
	        </div>
	
			<div class="actions-grid">	        
	            <div class="action-card">
	                <form action="controller" method="post">
	                	<button class="action-content">
	                		<div class="action-icon">✅</div>
	                        <h3>Lançar Serviço</h3>
	                        <p>Registre a prestação de um serviço agendado e finalize o atendimento</p>
	                	</button>
	                    <input type="hidden" name="handler" value="RegisterProvision">
	                </form>
	            </div>
	            
	            <div class="action-card">
	                <form action="controller" method="post">
	                	<button class="action-content">
	                		<div class="action-icon">📊</div>
	                        <h3>Relatório de Serviços</h3>
	                        <p>Visualize relatórios de serviços prestados e acompanhe o faturamento</p>
	                	</button>
	                    <input type="hidden" name="handler" value="ShowProvision">
	                </form>
	            </div>
	        </div>
	    </div>
	</body>
</html>
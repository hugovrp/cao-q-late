<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Serviços</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	   	<link rel="stylesheet" href="./static/css/global.css">
	    <link rel="stylesheet" href="./static/css/service.css">
	</head>
	
	<body>
	    <jsp:useBean id="dao" class="br.petshop.dao.ServiceDAO"/>
	
	    <div class="sidebar">
	        <div class="sidebar-header">
	            <h1>🐕 Cão Q-Late</h1>
	        </div>
	
	        <ul>
	            <li><a href="index.jsp">📊 <span>Dashboard</span></a></li>
	            <li><a href="client_home.jsp">👥 <span>Clientes</span></a></li>
	            <li><a href="dog_home.jsp">🐶 <span>Cães</span></a></li>
	            <li><a href="service_home.jsp" class="active">✂️ <span>Serviços</span></a></li>
	            <li><a href="scheduling_home.jsp">📅 <span>Agendamentos</span></a></li>
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
	            <h2>✂️ Gerenciar Serviços</h2>
	            <a href="index.jsp" class="back-btn">← Voltar ao Dashboard</a>
	        </div>
	
	        <div class="actions-grid">
	            <a href="service_register.jsp" class="action-card">
	                <div class="action-icon">➕</div>
	                <h3>Cadastrar Serviço</h3>
	                <p>Adicione novos serviços ao catálogo</p>
	            </a>
	
	            <a href="service_search.jsp" class="action-card">
	                <div class="action-icon">✏️</div>
	                <h3>Alterar Preço</h3>
	                <p>Modifique o preço de um serviço existente</p>
	            </a>
	        </div>
	
	        <div class="table-container">
	            <div class="table-header">
	                <h3>Catálogo de Serviços</h3>
	                <c:set var="serviceList" value="${dao.service_list()}" />
	                <span class="service-count">${serviceList.size()} serviço(s)</span>
	            </div>
	
	            <div class="search-box">
	                <input type="text" id="searchInput" class="search-input" 
	                       placeholder="🔍 Buscar serviço por nome...">
	            </div>
	
	            <c:choose>
	                <c:when test="${empty serviceList}">
	                    <div class="empty-state">
	                        <div class="empty-state-icon">✂️</div>
	                        <h3>Nenhum serviço cadastrado</h3>
	                        <p>Comece adicionando serviços ao catálogo do petshop</p>
	                    </div>
	                </c:when>
	                <c:otherwise>
	                    <table id="serviceTable">
	                        <thead>
	                            <tr>
	                                <th>Nome do Serviço</th>
	                                <th>Preço</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <c:forEach var="service" items="${serviceList}">
	                                <tr>
	                                    <td><strong>${service.name}</strong></td>
	                                    <td class="price-cell">
	                                        R$ <fmt:formatNumber value="${service.price}" pattern="#,##0.00"/>
	                                    </td>
	                                </tr>
	                            </c:forEach>
	                        </tbody>
	                    </table>
	                </c:otherwise>
	            </c:choose>
	        </div>
	    </div>
	
		<script type="module" src="./static/js/service_home.js"></script>
	</body>
</html>